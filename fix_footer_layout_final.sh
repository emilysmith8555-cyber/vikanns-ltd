#!/usr/bin/env bash
set -e
cd ~/VikannsWebsite

cat >> style.css << 'EOF'

/* ================= Footer layout: final authoritative rules ================= */
/* Phones and tablets: brand alone, then three side-by-side pairs */
.footer-grid {
  grid-template-columns: 1fr 1fr;
  gap: 24px 30px;
}
.footer-grid .footer-col:nth-child(1) { grid-column: 1 / -1; }
.footer-grid .footer-col:nth-child(2) { grid-column: 1; }
.footer-grid .footer-col:nth-child(3) { grid-column: 2; }
.footer-grid .footer-col:nth-child(4) { grid-column: 1; }
.footer-grid .footer-col:nth-child(5) { grid-column: 2; }
.footer-grid .footer-col:nth-child(6) { grid-column: 1; }
.footer-grid .footer-col:nth-child(7) { grid-column: 2; }
.footer-col a, .footer-col p { overflow-wrap: anywhere; }

/* Keep the side-by-side pairing even on very narrow phones */
@media (max-width: 420px) {
  .footer-grid { grid-template-columns: 1fr 1fr; }
}

/* Desktop: everything in one row so the footer is not spread out */
@media (min-width: 1024px) {
  .footer-grid {
    grid-template-columns: 1.4fr repeat(6, 1fr);
    max-width: 1300px;
  }
  .footer-grid .footer-col:nth-child(n) { grid-column: auto; }
}

/* ---------------- Footer social icons: even, centred circles ---------------- */
.footer-social {
  display: flex;
  justify-content: center;
  align-items: center;
  flex-wrap: wrap;
  gap: 16px;
  margin: 20px 0;
}
.footer-social a {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  width: 42px;
  height: 42px;
  border-radius: 50%;
  background: rgba(255,255,255,0.12);
  color: #ffffff;
  font-size: 1.2rem;
  transition: background 0.2s;
}
.footer-social a:hover { background: rgba(255,255,255,0.25); }
EOF

echo "--- Verifying ---"
grep -n "Footer layout: final authoritative rules" style.css
grep -c "footer-col:nth-child" style.css

git add -A
git -c user.email="site@vikanns.local" -c user.name="Vikanns Site Bot" commit -q -m "Fix footer: proper side-by-side pairing, one-row desktop layout, tidy social icons"
git push

echo "Done. Live in a minute or two."

