#!/usr/bin/env bash
set -e
cd ~/VikannsWebsite

echo "==> Adding accessible labels to all form fields..."

# ---------------------------------------------------------------------------
# sr-only CSS utility — visually hides text but keeps it screen-reader accessible
# ---------------------------------------------------------------------------
cat >> style.css << 'EOF'

/* ---------------- Screen-reader-only labels ---------------- */
.sr-only {
  position: absolute;
  width: 1px;
  height: 1px;
  padding: 0;
  margin: -1px;
  overflow: hidden;
  clip: rect(0, 0, 0, 0);
  white-space: nowrap;
  border: 0;
}
EOF

# ---------------------------------------------------------------------------
# Eligibility Checker form fields
# ---------------------------------------------------------------------------
sed -i 's|<input type="text" name="full_name" placeholder="Full Name" required>|<label for="elig-full-name" class="sr-only">Full Name</label>\n      <input type="text" id="elig-full-name" name="full_name" placeholder="Full Name" required>|' index.html
sed -i 's|<input type="email" name="email" placeholder="Email" required>|<label for="elig-email" class="sr-only">Email</label>\n      <input type="email" id="elig-email" name="email" placeholder="Email" required>|' index.html
sed -i 's|<input type="text" name="whatsapp" placeholder="WhatsApp Number" required>|<label for="elig-whatsapp" class="sr-only">WhatsApp Number</label>\n      <input type="text" id="elig-whatsapp" name="whatsapp" placeholder="WhatsApp Number" required>|' index.html
sed -i 's|<input type="number" name="age" placeholder="Age" required min="10" max="100">|<label for="elig-age" class="sr-only">Age</label>\n      <input type="number" id="elig-age" name="age" placeholder="Age" required min="10" max="100">|' index.html
sed -i 's|<input type="text" name="country_residence" placeholder="Country of Residence" required>|<label for="elig-country" class="sr-only">Country of Residence</label>\n      <input type="text" id="elig-country" name="country_residence" placeholder="Country of Residence" required>|' index.html
sed -i 's|<input type="text" name="qualification" placeholder="Highest Qualification" required>|<label for="elig-qualification" class="sr-only">Highest Qualification</label>\n      <input type="text" id="elig-qualification" name="qualification" placeholder="Highest Qualification" required>|' index.html
sed -i 's|<input type="text" name="institution" placeholder="Institution">|<label for="elig-institution" class="sr-only">Institution</label>\n      <input type="text" id="elig-institution" name="institution" placeholder="Institution">|' index.html
sed -i 's|<input type="text" name="field_of_study" placeholder="Field of Study">|<label for="elig-field" class="sr-only">Field of Study</label>\n      <input type="text" id="elig-field" name="field_of_study" placeholder="Field of Study">|' index.html
sed -i 's|<input type="text" name="grade" placeholder="Grade / GPA">|<label for="elig-grade" class="sr-only">Grade / GPA</label>\n      <input type="text" id="elig-grade" name="grade" placeholder="Grade / GPA">|' index.html
sed -i 's|<input type="text" name="graduation_year" placeholder="Graduation Year">|<label for="elig-grad-year" class="sr-only">Graduation Year</label>\n      <input type="text" id="elig-grad-year" name="graduation_year" placeholder="Graduation Year">|' index.html
sed -i 's|<select name="degree_level" required>|<label for="elig-degree-level" class="sr-only">Preferred Degree Level</label>\n      <select id="elig-degree-level" name="degree_level" required>|' index.html
sed -i 's|<input type="text" name="preferred_field" placeholder="Preferred Field">|<label for="elig-preferred-field" class="sr-only">Preferred Field</label>\n      <input type="text" id="elig-preferred-field" name="preferred_field" placeholder="Preferred Field">|' index.html
sed -i 's|<input type="text" name="preferred_intake" placeholder="Preferred Intake">|<label for="elig-preferred-intake" class="sr-only">Preferred Intake</label>\n      <input type="text" id="elig-preferred-intake" name="preferred_intake" placeholder="Preferred Intake">|' index.html
sed -i 's|<select name="english_test" required>|<label for="elig-english-test" class="sr-only">English Language Test</label>\n      <select id="elig-english-test" name="english_test" required>|' index.html
sed -i 's|<input type="text" name="annual_budget" placeholder="Approximate annual education budget" required>|<label for="elig-budget" class="sr-only">Approximate Annual Education Budget</label>\n      <input type="text" id="elig-budget" name="annual_budget" placeholder="Approximate annual education budget" required>|' index.html

# ---------------------------------------------------------------------------
# Main Contact form fields
# ---------------------------------------------------------------------------
sed -i 's|<input type="text" name="name" placeholder="Full Name" required>|<label for="contact-name" class="sr-only">Full Name</label>\n    <input type="text" id="contact-name" name="name" placeholder="Full Name" required>|' index.html
sed -i 's|<input type="email" name="email" placeholder="Email Address (optional)">|<label for="contact-email" class="sr-only">Email Address</label>\n    <input type="email" id="contact-email" name="email" placeholder="Email Address (optional)">|' index.html
sed -i 's|<input type="text" name="phone" placeholder="Phone / WhatsApp Number" required>|<label for="contact-phone" class="sr-only">Phone / WhatsApp Number</label>\n    <input type="text" id="contact-phone" name="phone" placeholder="Phone / WhatsApp Number" required>|' index.html
sed -i 's|<select name="interest">|<label for="contact-interest" class="sr-only">What are you interested in?</label>\n    <select id="contact-interest" name="interest">|' index.html
sed -i 's|<input type="text" name="destination" placeholder="Preferred Destination">|<label for="contact-destination" class="sr-only">Preferred Destination</label>\n    <input type="text" id="contact-destination" name="destination" placeholder="Preferred Destination">|' index.html
sed -i 's|<input type="text" name="intake" placeholder="Preferred Intake">|<label for="contact-intake" class="sr-only">Preferred Intake</label>\n    <input type="text" id="contact-intake" name="intake" placeholder="Preferred Intake">|' index.html
sed -i 's|<input type="text" name="qualification" placeholder="Highest Qualification">|<label for="contact-qualification" class="sr-only">Highest Qualification</label>\n    <input type="text" id="contact-qualification" name="qualification" placeholder="Highest Qualification">|' index.html
sed -i 's|<textarea name="message" placeholder="Tell us about your goals" rows="4" required></textarea>|<label for="contact-message" class="sr-only">Tell us about your goals</label>\n    <textarea id="contact-message" name="message" placeholder="Tell us about your goals" rows="4" required></textarea>|' index.html

echo "--- Verifying (should count 23 labels) ---"
grep -c "class=\"sr-only\"" index.html

git add -A
git -c user.email="site@vikanns.local" -c user.name="Vikanns Site Bot" commit -q -m "Add accessible labels to all form fields (Section 23)"
git push

echo ""
echo "Done. Live in a minute or two."

