function toggleMenu() {
  document.getElementById('navLinks').classList.toggle('open');
}

(function () {
  const slides = document.querySelectorAll('.hero-slideshow .slide');
  let current = 0;
  if (slides.length > 1) {
    setInterval(() => {
      slides[current].classList.remove('active');
      current = (current + 1) % slides.length;
      slides[current].classList.add('active');
    }, 4500);
  }
})();

document.querySelectorAll('.nav-links a').forEach(link => {
  link.addEventListener('click', () => {
    document.getElementById('navLinks').classList.remove('open');
  });
});

document.getElementById('year').textContent = new Date().getFullYear();

const revealEls = document.querySelectorAll('.reveal');
const observer = new IntersectionObserver((entries) => {
  entries.forEach(entry => {
    if (entry.isIntersecting) {
      entry.target.classList.add('visible');
      observer.unobserve(entry.target);
    }
  });
}, { threshold: 0.12 });
revealEls.forEach(el => observer.observe(el));

// Close the mobile menu when tapping anywhere outside it
document.addEventListener('click', function (event) {
  const navLinks = document.getElementById('navLinks');
  const toggleBtn = document.querySelector('.menu-toggle');
  if (!navLinks || !toggleBtn) return;
  const isOpen = navLinks.classList.contains('open');
  const clickedInsideNav = navLinks.contains(event.target);
  const clickedToggle = toggleBtn.contains(event.target);
  if (isOpen && !clickedInsideNav && !clickedToggle) {
    navLinks.classList.remove('open');
  }
});

// Our Values floating image slideshow
(function () {
  const vSlides = document.querySelectorAll('.values-slideshow .v-slide');
  let vCurrent = 0;
  if (vSlides.length > 1) {
    setInterval(() => {
      vSlides[vCurrent].classList.remove('active');
      vCurrent = (vCurrent + 1) % vSlides.length;
      vSlides[vCurrent].classList.add('active');
    }, 3200);
  }
})();

// Show/hide the "back to top" button based on scroll position
(function () {
  const btn = document.getElementById('scrollTopBtn');
  if (!btn) return;
  window.addEventListener('scroll', () => {
    if (window.scrollY > 500) {
      btn.classList.add('visible');
    } else {
      btn.classList.remove('visible');
    }
  });
  btn.addEventListener('click', (e) => {
    e.preventDefault();
    window.scrollTo({ top: 0, behavior: 'smooth' });
  });
})();

// Eligibility Checker — multi-step navigation
(function () {
  const steps = document.querySelectorAll('.elig-step');
  if (steps.length === 0) return;
  const totalSteps = steps.length;
  let current = 1;
  const nextBtn = document.getElementById('eligNext');
  const backBtn = document.getElementById('eligBack');
  const progressText = document.getElementById('eligProgressText');
  const resultCards = document.getElementById('eligResultCards');

  function showStep(n) {
    steps.forEach(s => s.classList.remove('active'));
    const target = document.querySelector('.elig-step[data-step="' + n + '"]');
    if (target) target.classList.add('active');
    progressText.textContent = 'Step ' + n + ' of ' + totalSteps;
    backBtn.style.visibility = n === 1 ? 'hidden' : 'visible';
    nextBtn.style.display = n === totalSteps ? 'none' : 'inline-block';
    if (n === totalSteps) buildResults();
  }

  function buildResults() {
    const checked = document.querySelectorAll('.elig-dest:checked');
    resultCards.innerHTML = '';
    if (checked.length === 0) {
      resultCards.innerHTML = '<p>No destinations selected yet \u2014 go back to Step 4 to choose one or more.</p>';
      return;
    }
    checked.forEach(function (box) {
      const card = document.createElement('div');
      card.className = 'elig-result-card';
      card.innerHTML = '<h4>' + box.value + '</h4><p>You have expressed interest in this destination. A Vikanns adviser can walk you through what this pathway may involve for your specific profile.</p>';
      resultCards.appendChild(card);
    });
  }

  if (nextBtn) {
    nextBtn.addEventListener('click', function () {
      const activeStep = document.querySelector('.elig-step[data-step="' + current + '"]');
      const requiredFields = activeStep.querySelectorAll('[required]');
      for (const f of requiredFields) {
        if (!f.checkValidity()) { f.reportValidity(); return; }
      }
      if (current < totalSteps) {
        current++;
        showStep(current);
      }
    });
  }
  if (backBtn) {
    backBtn.addEventListener('click', function () {
      if (current > 1) {
        current--;
        showStep(current);
      }
    });
  }
  showStep(current);
})();

// Consultation Booking — builds a pre-filled WhatsApp message from selections
(function () {
  const btn = document.getElementById('bookSubmit');
  if (!btn) return;
  btn.addEventListener('click', function () {
    const service = document.getElementById('bookService').value || 'a consultation';
    const date = document.getElementById('bookDate').value || 'a date to be discussed';
    const time = document.getElementById('bookTime').value || 'a time to be discussed';
    const msg = 'Hello Vikanns, I would like to book a consultation for ' + service + ' on ' + date + ' at ' + time + '.';
    window.open('https://wa.me/2347032751486?text=' + encodeURIComponent(msg), '_blank');
  });
})();
