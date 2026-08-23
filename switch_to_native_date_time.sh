#!/usr/bin/env bash
set -e
cd ~/VikannsWebsite

sed -i 's|<input type="text" id="bookDate" placeholder="Choose your date (e.g. 15 March 2026)">|<input type="date" id="bookDate">|' index.html
sed -i 's|<input type="text" id="bookTime" placeholder="Choose your time (e.g. 2:00 PM)">|<input type="time" id="bookTime">|' index.html

echo "--- Verifying ---"
sed -n '/id="booking"/,/<\/section>/p' index.html

git add -A
git -c user.email="site@vikanns.local" -c user.name="Vikanns Site Bot" commit -q -m "Switch booking date/time back to native pickers for real tap-to-select input"
git push

echo "Done. Live in a minute or two."

