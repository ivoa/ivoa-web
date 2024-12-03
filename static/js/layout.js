function toggleMobileMenu() {
    const menu = document.getElementById('mobile-menu');
    const button = document.querySelector('[aria-controls="mobile-menu"]');
    const isExpanded = button.getAttribute('aria-expanded') === 'true';

    menu.classList.toggle('hidden');
    button.setAttribute('aria-expanded', !isExpanded);
}