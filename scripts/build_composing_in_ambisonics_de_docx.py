#!/usr/bin/env python3
from __future__ import annotations

import re
import zipfile
from dataclasses import dataclass
from html.parser import HTMLParser
from pathlib import Path
from urllib.parse import unquote, urlparse
from xml.sax.saxutils import escape


ROOT = Path("/Users/jschuet1/GitHub/icst-ambisonics.github.io")
COMBINED_HTML = ROOT / "exports" / "composing-in-ambisonics-de-gesamt.html"
OUTPUT_DOCX = ROOT / "exports" / "composing-in-ambisonics-de-gesamt-mit-bildern.docx"
MAX_IMAGE_WIDTH_EMU = 5_700_000
EMU_PER_PIXEL = 9525


@dataclass
class ParagraphBlock:
    text: str
    kind: str = "p"


@dataclass
class ImageBlock:
    path: Path
    caption: str = ""
    alt: str = ""


@dataclass
class TableBlock:
    rows: list[list[str]]


def normalize_ws(text: str) -> str:
    text = text.replace("\xa0", " ")
    text = re.sub(r"[ \t\r\f\v]+", " ", text)
    text = re.sub(r" *\n *", "\n", text)
    return text.strip()


def resolve_image_path(src: str) -> Path | None:
    src = unquote(src)
    if src.startswith("file://"):
        return Path(urlparse(src).path)
    if src.startswith("http://localhost:1313/"):
        rel = src.removeprefix("http://localhost:1313/")
        return ROOT / "public" / rel
    return None


class CombinedHTMLParser(HTMLParser):
    def __init__(self) -> None:
        super().__init__(convert_charrefs=True)
        self.blocks: list[ParagraphBlock | ImageBlock | TableBlock] = []
        self.current_tag: str | None = None
        self.current_text: list[str] = []
        self.list_stack: list[str] = []
        self.ol_counters: list[int] = []
        self.in_figure = False
        self.figure_image: Path | None = None
        self.figure_alt = ""
        self.figure_caption_parts: list[str] = []
        self.in_figcaption = False
        self.table_rows: list[list[str]] | None = None
        self.current_row: list[str] | None = None
        self.current_cell: list[str] | None = None
        self.skip_depth = 0
        self.current_href: str | None = None

    def handle_starttag(self, tag: str, attrs_list: list[tuple[str, str | None]]) -> None:
        attrs = dict(attrs_list)
        if tag == "section" and attrs.get("class") == "toc":
            self.skip_depth = 1
            return
        if self.skip_depth:
            self.skip_depth += 1
            return

        if tag in {"h1", "h2", "h3", "h4", "p", "blockquote"}:
            self.current_tag = tag
            self.current_text = []
        elif tag == "ul":
            self.list_stack.append("ul")
        elif tag == "ol":
            self.list_stack.append("ol")
            self.ol_counters.append(0)
        elif tag == "li":
            prefix = ""
            if self.list_stack:
                if self.list_stack[-1] == "ul":
                    prefix = "- "
                else:
                    self.ol_counters[-1] += 1
                    prefix = f"{self.ol_counters[-1]}. "
            self.current_tag = "li"
            self.current_text = [prefix]
        elif tag == "br":
            self.current_text.append("\n")
        elif tag == "a":
            self.current_href = attrs.get("href")
        elif tag == "figure":
            self.in_figure = True
            self.figure_image = None
            self.figure_alt = ""
            self.figure_caption_parts = []
        elif tag == "img":
            img_path = resolve_image_path(attrs.get("src", ""))
            alt = attrs.get("alt", "") or ""
            if self.in_figure:
                self.figure_image = img_path
                self.figure_alt = alt
            elif img_path:
                self.blocks.append(ImageBlock(path=img_path, alt=alt))
        elif tag == "figcaption":
            self.in_figcaption = True
        elif tag == "hr":
            self.blocks.append(ParagraphBlock(text="", kind="spacer"))
        elif tag == "table":
            self.table_rows = []
        elif tag == "tr":
            self.current_row = []
        elif tag in {"th", "td"}:
            self.current_cell = []

    def handle_endtag(self, tag: str) -> None:
        if self.skip_depth:
            self.skip_depth -= 1
            return

        if tag in {"h1", "h2", "h3", "h4", "p", "blockquote", "li"} and self.current_tag == tag:
            text = normalize_ws("".join(self.current_text))
            if text:
                self.blocks.append(ParagraphBlock(text=text, kind=tag))
            self.current_tag = None
            self.current_text = []
        elif tag == "ul":
            if self.list_stack:
                self.list_stack.pop()
        elif tag == "ol":
            if self.list_stack:
                self.list_stack.pop()
            if self.ol_counters:
                self.ol_counters.pop()
        elif tag == "a":
            self.current_href = None
        elif tag == "figcaption":
            self.in_figcaption = False
        elif tag == "figure":
            if self.figure_image:
                caption = normalize_ws("".join(self.figure_caption_parts))
                self.blocks.append(
                    ImageBlock(path=self.figure_image, caption=caption, alt=self.figure_alt)
                )
            self.in_figure = False
            self.figure_image = None
            self.figure_alt = ""
            self.figure_caption_parts = []
        elif tag in {"th", "td"}:
            if self.current_row is not None and self.current_cell is not None:
                self.current_row.append(normalize_ws("".join(self.current_cell)))
            self.current_cell = None
        elif tag == "tr":
            if self.table_rows is not None and self.current_row:
                self.table_rows.append(self.current_row)
            self.current_row = None
        elif tag == "table":
            if self.table_rows:
                self.blocks.append(TableBlock(rows=self.table_rows))
            self.table_rows = None

    def handle_data(self, data: str) -> None:
        if self.skip_depth:
            return
        if self.in_figcaption:
            self.figure_caption_parts.append(data)
            return
        if self.current_cell is not None:
            self.current_cell.append(data)
            return
        if self.current_tag:
            self.current_text.append(data)


def image_dimensions(path: Path) -> tuple[int, int]:
    suffix = path.suffix.lower()
    data = path.read_bytes()

    if suffix == ".png" and data.startswith(b"\x89PNG\r\n\x1a\n"):
        return int.from_bytes(data[16:20], "big"), int.from_bytes(data[20:24], "big")
    if suffix == ".gif" and data[:6] in {b"GIF87a", b"GIF89a"}:
        return int.from_bytes(data[6:8], "little"), int.from_bytes(data[8:10], "little")
    if suffix in {".jpg", ".jpeg"}:
        i = 2
        while i < len(data) - 9:
            if data[i] != 0xFF:
                i += 1
                continue
            marker = data[i + 1]
            if marker in {0xC0, 0xC1, 0xC2, 0xC3, 0xC5, 0xC6, 0xC7, 0xC9, 0xCA, 0xCB, 0xCD, 0xCE, 0xCF}:
                height = int.from_bytes(data[i + 5 : i + 7], "big")
                width = int.from_bytes(data[i + 7 : i + 9], "big")
                return width, height
            if marker in {0xD8, 0xD9}:
                i += 2
                continue
            length = int.from_bytes(data[i + 2 : i + 4], "big")
            i += 2 + length
    if suffix == ".svg":
        text = data.decode("utf-8", "ignore")
        view_box = re.search(r'viewBox="[^"]*?([\d.]+)[ ,]+([\d.]+)[ ,]+([\d.]+)[ ,]+([\d.]+)"', text)
        width_attr = re.search(r'width="([\d.]+)(px)?"', text)
        height_attr = re.search(r'height="([\d.]+)(px)?"', text)
        if width_attr and height_attr:
            return max(1, int(float(width_attr.group(1)))), max(1, int(float(height_attr.group(1))))
        if view_box:
            return max(1, int(float(view_box.group(3)))), max(1, int(float(view_box.group(4))))
    return 1200, 800


def paragraph_xml(text: str, *, size: int = 22, bold: bool = False, italic: bool = False,
                  spacing_after: int = 140, left_indent: int = 0) -> str:
    escaped = escape(text)
    run_props = [
        '<w:rFonts w:ascii="Helvetica Neue" w:hAnsi="Helvetica Neue" w:cs="Helvetica Neue"/>',
        f'<w:sz w:val="{size}"/>',
        f'<w:sz-cs w:val="{size}"/>',
    ]
    if bold:
        run_props.append("<w:b/>")
    if italic:
        run_props.append("<w:i/>")

    parts = []
    for idx, line in enumerate(escaped.split("\n")):
        if idx:
            parts.append("<w:br/>")
        if line:
            parts.append(f'<w:t xml:space="preserve">{line}</w:t>')

    ppr = [f'<w:spacing w:after="{spacing_after}"/>']
    if left_indent:
        ppr.append(f'<w:ind w:left="{left_indent}"/>')
    return (
        "<w:p>"
        f"<w:pPr>{''.join(ppr)}</w:pPr>"
        f"<w:r><w:rPr>{''.join(run_props)}</w:rPr>{''.join(parts)}</w:r>"
        "</w:p>"
    )


def page_break_xml() -> str:
    return "<w:p><w:r><w:br w:type=\"page\"/></w:r></w:p>"


def image_xml(rel_id: str, width_px: int, height_px: int, docpr_id: int, name: str) -> str:
    width_emu = min(width_px * EMU_PER_PIXEL, MAX_IMAGE_WIDTH_EMU)
    scale = width_emu / max(1, width_px * EMU_PER_PIXEL)
    height_emu = max(1, int(height_px * EMU_PER_PIXEL * scale))
    return f"""
<w:p>
  <w:r>
    <w:drawing>
      <wp:inline distT="0" distB="0" distL="0" distR="0" xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main" xmlns:pic="http://schemas.openxmlformats.org/drawingml/2006/picture">
        <wp:extent cx="{width_emu}" cy="{height_emu}"/>
        <wp:docPr id="{docpr_id}" name="{escape(name)}"/>
        <wp:cNvGraphicFramePr>
          <a:graphicFrameLocks noChangeAspect="1"/>
        </wp:cNvGraphicFramePr>
        <a:graphic>
          <a:graphicData uri="http://schemas.openxmlformats.org/drawingml/2006/picture">
            <pic:pic>
              <pic:nvPicPr>
                <pic:cNvPr id="0" name="{escape(name)}"/>
                <pic:cNvPicPr/>
              </pic:nvPicPr>
              <pic:blipFill>
                <a:blip r:embed="{rel_id}"/>
                <a:stretch><a:fillRect/></a:stretch>
              </pic:blipFill>
              <pic:spPr>
                <a:xfrm>
                  <a:off x="0" y="0"/>
                  <a:ext cx="{width_emu}" cy="{height_emu}"/>
                </a:xfrm>
                <a:prstGeom prst="rect"><a:avLst/></a:prstGeom>
              </pic:spPr>
            </pic:pic>
          </a:graphicData>
        </a:graphic>
      </wp:inline>
    </w:drawing>
  </w:r>
</w:p>
""".strip()


def build_docx(blocks: list[ParagraphBlock | ImageBlock | TableBlock]) -> None:
    body_parts: list[str] = []
    doc_rels: list[str] = []
    content_type_defaults = {
        "rels": "application/vnd.openxmlformats-package.relationships+xml",
        "xml": "application/xml",
        "png": "image/png",
        "jpg": "image/jpeg",
        "jpeg": "image/jpeg",
        "gif": "image/gif",
        "svg": "image/svg+xml",
    }
    media_files: list[tuple[str, Path]] = []
    image_cache: dict[Path, tuple[str, str]] = {}
    next_rel = 1
    next_docpr = 1
    first_h1 = True

    for block in blocks:
        if isinstance(block, ParagraphBlock):
            kind = block.kind
            if kind == "spacer":
                body_parts.append(paragraph_xml("", spacing_after=120))
            elif kind == "h1":
                if not first_h1:
                    body_parts.append(page_break_xml())
                first_h1 = False
                body_parts.append(paragraph_xml(block.text, size=36, bold=True, spacing_after=260))
            elif kind == "h2":
                body_parts.append(paragraph_xml(block.text, size=28, bold=True, spacing_after=220))
            elif kind == "h3":
                body_parts.append(paragraph_xml(block.text, size=24, bold=True, spacing_after=180))
            elif kind == "h4":
                body_parts.append(paragraph_xml(block.text, size=22, bold=True, spacing_after=160))
            elif kind == "blockquote":
                body_parts.append(paragraph_xml(block.text, italic=True, left_indent=420, spacing_after=160))
            else:
                body_parts.append(paragraph_xml(block.text, size=22, spacing_after=140))
        elif isinstance(block, TableBlock):
            if block.rows:
                for row_index, row in enumerate(block.rows):
                    text = " | ".join(cell for cell in row if cell)
                    if text:
                        body_parts.append(
                            paragraph_xml(
                                text,
                                size=20 if row_index else 21,
                                bold=(row_index == 0),
                                spacing_after=100,
                            )
                        )
                body_parts.append(paragraph_xml("", spacing_after=120))
        elif isinstance(block, ImageBlock):
            if not block.path.exists():
                caption = block.caption or block.alt or f"Bilddatei nicht gefunden: {block.path.name}"
                body_parts.append(paragraph_xml(caption, italic=True, spacing_after=120))
                continue
            if block.path not in image_cache:
                ext = block.path.suffix.lower().lstrip(".")
                media_name = f"image{len(media_files) + 1}.{ext}"
                rel_id = f"rId{next_rel}"
                next_rel += 1
                media_files.append((media_name, block.path))
                doc_rels.append(
                    f'<Relationship Id="{rel_id}" '
                    'Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/image" '
                    f'Target="media/{media_name}"/>'
                )
                image_cache[block.path] = (rel_id, media_name)
            rel_id, media_name = image_cache[block.path]
            width_px, height_px = image_dimensions(block.path)
            body_parts.append(image_xml(rel_id, width_px, height_px, next_docpr, media_name))
            next_docpr += 1
            caption = block.caption or block.alt
            if caption:
                body_parts.append(paragraph_xml(caption, size=18, italic=True, spacing_after=180))

    document_xml = f"""<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<w:document xmlns:wpc="http://schemas.microsoft.com/office/word/2010/wordprocessingCanvas"
 xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
 xmlns:o="urn:schemas-microsoft-com:office:office"
 xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships"
 xmlns:m="http://schemas.openxmlformats.org/officeDocument/2006/math"
 xmlns:v="urn:schemas-microsoft-com:vml"
 xmlns:wp14="http://schemas.microsoft.com/office/word/2010/wordprocessingDrawing"
 xmlns:wp="http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing"
 xmlns:w10="urn:schemas-microsoft-com:office:word"
 xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main"
 xmlns:w14="http://schemas.microsoft.com/office/word/2010/wordml"
 xmlns:wpg="http://schemas.microsoft.com/office/word/2010/wordprocessingGroup"
 xmlns:wpi="http://schemas.microsoft.com/office/word/2010/wordprocessingInk"
 xmlns:wne="http://schemas.microsoft.com/office/word/2006/wordml"
 xmlns:wps="http://schemas.microsoft.com/office/word/2010/wordprocessingShape"
 mc:Ignorable="w14 wp14">
  <w:body>
    {''.join(body_parts)}
    <w:sectPr>
      <w:pgSz w:w="11906" w:h="16838"/>
      <w:pgMar w:top="1440" w:right="1134" w:bottom="1440" w:left="1134" w:header="708" w:footer="708" w:gutter="0"/>
    </w:sectPr>
  </w:body>
</w:document>"""

    rels_xml = """<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">
  <Relationship Id="rIdMain" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument" Target="word/document.xml"/>
</Relationships>"""

    doc_rels_xml = """<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">
  {rels}
</Relationships>""".format(rels="".join(doc_rels))

    defaults_xml = "".join(
        f'<Default Extension="{ext}" ContentType="{ctype}"/>'
        for ext, ctype in sorted(content_type_defaults.items())
    )
    overrides_xml = (
        '<Override PartName="/word/document.xml" '
        'ContentType="application/vnd.openxmlformats-officedocument.wordprocessingml.document.main+xml"/>'
    )
    content_types_xml = f"""<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types">
  {defaults_xml}
  {overrides_xml}
</Types>"""

    with zipfile.ZipFile(OUTPUT_DOCX, "w", compression=zipfile.ZIP_DEFLATED) as zf:
        zf.writestr("[Content_Types].xml", content_types_xml)
        zf.writestr("_rels/.rels", rels_xml)
        zf.writestr("word/document.xml", document_xml)
        zf.writestr("word/_rels/document.xml.rels", doc_rels_xml)
        for media_name, src_path in media_files:
            zf.write(src_path, f"word/media/{media_name}")


def main() -> None:
    parser = CombinedHTMLParser()
    parser.feed(COMBINED_HTML.read_text(encoding="utf-8"))
    build_docx(parser.blocks)
    print(OUTPUT_DOCX)


if __name__ == "__main__":
    main()
