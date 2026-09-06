#!/usr/bin/env bash
set -e
cd ~/VikannsWebsite

echo "==> Copying certificate image from Downloads..."
cp ~/storage/downloads/vikanns-partnership-certificate.jpg images/vikanns-partnership-certificate.jpg
ls -la images/vikanns-partnership-certificate.jpg

awk '
  /<div class="video-embed-wrapper">/ { in_wrapper=1 }
  in_wrapper && /<\/div>/ {
    print
    print "  <figure class=\"partnership-proof\">"
    print "    <img src=\"images/vikanns-partnership-certificate.jpg\" alt=\"Certificate confirming Vikanns partnership for the 2026/2027 intake\" loading=\"lazy\">"
    print "    <figcaption>Verified partnership certificate for the 2026/2027 intake</figcaption>"
    print "  </figure>"
    in_wrapper=0
    next
  }
  { print }
' index.html > index_tmp.html && mv index_tmp.html index.html

cat >> style.css << 'EOF'

/* ---------------- Partnership certificate proof ---------------- */
.partnership-proof {
  max-width: 340px;
  margin: 20px auto;
  text-align: center;
}
.partnership-proof img {
  width: 100%;
  border-radius: 10px;
  box-shadow: 0 6px 18px rgba(0,0,0,0.15);
  display: block;
}
.partnership-proof figcaption {
  font-size: 0.8rem;
  color: var(--muted);
  margin-top: 8px;
}
EOF

echo "--- Verifying ---"
grep -n "partnership-proof\|vikanns-partnership-certificate" index.html

git add -A
git -c user.email="site@vikanns.local" -c user.name="Vikanns Site Bot" commit -q -m "Add partnership certificate as proof for the 2026/2027 intake"
git push

echo "Done. Live in a minute or two."

