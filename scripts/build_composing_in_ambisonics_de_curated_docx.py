#!/usr/bin/env python3
from __future__ import annotations

from pathlib import Path

from build_composing_in_ambisonics_de_docx import (
    COMBINED_HTML,
    CombinedHTMLParser,
    ImageBlock,
    OUTPUT_DOCX,
    OUTPUT_DOCX as _UNUSED_OUTPUT,
    ParagraphBlock,
    TableBlock,
    build_docx,
)


CURATED_OUTPUT = Path(
    "/Users/jschuet1/GitHub/icst-ambisonics.github.io/exports/composing-in-ambisonics-de-arbeitsfassung.docx"
)


def first_heading(blocks: list[ParagraphBlock | ImageBlock | TableBlock]) -> str:
    for block in blocks:
        if isinstance(block, ParagraphBlock) and block.kind == "h1":
            return block.text
    return "Unbenannter Beitrag"


def split_articles(
    blocks: list[ParagraphBlock | ImageBlock | TableBlock],
) -> list[list[ParagraphBlock | ImageBlock | TableBlock]]:
    articles: list[list[ParagraphBlock | ImageBlock | TableBlock]] = []
    current: list[ParagraphBlock | ImageBlock | TableBlock] = []

    for block in blocks:
        if isinstance(block, ParagraphBlock) and block.kind == "h1" and current:
            articles.append(current)
            current = [block]
        else:
            current.append(block)

    if current:
        articles.append(current)
    return articles


def make_curated_blocks(
    blocks: list[ParagraphBlock | ImageBlock | TableBlock],
) -> list[ParagraphBlock | ImageBlock | TableBlock]:
    curated: list[ParagraphBlock | ImageBlock | TableBlock] = []
    articles = split_articles(blocks)
    if articles and first_heading(articles[0]).startswith("Composing in Ambisonics"):
        articles = articles[1:]

    curated.extend(
        [
            ParagraphBlock("Composing in Ambisonics", kind="h1"),
            ParagraphBlock("Arbeitsfassung (DE)", kind="h2"),
            ParagraphBlock(
                "Zusammenstellung aller deutschsprachigen Einträge aus dem Bereich "
                "/de/composing-in-ambisonics/.",
                kind="p",
            ),
            ParagraphBlock(
                "Diese Fassung ist fürs Weiterdenken gedacht: mit Deckblatt, "
                "Inhaltsseite und Notizraum nach jedem Beitrag.",
                kind="blockquote",
            ),
            ParagraphBlock("Stand: 21.03.2026", kind="p"),
            ParagraphBlock("", kind="spacer"),
            ParagraphBlock("Inhalt", kind="h1"),
        ]
    )

    for idx, article in enumerate(articles, start=1):
        curated.append(ParagraphBlock(f"{idx}. {first_heading(article)}", kind="p"))

    curated.append(ParagraphBlock("", kind="spacer"))

    for idx, article in enumerate(articles, start=1):
        title = first_heading(article)
        curated.extend(article)
        curated.extend(
            [
                ParagraphBlock("Arbeitsnotizen", kind="h2"),
                ParagraphBlock(
                    f"Beitrag {idx}: {title}",
                    kind="blockquote",
                ),
            ]
        )
        for _ in range(8):
            curated.append(ParagraphBlock("______________________________________________", kind="p"))
        curated.append(ParagraphBlock("", kind="spacer"))

    return curated


def main() -> None:
    parser = CombinedHTMLParser()
    parser.feed(COMBINED_HTML.read_text(encoding="utf-8"))
    curated_blocks = make_curated_blocks(parser.blocks)

    # Monkey-patch the imported output path expectation in a controlled way by
    # reusing the existing writer logic on a temporary copy.
    from build_composing_in_ambisonics_de_docx import OUTPUT_DOCX as ORIGINAL_OUTPUT
    import build_composing_in_ambisonics_de_docx as base

    base.OUTPUT_DOCX = CURATED_OUTPUT
    try:
        build_docx(curated_blocks)
    finally:
        base.OUTPUT_DOCX = ORIGINAL_OUTPUT

    print(CURATED_OUTPUT)


if __name__ == "__main__":
    main()
