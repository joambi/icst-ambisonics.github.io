#!/usr/bin/env python3
from __future__ import annotations

import html
import re
from pathlib import Path
from urllib.parse import unquote


ROOT = Path("/Users/jschuet1/GitHub/icst-ambisonics.github.io")
PUBLIC_DE = ROOT / "public" / "de" / "composing-in-ambisonics"
PUBLIC_ROOT = ROOT / "public"
OUTPUT_HTML = ROOT / "exports" / "composing-in-ambisonics-de-gesamt.html"

ARTICLE_ORDER = [
    "01_overview",
    "02-analytisches-hoeren",
    "03-geschichte-von-foa-und-hoa",
    "04-die-10-fragen",
    "05-die-akustische-gestalt",
    "05-spatial-counterpoint",
    "055-psychoakustik",
    "06-raumparameter",
    "065-vergleich-kompositorischer-raumstrategien",
    "07-studiopraxis-am-icst",
    "073-room-capture",
    "075-raumpartitur",
    "08-werkzeuge-und-software",
    "082-binaural-delivery",
    "084-formats-archiving",
    "085-werkanalysen",
    "0852-analysis-template",
    "0855-repertoire-guide",
    "086-performance-practice",
    "088-live-elektronik",
    "09-referenzen",
    "090-vr-und-installation",
    "10-glossar",
]


def extract_article_body(page_html: str) -> str:
    article_match = re.search(
        r'<article class="docs__content post">(.*?)</article>',
        page_html,
        flags=re.S,
    )
    if not article_match:
        raise ValueError("Article block not found")

    article_html = article_match.group(1)
    start = article_html.find("<h1")
    if start == -1:
        raise ValueError("First heading not found")

    end = article_html.find('<div class="docs__pagination"', start)
    if end == -1:
        end = len(article_html)

    return article_html[start:end].strip()


def rewrite_paths(fragment: str) -> str:
    def replace_src(match: re.Match[str]) -> str:
        attr = match.group(1)
        quote = match.group(2)
        value = html.unescape(match.group(3))
        decoded_value = unquote(value)

        if decoded_value.startswith("/"):
            local_path = PUBLIC_ROOT / decoded_value.lstrip("/")
            if local_path.exists():
                value = local_path.resolve().as_uri()
            else:
                value = f"http://localhost:1313{decoded_value}"

        return f"{attr}={quote}{html.escape(value, quote=True)}{quote}"

    fragment = re.sub(r'(src|href)=(["\'])(.*?)\2', replace_src, fragment, flags=re.S)
    fragment = re.sub(r'<div class="hero__links".*?</div>\s*', "", fragment, flags=re.S)
    fragment = re.sub(r'<div class="home-cards".*?</div>\s*', "", fragment, flags=re.S)

    fragment = re.sub(
        r'<div[^>]*>\s*<iframe[^>]*src=(["\'])(.*?)\1[^>]*></iframe>\s*</div>',
        lambda m: (
            '<p><em>Video eingebettet im Originalbeitrag:</em> '
            f'<a href="{html.escape(html.unescape(m.group(2)), quote=True)}">'
            f'{html.escape(html.unescape(m.group(2)))}'
            "</a></p>"
        ),
        fragment,
        flags=re.S,
    )

    fragment = re.sub(r'\s+loading=(["\']).*?\1', "", fragment)
    fragment = re.sub(r'\s+decoding=(["\']).*?\1', "", fragment)
    return fragment


def build_document() -> str:
    entries = []
    toc = []

    for slug in ARTICLE_ORDER:
        html_path = PUBLIC_DE / slug / "index.html"
        page_html = html_path.read_text(encoding="utf-8")
        body = rewrite_paths(extract_article_body(page_html))

        heading_match = re.search(r"<h1[^>]*>(.*?)</h1>", body, flags=re.S)
        title = re.sub(r"<.*?>", "", heading_match.group(1)).strip() if heading_match else slug
        toc.append((slug, title))
        entries.append(
            f'<section class="entry" id="{html.escape(slug)}">\n'
            f"{body}\n"
            "</section>"
        )

    toc_html = "\n".join(
        f'<li><a href="#{html.escape(slug)}">{html.escape(title)}</a></li>'
        for slug, title in toc
    )
    return f"""<!doctype html>
<html lang="de">
<head>
  <meta charset="utf-8" />
  <title>Composing in Ambisonics (DE) – Sammeldokument</title>
  <style>
    body {{
      font-family: -apple-system, BlinkMacSystemFont, "Helvetica Neue", Helvetica, Arial, sans-serif;
      line-height: 1.45;
      margin: 2.4cm 2cm;
      color: #111;
    }}
    h1, h2, h3, h4 {{
      page-break-after: avoid;
    }}
    h1 {{
      font-size: 24pt;
      margin: 0 0 0.5em 0;
    }}
    h2 {{
      font-size: 18pt;
      margin-top: 1.4em;
    }}
    h3 {{
      font-size: 14pt;
      margin-top: 1.1em;
    }}
    p, li {{
      font-size: 11pt;
    }}
    img {{
      max-width: 100%;
      height: auto;
    }}
    figure {{
      margin: 1.1em 0;
      page-break-inside: avoid;
    }}
    figcaption {{
      font-size: 9.5pt;
      color: #444;
    }}
    hr {{
      margin: 1.5em 0;
      border: none;
      border-top: 1px solid #ccc;
    }}
    .cover {{
      page-break-after: always;
    }}
    .meta {{
      color: #555;
      font-size: 10pt;
    }}
    .toc {{
      page-break-after: always;
    }}
    .entry {{
      page-break-before: always;
    }}
    .docs__pagination, .hero__links, .home-card__actions {{
      display: none;
    }}
    a {{
      color: #0b57d0;
      text-decoration: none;
    }}
    blockquote {{
      border-left: 3px solid #ccc;
      margin-left: 0;
      padding-left: 1em;
      color: #333;
    }}
    table {{
      border-collapse: collapse;
      width: 100%;
    }}
    th, td {{
      border: 1px solid #ddd;
      padding: 6px 8px;
      vertical-align: top;
      font-size: 10pt;
    }}
  </style>
</head>
<body>
  <section class="cover">
    <h1>Composing in Ambisonics (DE)</h1>
    <p class="meta">Sammeldokument aller deutschsprachigen Einträge aus dem Bereich <code>/de/composing-in-ambisonics/</code>.</p>
    <p class="meta">Exportiert aus den lokal gerenderten Seiten des Projekts, inklusive Bilder, Schemata und eingebetteter Abbildungsbeschriftungen.</p>
    <p class="meta">Stand: 21.03.2026</p>
  </section>
  <section class="toc">
    <h2>Inhalt</h2>
    <ol>
      {toc_html}
    </ol>
  </section>
  {"".join(entries)}
</body>
</html>
"""


def main() -> None:
    OUTPUT_HTML.parent.mkdir(parents=True, exist_ok=True)
    OUTPUT_HTML.write_text(build_document(), encoding="utf-8")
    print(OUTPUT_HTML)


if __name__ == "__main__":
    main()
