#!/usr/bin/env bash
set -e
cd ~/VikannsWebsite

echo "==> Replacing the offer video with the new edited version..."
cp ~/storage/downloads/vikanns-offer-v2.mp4 videos/vikanns-offer.mp4
ls -la videos/vikanns-offer.mp4

git add -A
git -c user.email="site@vikanns.local" -c user.name="Vikanns Site Bot" commit -q -m "Replace intake offer video with newly edited version"
git push

echo ""
echo "Done. This uploads a large file so it may take a while \u2014 don't close Termux until it finishes."

