// Workaround for modulo for negative numbers...
function mod(n, m) {
    return ((n % m) + m) % m;
}

(function () {

    let carrousel = 0;
    const CARROUSEL_LENGTH = 3;

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
                el.className = "w3-show";
            } else {
                el.className = "w3-hide";
            }
        }
    }

    const leftBtn = document.getElementById("carrousel-left");
    const rightBtn = document.getElementById("carrousel-right");

    leftBtn.addEventListener("click", handleLeft);
    rightBtn.addEventListener("click", handleRight);

})();
