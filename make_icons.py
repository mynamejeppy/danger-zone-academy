# Draws the app icon (a probe thermometer) and saves the PNG sizes the web app manifest and iOS need.
# Run once: python make_icons.py
from pathlib import Path
from PIL import Image, ImageDraw

INK, PAPER, HOT, TICK = "#13201c", "#e9eeed", "#c33d28", "#9fb2ab"
S = 1024  # draw large, then downscale for smooth edges
out = Path(__file__).parent / "icons"
out.mkdir(exist_ok=True)

img = Image.new("RGB", (S, S), INK)
d = ImageDraw.Draw(img)
cx = S // 2
# glass stem and bulb
d.rounded_rectangle([cx - 64, 190, cx + 64, 700], radius=64, fill=PAPER)
d.ellipse([cx - 128, 612, cx + 128, 868], fill=PAPER)
# mercury
d.rounded_rectangle([cx - 30, 300, cx + 30, 760], radius=30, fill=HOT)
d.ellipse([cx - 92, 648, cx + 92, 832], fill=HOT)
# tick marks
for i, y in enumerate(range(250, 640, 65)):
    w = 70 if i % 2 == 0 else 44
    d.rounded_rectangle([cx + 96, y - 8, cx + 96 + w, y + 8], radius=8, fill=TICK)

for size, name in [(512, "icon-512.png"), (192, "icon-192.png"), (180, "apple-touch-icon.png")]:
    img.resize((size, size), Image.LANCZOS).save(out / name, optimize=True)
print("Saved icons to", out)
