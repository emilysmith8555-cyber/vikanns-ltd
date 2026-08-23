#!/usr/bin/env bash
set -e
cd ~/VikannsWebsite

sed -i '/<label class="booking-label">Choose your date<\/label>/d' index.html
sed -i '/<label class="booking-label">Choose your time<\/label>/d' index.html
sed -i 's|<input type="text" id="bookDate" placeholder="e.g. 15 March 2026">|<input type="text" id="bookDate" placeholder="Choose your date (e.g. 15 March 2026)">|' index.html
sed -i 's|<input type="text" id="bookTime" placeholder="e.g. 2:00 PM">|<input type="text" id="bookTime" placeholder="Choose your time (e.g. 2:00 PM)">|' index.html

echo "--- Verifying ---"
sed -n '/id="booking"/,/<\/section>/p' index.html

git add -A
git -c user.email="site@vikanns.local" -c user.name="Vikanns Site Bot" commit -q -m "Remove outside labels from booking date/time fields, move guidance into placeholder like the service dropdown"
git push

echo "Done. Live in a minute or two."

