import re,sys,pathlib
src=pathlib.Path(sys.argv[1]); out=pathlib.Path(sys.argv[2]); media=sys.argv[3]
s=src.read_text(encoding='utf-8')
m=re.match(r'---\n(.*?)\n---\n',s,re.S); fm=m.group(1); s=s[m.end():]
title=re.search(r'^title:\s*(.*)$',fm,re.M).group(1).strip().strip('"')
def video(mt):
    attrs=dict(re.findall(r'(\w+)="([^"]*)"',mt.group(1)))
    n=attrs['name']; cap=attrs.get('caption','')
    auto=' autoplay muted' if attrs.get('autoplay')=='true' else ''
    poster=f' poster="{media}/{n}-poster.png"' if attrs.get('poster')!='false' else ''
    h=f'<figure class="video"><video controls loop playsinline preload="metadata"{auto}{poster} src="{media}/{n}.mp4" style="max-width:100%"></video>'
    if cap: h+=f'<figcaption>{cap}</figcaption>'
    return h+'</figure>'
s=re.sub(r'\{\{<\s*video\s+(.*?)\s*>\}\}',video,s)
s=re.sub(r'\{\{<\s*notice\s+(\w+)\s*>\}\}',lambda m:f'<div class="notice notice-{m.group(1)}">\n',s)
s=re.sub(r'\{\{<\s*/notice\s*>\}\}','\n</div>',s)
s=re.sub(r'<!--.*?-->','',s,flags=re.S)
out.write_text(f'% {title}\n\n'+s,encoding='utf-8')
