#!/usr/bin/env bash
set -e
cd ~/VikannsWebsite

cat >> style.css << 'EOF'

/* ---------------- Certificate badge in footer (responsive, overrides earlier rule) ---------------- */
.footer-certificate {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  gap: 8px;
  margin: 24px auto;
  max-width: 260px;
  text-align: center;
}
.footer-certificate img {
  width: 90px;
  height: auto;
  border-radius: 6px;
  box-shadow: 0 2px 8px rgba(0,0,0,0.3);
}
.footer-certificate span {
  font-size: 0.75rem;
  color: rgba(255,255,255,0.8);
  line-height: 1.3;
}
@media (min-width: 768px) {
  .footer-certificate img { width: 110px; }
  .footer-certificate span { font-size: 0.82rem; }
}
@media (min-width: 1200px) {
  .footer-certificate img { width: 130px; }
  .footer-certificate span { font-size: 0.88rem; }
}
EOF

echo "--- Verifying ---"
grep -n -A20 "overrides earlier rule" style.css

git add -A
git -c user.email="site@vikanns.local" -c user.name="Vikanns Site Bot" commit -q -m "Fix footer certificate badge: stacked layout, proper responsive sizing for mobile/tablet/desktop"
git push

echo "Done. Live in a minute or two."

