#!/usr/bin/env bash
set -e
cd ~/VikannsWebsite

# 1. Remove the large certificate block from the intake-offer section
awk '
  /<figure class="partnership-proof">/ { skip=1 }
  skip && /<\/figure>/ { skip=0; next }
  skip { next }
  { print }
' index.html > index_tmp.html && mv index_tmp.html index.html

# 2. Add a small version to the footer, right before the social icons row
sed -i 's|  <div class="footer-social">|  <div class="footer-certificate">\n    <img src="images/vikanns-partnership-certificate.jpg" alt="Certificate confirming Vikanns partnership for the 2026/2027 intake" loading="lazy">\n    <span>Verified partnership \u2014 2026/2027 intake</span>\n  </div>\n  <div class="footer-social">|' index.html

cat >> style.css << 'EOF'

/* ---------------- Small certificate badge in footer ---------------- */
.footer-certificate {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 10px;
  margin: 20px auto;
  max-width: 320px;
}
.footer-certificate img {
  width: 60px;
  height: auto;
  border-radius: 6px;
  box-shadow: 0 2px 8px rgba(0,0,0,0.25);
}
.footer-certificate span {
  font-size: 0.78rem;
  color: rgba(255,255,255,0.8);
}
EOF

echo "--- Verifying ---"
grep -n "partnership-proof\|footer-certificate" index.html

git add -A
git -c user.email="site@vikanns.local" -c user.name="Vikanns Site Bot" commit -q -m "Move partnership certificate to a small footer badge instead of a large mid-page image"
git push

echo "Done. Live in a minute or two."
