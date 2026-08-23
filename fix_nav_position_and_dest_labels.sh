#!/usr/bin/env bash
set -e
cd ~/VikannsWebsite

# 1. Destination tiles: "Learn More →" -> "Explore Destination"
sed -i 's|Learn More \&rarr;|Explore Destination|g' index.html

# 2. Regroup the hamburger toggle next to the CTA button at the right edge,
#    instead of them being 3 separate flex items (which centers the middle one)
awk '
  /<nav class="navbar">/ { print; next }
  /<div class="logo">/ { print; next }
  /<button class="menu-toggle"/ { next }
  /<ul class="nav-links" id="navLinks">/ { print; in_ul=1; next }
  in_ul && /<\/ul>/ {
    print
    print "    <div class=\"nav-right\">"
    print "      <a href=\"#contact\" class=\"btn-primary nav-cta\">Start Your Journey</a>"
    print "      <button class=\"menu-toggle\" aria-label=\"Toggle navigation menu\" onclick=\"toggleMenu()\">&#9776;</button>"
    print "    </div>"
    in_ul=0
    next
  }
  /<a href="#contact" class="btn-primary nav-cta">Start Your Journey<\/a>/ { next }
  { print }
' index.html > index_tmp.html && mv index_tmp.html index.html

cat >> style.css << 'EOF'

/* ---------------- Group nav CTA + hamburger at the right edge ---------------- */
.nav-right { display: flex; align-items: center; gap: 12px; }
EOF

echo "--- Verifying ---"
grep -c "Explore Destination" index.html
sed -n '/<nav class="navbar">/,/<\/nav>/p' index.html

git add -A
git -c user.email="site@vikanns.local" -c user.name="Vikanns Site Bot" commit -q -m "Fix hamburger nav position (group with CTA at right edge), update destination tile labels to Explore Destination"
git push

echo "Done. Live in a minute or two."

