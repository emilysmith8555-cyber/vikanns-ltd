#!/usr/bin/env bash
set -e
cd ~/VikannsWebsite

echo "==> Copying video from Downloads..."
mkdir -p videos
cp ~/storage/downloads/vikanns-offer.mp4 videos/vikanns-offer.mp4
ls -la videos/vikanns-offer.mp4

# Insert the offer section right after the hero
awk '
  /<\/section>/ && !inserted && seen_hero {
    print
    print ""
    print "<!-- ============================ INTAKE OFFER (update/remove monthly) ============================ -->"
    print "<section id=\"intake-offer\" class=\"intake-offer reveal\">"
    print "  <span class=\"offer-badge\">This Month\x27s Update</span>"
    print "  <h2>Applications Now Open: Secure Your Spot for the Jan/Feb 2027 France Intake</h2>"
    print "  <p class=\"section-lead\">Watch our latest update on this intake, cost considerations, and current opportunities available through Vikanns \u2014 everything you need to know before you apply.</p>"
    print "  <video controls preload=\"none\" poster=\"images/team-green.jpg\" class=\"offer-video\">"
    print "    <source src=\"videos/vikanns-offer.mp4\" type=\"video/mp4\">"
    print "    Your browser does not support the video tag."
    print "  </video>"
    print "  <div class=\"center-btn\"><a href=\"#eligibility\" class=\"btn-primary\">Check My Eligibility</a></div>"
    print "</section>"
    inserted=1
    next
  }
  /id="home" class="hero"/ { seen_hero=1 }
  { print }
' index.html > index_tmp.html && mv index_tmp.html index.html

cat >> style.css << 'EOF'

/* ---------------- Intake Offer video section (temporal / ad-like) ---------------- */
.intake-offer { text-align: center; }
.offer-badge {
  display: inline-block;
  background: #FFCC00;
  color: #1a1a1a;
  font-weight: 800;
  font-size: 0.75rem;
  letter-spacing: 0.5px;
  text-transform: uppercase;
  padding: 6px 16px;
  border-radius: 20px;
  margin-bottom: 14px;
}
.offer-video {
  width: 100%;
  max-width: 480px;
  height: auto;
  border-radius: 14px;
  box-shadow: 0 10px 28px rgba(0,0,0,0.18);
  margin: 20px auto;
  display: block;
}
@media (min-width: 900px) {
  .offer-video { max-width: 640px; }
}
@media (min-width: 1400px) {
  .offer-video { max-width: 760px; }
}
EOF

echo "--- Verifying ---"
grep -n "id=\"intake-offer\"\|offer-badge\|Jan/Feb 2027\|vikanns-offer.mp4" index.html

git add -A
git -c user.email="site@vikanns.local" -c user.name="Vikanns Site Bot" commit -q -m "Add monthly Intake Offer video section (responsive, badged as temporal)"
git push

echo ""
echo "Done. This push includes a ~50MB file so it may take a while \u2014 don't close Termux until it finishes."

