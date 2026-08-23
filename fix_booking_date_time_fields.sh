#!/usr/bin/env bash
set -e
cd ~/VikannsWebsite

sed -i 's|<input type="date" id="bookDate">|<input type="text" id="bookDate" placeholder="e.g. 15 March 2026">|' index.html
sed -i 's|<input type="time" id="bookTime">|<input type="text" id="bookTime" placeholder="e.g. 2:00 PM">|' index.html

echo "--- Verifying ---"
sed -n '/id="booking"/,/<\/section>/p' index.html

git add -A
git -c user.email="site@vikanns.local" -c user.name="Vikanns Site Bot" commit -q -m "Replace native date/time pickers with plain text fields for consistent styling in booking form"
git push

echo "Done. Live in a minute or two."

