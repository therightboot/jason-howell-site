#!/usr/bin/env bash
# ============================================================
# get-images.sh — makes the site fully independent of Wix.
#
# Downloads every photo from the Wix CDN into assets/img/
# and rewrites index.html to use the local copies.
#
# Run this ONCE, BEFORE cancelling the Wix subscription:
#     ./get-images.sh
# ============================================================
set -euo pipefail
cd "$(dirname "$0")"

BASE="https://static.wixstatic.com/media"
mkdir -p assets/img

FILES=(
  # covers, portrait, signature
  "dbbf19_eb99b2c74c3d4c80b517bbd53f573c83~mv2.jpg"
  "dbbf19_ad65ec9d81654634a25d91dc9a5c19a4~mv2.jpg"
  "dbbf19_f26917fa011c4a2e89f87155e0c958c6~mv2.jpg"
  "dbbf19_bff4a6604c0040af9939f14da6d7d9d6~mv2.png"
  # gallery
  "dbbf19_f180311d64ca4d0cb7d2a1b24f323532~mv2.jpg"
  "dbbf19_6147b5d6199541898fb1048ddacb3d36~mv2.jpg"
  "dbbf19_16ac9171f4ad44b7bce165f01b285758~mv2.jpg"
  "dbbf19_b9e9b75b04b34388811d264dc6bc2dc9~mv2.jpg"
  "dbbf19_ea3becbb579f4913a5ed712b684490ff~mv2.jpg"
  "dbbf19_a663c895a6274752b6d095c23127568f~mv2.jpg"
  "dbbf19_5b3d46ecb2504856b7b1c67ad8122e15~mv2.jpg"
  "dbbf19_ec50edb4cdf8482d917ea405efb945f2~mv2.jpg"
  "dbbf19_f484a88265664ebaa23864c302918900~mv2.jpg"
  "dbbf19_c53d30a89ae1409ba7272c3c1beee7fb~mv2.jpg"
  "dbbf19_65368844bbd04574a9ab593abca8d323~mv2.jpg"
  "dbbf19_92d6d667b8f14227adc923bfefd35602~mv2.jpg"
  "dbbf19_7998c6eb8d8d4db4a50647b456868860~mv2.jpg"
  "dbbf19_7efb1e9f5f414a0288384053111f8088~mv2.jpg"
  "dbbf19_8e86263b46aa4c3db9fa4202fa9e427b~mv2.jpg"
  "dbbf19_e9815caf0ae14c6d9d491acafa5c08db~mv2.jpg"
  "dbbf19_fee9513adb8a4b1b81bad8a84d619e8e~mv2.jpg"
  "dbbf19_807923dadcb94afaba332deda360bf3e~mv2.jpg"
  "dbbf19_eae88a7c273648fa8a93cd3c270641c8~mv2.jpg"
  "dbbf19_7cbef23508b34dda868159eeb5411591~mv2.jpg"
  "dbbf19_a8c902d4c4b74d34bd1e01675d3b8bde~mv2.jpg"
  "dbbf19_284f65f908594783a00f3900c2b6c744~mv2.jpg"
)

echo "Downloading ${#FILES[@]} images from Wix CDN..."
n=0
for f in "${FILES[@]}"; do
  n=$((n+1))
  if [ -f "assets/img/$f" ]; then
    echo "  [$n/${#FILES[@]}] already have $f"
  else
    echo "  [$n/${#FILES[@]}] $f"
    curl -fL --retry 3 --silent --show-error -o "assets/img/$f" "$BASE/$f"
  fi
done

# Optional: downscale large photos to a sensible web size (macOS only).
if command -v sips >/dev/null 2>&1; then
  echo "Optimising image sizes (max 1800px)..."
  for f in assets/img/*.jpg; do
    sips --resampleHeightWidthMax 1800 "$f" >/dev/null 2>&1 || true
  done
fi

# Point index.html at the local copies instead of the Wix CDN.
sed -i.bak 's#https://static.wixstatic.com/media/#assets/img/#g' index.html
rm -f index.html.bak

echo ""
echo "Done. All images are now local in assets/img/"
echo "index.html has been updated — the site no longer depends on Wix."
echo "Deploy the whole folder (index.html + assets/), then Wix can be cancelled."
