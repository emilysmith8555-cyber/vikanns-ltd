#!/usr/bin/env bash
set -e
cd ~/VikannsWebsite

echo "==> Building the combined Eligibility + Services page..."

# ---------------------------------------------------------------------------
# 1. Create eligibility.html
# ---------------------------------------------------------------------------
cat > eligibility.html << 'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Check Your Study Abroad Eligibility | Vikanns Ltd</title>
<meta name="description" content="Check your study abroad eligibility and explore Vikanns' services: admissions, visa guidance, education funding, proof of funds, and academic advisory.">
<meta name="robots" content="index, follow">
<meta property="og:title" content="Check Your Study Abroad Eligibility | Vikanns Ltd">
<meta property="og:description" content="Check your study abroad eligibility and explore Vikanns' services: admissions, visa guidance, education funding, proof of funds, and academic advisory.">
<meta property="og:type" content="website">
<meta property="og:image" content="https://vikanns.com/images/team-green.jpg">
<link rel="canonical" href="https://vikanns.com/eligibility.html">
<link rel="icon" type="image/png" href="images/logo.png">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
<link rel="stylesheet" href="style.css">
</head>
<body>
<header>
  <nav class="navbar">
    <div class="logo">
      <a href="index.html" style="display:flex;align-items:center;gap:10px;text-decoration:none;">
        <img src="images/logo.png" alt="Vikanns Ltd logo" class="logo-img"><span class="logo-text">Vikanns Ltd</span>
      </a>
    </div>
    <ul class="nav-links" id="navLinks">
      <li><a href="index.html#home">Home</a></li>
      <li><a href="eligibility.html#eligibility">Check Eligibility</a></li>
      <li><a href="eligibility.html#services">Services</a></li>
      <li><a href="index.html#destinations">Destinations</a></li>
      <li><a href="index.html#resources">Resources</a></li>
      <li><a href="index.html#contact">Contact</a></li>
    </ul>
    <div class="nav-right">
      <a href="index.html#contact" class="btn-primary nav-cta">Start Your Journey</a>
      <button class="menu-toggle" aria-label="Toggle navigation menu" onclick="toggleMenu()">&#9776;</button>
    </div>
  </nav>
</header>

<section id="eligibility" class="eligibility reveal">
  <h2>Check Your Study Abroad Eligibility</h2>
  <p class="section-lead">Answer a few questions and discover which study pathways may fit your profile.</p>
  <p class="wa-alt"><a href="https://wa.me/2347032751486?text=Hello%20Vikanns%2C%20I%20would%20like%20to%20check%20my%20study%20abroad%20eligibility." target="_blank" rel="noopener"><i class="fa-brands fa-whatsapp"></i> Prefer WhatsApp? Chat with us instead</a></p>
  <form id="eligibilityForm" class="eligibility-form" action="https://formspree.io/f/xqpzlewe" method="POST">
    <input type="hidden" name="form_type" value="Eligibility Checker">
    <input type="text" name="_gotcha" style="display:none" tabindex="-1" autocomplete="off">
    <p class="elig-progress" id="eligProgressText">Step 1 of 7</p>

    <div class="elig-step active" data-step="1">
      <h3>Personal Information</h3>
      <label for="elig-full-name" class="sr-only">Full Name</label>
      <input type="text" id="elig-full-name" name="full_name" placeholder="Full Name" required pattern="[A-Za-z&#39;.\-\s]{2,}" title="Please enter a valid name using letters only">
      <label for="elig-email" class="sr-only">Email</label>
      <input type="email" id="elig-email" name="email" placeholder="Email" required>
      <label for="elig-whatsapp" class="sr-only">WhatsApp Number</label>
      <input type="tel" id="elig-whatsapp" name="whatsapp" placeholder="WhatsApp Number" required pattern="[0-9+\-\s()]{7,}" title="Please enter a valid phone number">
      <label for="elig-age" class="sr-only">Age</label>
      <input type="number" id="elig-age" name="age" placeholder="Age" required min="10" max="100">
      <label for="elig-country" class="sr-only">Country of Residence</label>
      <input type="text" id="elig-country" name="country_residence" placeholder="Country of Residence" required pattern="[A-Za-z\-\s]{2,}" title="Please enter a valid country name using letters only">
    </div>

    <div class="elig-step" data-step="2">
      <h3>Academic Background</h3>
      <label for="elig-qualification" class="sr-only">Highest Qualification</label>
      <input type="text" id="elig-qualification" name="qualification" placeholder="Highest Qualification" required>
      <label for="elig-institution" class="sr-only">Institution</label>
      <input type="text" id="elig-institution" name="institution" placeholder="Institution">
      <label for="elig-field" class="sr-only">Field of Study</label>
      <input type="text" id="elig-field" name="field_of_study" placeholder="Field of Study">
      <label for="elig-grade" class="sr-only">Grade / GPA</label>
      <input type="text" id="elig-grade" name="grade" placeholder="Grade / GPA">
      <label for="elig-grad-year" class="sr-only">Graduation Year</label>
      <input type="text" id="elig-grad-year" name="graduation_year" placeholder="Graduation Year">
    </div>

    <div class="elig-step" data-step="3">
      <h3>Study Preference</h3>
      <label for="elig-degree-level" class="sr-only">Preferred Degree Level</label>
      <select id="elig-degree-level" name="degree_level" required>
        <option value="">Preferred Degree Level</option>
        <option>Bachelor's</option>
        <option>Master's</option>
        <option>MRes</option>
        <option>PhD</option>
        <option>Professional</option>
        <option>Vocational</option>
        <option>Certificate</option>
      </select>
      <label for="elig-preferred-field" class="sr-only">Preferred Field</label>
      <input type="text" id="elig-preferred-field" name="preferred_field" placeholder="Preferred Field">
      <label for="elig-preferred-intake" class="sr-only">Preferred Intake</label>
      <input type="text" id="elig-preferred-intake" name="preferred_intake" placeholder="Preferred Intake">
    </div>

    <div class="elig-step" data-step="4">
      <h3>Destination</h3>
      <p class="elig-hint">Select all that interest you:</p>
      <label><input type="checkbox" name="destination_uk" value="United Kingdom" class="elig-dest"> United Kingdom</label>
      <label><input type="checkbox" name="destination_canada" value="Canada" class="elig-dest"> Canada</label>
      <label><input type="checkbox" name="destination_nz" value="New Zealand" class="elig-dest"> New Zealand</label>
      <label><input type="checkbox" name="destination_nl" value="Netherlands" class="elig-dest"> Netherlands</label>
      <label><input type="checkbox" name="destination_eu" value="Other Europe" class="elig-dest"> Other Europe</label>
      <label><input type="checkbox" name="destination_other" value="Other" class="elig-dest"> Other</label>
    </div>

    <div class="elig-step" data-step="5">
      <h3>English Language</h3>
      <label for="elig-english-test" class="sr-only">English Language Test</label>
      <select id="elig-english-test" name="english_test" required>
        <option value="">Select an option</option>
        <option>IELTS</option>
        <option>TOEFL</option>
        <option>PTE</option>
        <option>Duolingo</option>
        <option>Other</option>
        <option>Not yet taken</option>
      </select>
    </div>

    <div class="elig-step" data-step="6">
      <h3>Budget</h3>
      <label for="elig-budget" class="sr-only">Approximate Annual Education Budget</label>
      <input type="text" id="elig-budget" name="annual_budget" placeholder="Approximate annual education budget" required>
    </div>

    <div class="elig-step" data-step="7">
      <h3>Your Preliminary Study Profile</h3>
      <div id="eligResultCards"></div>
      <p class="elig-disclaimer">This assessment provides preliminary guidance only. Final eligibility depends on the institution, programme, immigration authority and applicable requirements.</p>
      <button type="submit" class="btn-primary">Speak With a Vikanns Adviser</button>
    </div>

    <div class="elig-nav">
      <button type="button" id="eligBack" class="btn-outline">Back</button>
      <button type="button" id="eligNext" class="btn-primary">Next</button>
    </div>
  </form>
</section>

<section id="services" class="services reveal">
  <h2>What We Do</h2>
  <p class="section-lead">Solutions designed around your goals. Vikanns provides practical support across education, international opportunities and advisory services.</p>
  <div class="swipe-carousel">
    <div class="swipe-card">
      <i class="fa-solid fa-graduation-cap swipe-icon"></i>
      <span class="service-num">01</span>
      <h3>Study Abroad &amp; Admissions</h3>
      <p class="service-tagline">Find the right academic pathway.</p>
      <p>We guide students through identifying suitable programmes, institutions and destinations based on their academic background, career goals and budget.</p>
      <p class="list-lead">Our support can include:</p>
      <ul>
        <li>Bachelor's programmes</li>
        <li>Master's programmes</li>
        <li>MRes and postgraduate routes</li>
        <li>Professional and vocational programmes</li>
        <li>Certificate programmes</li>
        <li>Course and destination selection</li>
        <li>Application preparation and submission</li>
      </ul>
      <a href="index.html#contact" class="btn-outline">Find My Programme</a>
      <a href="https://wa.me/2347032751486?text=Hello%20Vikanns%2C%20I%20would%20like%20help%20choosing%20a%20study%20programme." target="_blank" rel="noopener" class="wa-alt-link"><i class="fa-brands fa-whatsapp"></i> Or WhatsApp us</a>
    </div>
    <div class="swipe-card">
      <i class="fa-solid fa-plane swipe-icon"></i>
      <span class="service-num">02</span>
      <h3>Visa Guidance &amp; Application Support</h3>
      <p class="service-tagline">Prepare with clarity and confidence.</p>
      <p>We help students understand visa requirements and organise their applications carefully.</p>
      <p class="list-lead">Our guidance can include:</p>
      <ul>
        <li>Document preparation</li>
        <li>Financial documentation guidance</li>
        <li>Application guidance</li>
        <li>Visa documentation review</li>
        <li>Interview preparation</li>
        <li>Pre-departure guidance</li>
      </ul>
      <p class="disclaimer-inline">We do not guarantee visa outcomes. Instead, we help you understand the requirements and prepare a complete, well-organised application.</p>
      <a href="index.html#contact" class="btn-outline">Get Visa Guidance</a>
      <a href="https://wa.me/2347032751486?text=Hello%20Vikanns%2C%20I%20would%20like%20guidance%20with%20my%20student%20visa%20preparation." target="_blank" rel="noopener" class="wa-alt-link"><i class="fa-brands fa-whatsapp"></i> Or WhatsApp us</a>
    </div>
    <div class="swipe-card">
      <i class="fa-solid fa-sack-dollar swipe-icon"></i>
      <span class="service-num">03</span>
      <h3>Education Funding</h3>
      <p class="service-tagline">Explore ways to finance your education.</p>
      <p>Funding international education can be one of the biggest challenges students face. Vikanns helps eligible students explore available funding options, including study loans and other education financing solutions.</p>
      <p class="list-lead">We help you understand:</p>
      <ul>
        <li>Available funding options</li>
        <li>Eligibility requirements</li>
        <li>Loan documentation</li>
        <li>Repayment considerations</li>
        <li>Proof-of-funds requirements</li>
      </ul>
      <a href="index.html#contact" class="btn-outline">Explore Funding</a>
    </div>
    <div class="swipe-card">
      <i class="fa-solid fa-file-invoice-dollar swipe-icon"></i>
      <span class="service-num">04</span>
      <h3>Proof of Funds Guidance</h3>
      <p class="service-tagline">Make your financial documentation part of the plan.</p>
      <p>Proof of funds is evidence that you (or your sponsor) can cover your tuition and living costs \u2014 many institutions and immigration authorities require this before approving your application.</p>
      <ul>
        <li>What proof of funds means for your destination</li>
        <li>Why institutions and authorities may require it</li>
        <li>Legitimate documentation and financial evidence</li>
        <li>Common mistakes applicants make</li>
        <li>Destination-specific considerations</li>
      </ul>
      <p class="service-tagline">Legitimate documentation. Transparent process. Compliance with applicable requirements.</p>
      <a href="index.html#contact" class="btn-outline">Speak With an Adviser</a>
    </div>
    <div class="swipe-card">
      <i class="fa-solid fa-compass swipe-icon"></i>
      <span class="service-num">05</span>
      <h3>Academic &amp; Career Advisory</h3>
      <p class="service-tagline">Don't choose a course simply because it is available. Choose a pathway that makes sense for your future.</p>
      <p>We help students think beyond admission by considering their academic background, career direction, destination, budget and long-term goals.</p>
      <a href="index.html#contact" class="btn-outline">Book a Consultation</a>
    </div>
  </div>
</section>

<footer>
  <div class="footer-grid">
    <div class="footer-col">
      <img src="images/logo.png" alt="Vikanns Ltd logo" class="footer-logo-img">
      <p>People. Ideas. Possibilities.</p>
      <p>Creating pathways to education, opportunity and a better future.</p>
    </div>
    <div class="footer-col">
      <h4>Quick Links</h4>
      <a href="index.html#home">Home</a>
      <a href="index.html#destinations">Destinations</a>
      <a href="index.html#resources">Resources</a>
      <a href="index.html#contact">Contact</a>
    </div>
    <div class="footer-col">
      <h4>Contact</h4>
      <a href="https://www.google.com/maps/search/?api=1&query=Vikanns+Ltd+Abuja+Nigeria" target="_blank" rel="noopener">Abuja, Nigeria</a>
      <p>+234 703 275 1486</p>
      <p>+234 816 384 8822</p>
    </div>
  </div>
  <p class="footer-disclaimer">Vikanns Ltd provides education, advisory and application support services. We do not guarantee admission, visa approval, funding approval or any immigration outcome. Final decisions are made by the relevant educational institutions, financial institutions and government authorities.</p>
  <p class="footer-copyright">&copy; <span id="year"></span> Vikanns Ltd. All rights reserved.</p>
</footer>
<a href="https://wa.me/2347032751486" class="whatsapp-float" target="_blank" rel="noopener" aria-label="Chat With Vikanns"><i class="fa-brands fa-whatsapp"></i></a>
<script src="script.js"></script>
</body>
</html>
EOF

# ---------------------------------------------------------------------------
# 2. Remove BOTH sections from the homepage (leaving About, Destinations,
#    everything else exactly where they are)
# ---------------------------------------------------------------------------
awk '
  /<section id="eligibility" class="eligibility reveal">/ { skip=1 }
  skip && /<\/section>/ { skip=0; next }
  skip { next }
  { print }
' index.html > index_tmp.html && mv index_tmp.html index.html

awk '
  /<section id="services" class="services reveal">/ { skip=1 }
  skip && /<\/section>/ { skip=0; next }
  skip { next }
  { print }
' index.html > index_tmp.html && mv index_tmp.html index.html

# ---------------------------------------------------------------------------
# 3. Update every remaining reference on the homepage (buttons, nav, footer)
#    that used to point to #eligibility / #services
# ---------------------------------------------------------------------------
sed -i 's|href="#eligibility"|href="eligibility.html#eligibility"|g' index.html
sed -i 's|href="#services"|href="eligibility.html#services"|g' index.html

# ---------------------------------------------------------------------------
# 4. Update every OTHER page on the site (destinations, articles, legal)
#    that links to index.html#eligibility / index.html#services
# ---------------------------------------------------------------------------
for f in uk.html canada.html new-zealand.html netherlands.html europe.html \
         how-to-choose-country.html uk-vs-new-zealand.html how-education-funding-works.html \
         understanding-proof-of-funds.html how-to-prepare-for-student-visa.html how-to-choose-the-right-course.html \
         privacy-policy.html terms.html cookie-policy.html disclaimer.html \
         refund-policy.html funding-disclaimer.html visa-disclaimer.html; do
  if [ -f "$f" ]; then
    sed -i 's|index\.html#eligibility|eligibility.html#eligibility|g' "$f"
    sed -i 's|index\.html#services|eligibility.html#services|g' "$f"
  fi
done

echo "--- Verifying ---"
ls -la eligibility.html
echo "--- Homepage: confirm both sections removed ---"
grep -n "id=\"eligibility\"\|id=\"services\"" index.html || echo "Confirmed removed from homepage."
echo "--- Homepage: confirm links updated ---"
grep -n "eligibility.html" index.html
echo "--- Spot-check one destination page ---"
grep -n "eligibility.html" uk.html

git add -A
git -c user.email="site@vikanns.local" -c user.name="Vikanns Site Bot" commit -q -m "Split Eligibility Checker + Services into a combined dedicated page, update all links site-wide"
git push

echo ""
echo "Done. Live in a minute or two."

