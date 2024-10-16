// Workaround for modulo for negative numbers...
function mod(n, m) {
    return ((n % m) + m) % m;
}

(function () {

    let carrousel = 0;
    const CARROUSEL_LENGTH = 2;

    function handleLeft() {
        carrousel = mod(carrousel - 1, CARROUSEL_LENGTH);
        renderCarrousel();
    }

    function handleRight() {
        carrousel = mod(carrousel + 1, CARROUSEL_LENGTH);
        renderCarrousel();
    }

    function renderCarrousel() {
        for (let i = 0; i !== CARROUSEL_LENGTH; ++i) {
            const el = document.getElementById("carrousel-" + i);
            if (i === carrousel) {
                el.classList.add('active');
            } else {
                el.classList.remove('active');
            }
        }
    }

    const leftBtn = document.getElementById("carrousel-left");
    const rightBtn = document.getElementById("carrousel-right");

    leftBtn.addEventListener("click", handleLeft);
    rightBtn.addEventListener("click", handleRight);

})();

/* Function used to show a hidden QRCode
 * (see layouts/shortcodes/newsletter-social-links.html). */
function toggle_QRCode() {
    const elQRCode = document.getElementById('QRcode');
    toggleClass(elQRCode, 'is-visible');
}


/* **************************************************************************
 * TOOL FUNCTIONS
 */

function toggleClass(el, className){
    if (hasClass(el, className))
        removeClass(el, className);
    else
        addClass(el, className);
}

function hasClass(el, className) {
    return el.classList ? el.classList.contains(className) : new RegExp('\\b'+ className+'\\b').test(el.className);
}

function addClass(el, className) {
    if (el.classList) el.classList.add(className);
    else if (!hasClass(el, className)) el.className += ' ' + className;
}

function removeClass(el, className) {
    if (el.classList) el.classList.remove(className);
    else el.className = el.className.replace(new RegExp('\\b'+ className+'\\b', 'g'), '');
}