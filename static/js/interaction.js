function toggleMobileMenu() {
    const menu = document.getElementById('mobile-menu');
    const button = document.getElementById('mobileMenuButton');
    const isExpanded = button.getAttribute('aria-expanded') === 'true';

    menu.classList.toggle('hidden');
    button.setAttribute('aria-expanded', !isExpanded);
}

// Make sure DOM is loaded before adding event listener
if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', function() {
        document.getElementById('mobileMenuButton').addEventListener('click', toggleMobileMenu);
    });
} else {
    // DOM already loaded
    document.getElementById('mobileMenuButton').addEventListener('click', toggleMobileMenu);
}