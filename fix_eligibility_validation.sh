#!/usr/bin/env bash
set -e
cd ~/VikannsWebsite

sed -i "s|if (!f.value) { f.reportValidity(); return; }|if (!f.checkValidity()) { f.reportValidity(); return; }|" script.js

echo "--- Verifying ---"
grep -n -A6 "requiredFields" script.js

git add -A
git -c user.email="site@vikanns.local" -c user.name="Vikanns Site Bot" commit -q -m "Fix eligibility form validation to actually check field validity, not just non-empty"
git push

echo "Done. Live in a minute or two."

