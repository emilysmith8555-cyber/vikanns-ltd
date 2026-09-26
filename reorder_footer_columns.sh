#!/usr/bin/env bash
set -e
cd ~/VikannsWebsite

# 1. Swap Destinations and Resources so the pairing works out correctly
awk '
  /<h4>Destinations<\/h4>/ {
    print "    <div class=\"footer-col\">"
    print "      <h4>Resources</h4>"
    print "      <a href=\"how-to-choose-country.html\">Choosing a Country</a>"
    print "      <a href=\"uk-vs-new-zealand.html\">UK vs New Zealand</a>"
    print "      <a href=\"how-education-funding-works.html\">How Funding Works</a>"
    print "      <a href=\"understanding-proof-of-funds.html\">Proof of Funds</a>"
    print "      <a href=\"how-to-prepare-for-student-visa.html\">Visa Preparation</a>"
    print "      <a href=\"how-to-choose-the-right-course.html\">Choosing a Course</a>"
    print "    </div>"
    print "    <div class=\"footer-col\">"
    print "      <h4>Destinations</h4>"
    print "      <a href=\"uk.html\">United Kingdom</a>"
    print "      <a href=\"canada.html\">Canada</a>"
    print "      <a href=\"new-zealand.html\">New Zealand</a>"
    print "      <a href=\"netherlands.html\">Netherlands</a>"
    print "      <a href=\"europe.html\">Europe &amp; Beyond</a>"
    print "    </div>"
    skip=1
    next
  }
  skip && /<\/div>/ { skip=0; next }
  skip { next }
  { print }
' index.html > index_tmp.html && mv index_tmp.html index.html

# 2. Make the brand column span full width on its own row, so the
#    remaining 6 columns pair up correctly as: Quick Links+Services,
#    Legal+Resources, Destinations+Contact
sed -i 's|grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));|grid-template-columns: repeat(2, 1fr);|' style.css

cat >> style.css << 'EOF'

/* ---------------- Footer: brand spans full width, rest pair up ---------------- */
.footer-grid .footer-col:first-child {
  grid-column: 1 / -1;
}
@media (max-width: 420px) {
  .footer-grid { grid-template-columns: 1fr; }
}
@media (min-width: 1024px) {
  .footer-grid { grid-template-columns: repeat(3, 1fr); }
  .footer-grid .footer-col:first-child { grid-column: auto; }
}
EOF

echo "--- Verifying ---"
grep -n "<h4>" index.html
grep -n "footer-col:first-child" -A3 style.css

git add -A
git -c user.email="site@vikanns.local" -c user.name="Vikanns Site Bot" commit -q -m "Reorder footer columns for clean pairing, fix brand column to span full width"
git push

echo "Done. Live in a minute or two."

