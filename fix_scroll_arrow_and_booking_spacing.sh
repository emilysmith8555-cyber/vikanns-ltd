#!/usr/bin/env bash
set -e
cd ~/VikannsWebsite

# 1. Fix the scroll-top button's actual bottom position (it never changed before)
sed -i '447s|bottom: 24px;|bottom: 94px;|' style.css

# 2. Fix the booking label spacing (remove the negative margin causing overlap)
sed -i 's|.booking-label { font-size: 0.85rem; font-weight: 600; color: var(--green-dark); margin-bottom: -6px; }|.booking-label { font-size: 0.85rem; font-weight: 600; color: var(--green-dark); margin-bottom: 2px; margin-top: 4px; }|' style.css

echo "--- Verifying ---"
grep -n -A6 "scroll-top-btn {" style.css
echo "---"
grep -n "booking-label {" style.css

git add -A
git -c user.email="site@vikanns.local" -c user.name="Vikanns Site Bot" commit -q -m "Actually fix scroll-top button overlap with WhatsApp icon, fix booking label spacing"
git push

echo "Done. Live in a minute or two."

