#!/usr/bin/env bash
set -e
cd ~/VikannsWebsite

# 1. Remove the Stories section from the homepage
awk '
  /<section id="stories" class="stories reveal">/ { skip=1 }
  skip && /<\/section>/ { skip=0; next }
  skip { next }
  { print }
' index.html > index_tmp.html && mv index_tmp.html index.html

# 2. Insert it into eligibility.html, right above the Eligibility Checker section
awk '
  /<section id="eligibility" class="eligibility reveal">/ && !inserted {
    print "<section id=\"stories\" class=\"stories reveal\">"
    print "  <h2>Real People. Real Journeys. Real Possibilities.</h2>"
    print "  <p class=\"section-lead\">Every student has a different starting point.</p>"
    print "  <p class=\"stories-list\">Different grades.<br>Different budgets.<br>Different dreams.<br>Different challenges.</p>"
    print "  <p>But with the right information and guidance, a clearer pathway can emerge.</p>"
    print "  <p class=\"stories-cta-line\"><strong>Your story could be next.</strong></p>"
    print "  <div class=\"center-btn\"><a href=\"index.html#contact\" class=\"btn-primary\">Start Your Journey</a></div>"
    print "</section>"
    print ""
    inserted=1
  }
  { print }
' eligibility.html > eligibility_tmp.html && mv eligibility_tmp.html eligibility.html

echo "--- Verifying ---"
grep -n "id=\"stories\"" index.html || echo "Confirmed removed from homepage."
grep -n "id=\"stories\"\|id=\"eligibility\"" eligibility.html

git add -A
git -c user.email="site@vikanns.local" -c user.name="Vikanns Site Bot" commit -q -m "Move Student Stories section to eligibility.html, positioned above the Eligibility Checker"
git push

echo "Done. Live in a minute or two."

