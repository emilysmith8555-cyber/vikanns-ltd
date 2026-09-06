#!/usr/bin/env bash
set -e
cd ~/VikannsWebsite

# Eligibility form
sed -i 's|<input type="text" id="elig-full-name" name="full_name" placeholder="Full Name" required>|<input type="text" id="elig-full-name" name="full_name" placeholder="Full Name" required pattern="[A-Za-z\x27\.\-\s]{2,}" title="Please enter a valid name using letters only">|' index.html
sed -i 's|<input type="text" id="elig-whatsapp" name="whatsapp" placeholder="WhatsApp Number" required>|<input type="tel" id="elig-whatsapp" name="whatsapp" placeholder="WhatsApp Number" required pattern="[0-9+\-\s()]{7,}" title="Please enter a valid phone number">|' index.html
sed -i 's|<input type="text" id="elig-country" name="country_residence" placeholder="Country of Residence" required>|<input type="text" id="elig-country" name="country_residence" placeholder="Country of Residence" required pattern="[A-Za-z\-\s]{2,}" title="Please enter a valid country name using letters only">|' index.html

# Contact form
sed -i 's|<input type="text" id="contact-name" name="name" placeholder="Full Name" required>|<input type="text" id="contact-name" name="name" placeholder="Full Name" required pattern="[A-Za-z\x27\.\-\s]{2,}" title="Please enter a valid name using letters only">|' index.html
sed -i 's|<input type="text" id="contact-phone" name="phone" placeholder="Phone / WhatsApp Number" required>|<input type="tel" id="contact-phone" name="phone" placeholder="Phone / WhatsApp Number" required pattern="[0-9+\-\s()]{7,}" title="Please enter a valid phone number">|' index.html

echo "--- Verifying ---"
grep -n "elig-full-name\|elig-whatsapp\|elig-country\|contact-name\"\|contact-phone" index.html

git add -A
git -c user.email="site@vikanns.local" -c user.name="Vikanns Site Bot" commit -q -m "Add real format validation (pattern rules) for name, phone, and country fields"
git push

echo "Done. Live in a minute or two."

