const cards = [...document.querySelectorAll('.card')];
const empty = document.querySelector('.empty');
const revealItems = [...document.querySelectorAll('.reveal:not(.is-visible)')];

if ('IntersectionObserver' in window && !window.matchMedia('(prefers-reduced-motion: reduce)').matches) {
  revealItems.forEach((item, index) => {
    item.style.setProperty('--delay', `${Math.min(index * 70, 350)}ms`);
  });
  const revealObserver = new IntersectionObserver((entries, observer) => {
    entries.forEach((entry) => {
      if (!entry.isIntersecting) return;
      entry.target.classList.add('is-visible');
      observer.unobserve(entry.target);
    });
  }, { threshold: .12, rootMargin: '0px 0px -40px' });
  revealItems.forEach((item) => revealObserver.observe(item));
} else {
  revealItems.forEach((item) => item.classList.add('is-visible'));
}

if (empty) empty.style.display = 'none';

if (!window.matchMedia('(prefers-reduced-motion: reduce)').matches) {
  cards.forEach((card) => {
    card.addEventListener('pointermove', (event) => {
      const bounds = card.getBoundingClientRect();
      const x = (event.clientX - bounds.left) / bounds.width - .5;
      const y = (event.clientY - bounds.top) / bounds.height - .5;
      card.style.setProperty('--ry', `${x * 5}deg`);
      card.style.setProperty('--rx', `${y * -5}deg`);
    });
    card.addEventListener('pointerleave', () => {
      card.style.removeProperty('--rx');
      card.style.removeProperty('--ry');
    });
  });
}
