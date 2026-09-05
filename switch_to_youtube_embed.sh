#!/usr/bin/env bash
set -e
cd ~/VikannsWebsite

# 1. Replace the <video> element with a responsive YouTube embed
awk '
  /<video controls/ { skip=1 }
  skip {
    if (/<\/video>/) {
      print "  <div class=\"video-embed-wrapper\">"
      print "    <iframe src=\"https://www.youtube.com/embed/7zFB3gIJAy0\" title=\"Vikanns Intake Update\" frameborder=\"0\" allow=\"accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share\" allowfullscreen loading=\"lazy\"></iframe>"
      print "  </div>"
      skip=0
    }
    next
  }
  { print }
' index.html > index_tmp.html && mv index_tmp.html index.html

# 2. Add responsive embed styling
cat >> style.css << 'EOF'

/* ---------------- Responsive YouTube embed for Intake Offer ---------------- */
.video-embed-wrapper {
  position: relative;
  width: 100%;
  max-width: 480px;
  margin: 20px auto;
  aspect-ratio: 16 / 9;
  border-radius: 14px;
  overflow: hidden;
  box-shadow: 0 10px 28px rgba(0,0,0,0.18);
}
.video-embed-wrapper iframe {
  position: absolute;
  inset: 0;
  width: 100%;
  height: 100%;
  border: 0;
}
@media (min-width: 900px) {
  .video-embed-wrapper { max-width: 640px; }
}
@media (min-width: 1400px) {
  .video-embed-wrapper { max-width: 760px; }
}
EOF

# 3. Remove the large video file from the repo going forward
git rm --cached videos/vikanns-offer.mp4 2>/dev/null || true
rm -f videos/vikanns-offer.mp4
rmdir videos 2>/dev/null || true

echo "--- Verifying ---"
grep -n "youtube.com/embed\|video-embed-wrapper" index.html

git add -A
git -c user.email="site@vikanns.local" -c user.name="Vikanns Site Bot" commit -q -m "Switch intake offer video to a YouTube embed, remove large video file from repo"
git push

echo "Done. Live in a minute or two \u2014 and future pushes should be fast again."

