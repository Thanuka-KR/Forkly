/* ==============================
   SECTION 1: SAFE CONTEXT PATH
   ============================== */

function getAppContext() {

    const pathParts =
        window.location.pathname.split("/");

    if (pathParts.length > 1 && pathParts[1] !== "") {

        return "/" + pathParts[1];
    }

    return "";
}

/* ==============================
   SECTION 2: ADD TO CART SYSTEM
   ============================== */

document.addEventListener("click", function (event) {

    const button =
        event.target.closest(".add-cart-btn") ||
        event.target.closest(".modern-add-cart-btn");

    if (!button) {
        return;
    }

    if (button.classList.contains("locked-cart-btn")) {
        return;
    }

    event.preventDefault();

    const form =
        button.closest("form");

    const card =
        button.closest(".modern-food-card") ||
        button.closest(".food-card");

    let itemId =
        button.dataset.id;

    let itemName =
        button.dataset.name;

    let price =
        button.dataset.price;

    if (form) {

        const itemIdInput =
            form.querySelector("input[name='itemId']");

        const itemNameInput =
            form.querySelector("input[name='itemName']");

        const priceInput =
            form.querySelector("input[name='price']");

        if (itemIdInput) {
            itemId = itemIdInput.value;
        }

        if (itemNameInput) {
            itemName = itemNameInput.value;
        }

        if (priceInput) {
            price = priceInput.value;
        }
    }

    const quantityInput =
        card ? card.querySelector(".menu-qty") : null;

    const quantity =
        quantityInput ? quantityInput.value : 1;

    const appContext =
        typeof APP_CONTEXT !== "undefined"
            ? APP_CONTEXT
            : getAppContext();

    fetch(appContext + "/cart", {

        method: "POST",

        headers: {
            "Content-Type": "application/x-www-form-urlencoded",
            "X-Requested-With": "XMLHttpRequest"
        },

        body:
            "action=add"
            + "&itemId=" + encodeURIComponent(itemId)
            + "&itemName=" + encodeURIComponent(itemName)
            + "&price=" + encodeURIComponent(price)
            + "&quantity=" + encodeURIComponent(quantity)
    })

        .then(function (response) {
            return response.text();
        })

        .then(function () {

            const badge =
                document.getElementById("cart-count-badge");

            if (badge) {

                let current =
                    parseInt(badge.textContent.trim());

                if (isNaN(current)) {
                    current = 0;
                }

                badge.textContent =
                    current + parseInt(quantity);
            }

            showCartNotification(
                quantity + " × " + itemName + " added to cart"
            );
        })

        .catch(function (error) {

            console.log("Cart error:", error);

            showCartNotification("Cart add failed.");
        });
});

/* ==============================
   SECTION 3: CART TOAST
   ============================== */

function showCartNotification(message) {

    const notification =
        document.createElement("div");

    notification.className =
        "cart-toast";

    notification.innerText =
        message;

    document.body.appendChild(notification);

    setTimeout(function () {

        notification.classList.add("show");

    }, 100);

    setTimeout(function () {

        notification.classList.remove("show");

        setTimeout(function () {

            notification.remove();

        }, 300);

    }, 2500);
}

/* ==============================
   SECTION 4: MODERN COUNTER ANIMATION
   ============================== */

function startCounterAnimation() {

    const counters =
        document.querySelectorAll(".counter-number");

    counters.forEach(function (counter) {

        const targetText =
            counter.getAttribute("data-target");

        const target =
            parseInt(targetText);

        if (isNaN(target) || target <= 0) {

            counter.textContent =
                "+0";

            return;
        }

        let current =
            0;

        const duration =
            1600;

        const startTime =
            performance.now();

        function updateCounter(currentTime) {

            const elapsed =
                currentTime - startTime;

            const progress =
                Math.min(elapsed / duration, 1);

            const easedProgress =
                1 - Math.pow(1 - progress, 3);

            current =
                Math.floor(easedProgress * target);

            counter.textContent =
                "+" + current;

            if (progress < 1) {

                requestAnimationFrame(updateCounter);

            } else {

                counter.textContent =
                    "+" + target;
            }
        }

        requestAnimationFrame(updateCounter);
    });
}

/* ==============================
   SECTION 5: CUSTOMER MENU SEARCH
   ============================== */

function startMenuLiveSearch() {

    const searchInput =
        document.getElementById("menuSearchInput");

    const menuGrid =
        document.getElementById("menuItemsGrid");

    const emptyBox =
        document.getElementById("menuEmptySearch");

    const countBadge =
        document.getElementById("menuItemCount");

    if (!searchInput || !menuGrid) {
        return;
    }

    const cards =
        menuGrid.querySelectorAll(".modern-food-card");

    searchInput.addEventListener("input", function () {

        const keyword =
            searchInput.value.toLowerCase().trim();

        let visibleCount =
            0;

        cards.forEach(function (card) {

            const searchText =
                card.getAttribute("data-search") || "";

            if (searchText.includes(keyword)) {

                card.style.display =
                    "";

                visibleCount++;

            } else {

                card.style.display =
                    "none";
            }
        });

        if (countBadge) {

            countBadge.textContent =
                visibleCount + " Items";
        }

        if (emptyBox) {

            emptyBox.style.display =
                visibleCount === 0
                    ? "block"
                    : "none";
        }
    });
}

/* ==============================
   SECTION 6: ADMIN MENU SEARCH
   ============================== */

function startAdminMenuSearch() {

    const searchInput =
        document.getElementById("adminMenuSearchInput");

    const menuGrid =
        document.getElementById("adminMenuGrid");

    const emptyBox =
        document.getElementById("adminMenuEmptySearch");

    const countBadge =
        document.getElementById("adminMenuItemCount");

    if (!searchInput || !menuGrid) {
        return;
    }

    const cards =
        menuGrid.querySelectorAll(".admin-menu-card");

    searchInput.addEventListener("input", function () {

        const keyword =
            searchInput.value.toLowerCase().trim();

        let visibleCount =
            0;

        cards.forEach(function (card) {

            const searchText =
                card.getAttribute("data-search") || "";

            if (searchText.includes(keyword)) {

                card.style.display =
                    "";

                visibleCount++;

            } else {

                card.style.display =
                    "none";
            }
        });

        if (countBadge) {

            countBadge.textContent =
                visibleCount + " Items";
        }

        if (emptyBox) {

            emptyBox.style.display =
                visibleCount === 0
                    ? "block"
                    : "none";
        }
    });
}

/* ==============================
   SECTION 7: DOM READY
   ============================== */

if (document.readyState === "loading") {

    document.addEventListener("DOMContentLoaded", function () {

        startCounterAnimation();

        startMenuLiveSearch();

        startAdminMenuSearch();
    });

} else {

    startCounterAnimation();

    startMenuLiveSearch();

    startAdminMenuSearch();
}
/* ==============================
   SECTION 8: DARK MODE SYSTEM
   ============================== */

function applyTheme(theme){

    if(theme === "dark"){

        document.body.classList.add("dark-mode");

        const toggleBtn =
            document.getElementById("themeToggleBtn");

        if(toggleBtn){

            toggleBtn.innerHTML =
                "☀️";
        }

    } else {

        document.body.classList.remove("dark-mode");

        const toggleBtn =
            document.getElementById("themeToggleBtn");

        if(toggleBtn){

            toggleBtn.innerHTML =
                "🌙";
        }
    }
}

function toggleDarkMode(){

    const isDark =
        document.body.classList.contains("dark-mode");

    if(isDark){

        localStorage.setItem("forkly-theme", "light");

        applyTheme("light");

    } else {

        localStorage.setItem("forkly-theme", "dark");

        applyTheme("dark");
    }
}

/* ==============================
   LOAD SAVED THEME
   ============================== */

(function(){

    const savedTheme =
        localStorage.getItem("forkly-theme");

    if(savedTheme){

        applyTheme(savedTheme);

    } else {

        applyTheme("light");
    }

})();
/* ==============================
   SECTION 8: DARK MODE SYSTEM
   ============================== */

function applyTheme(theme) {

    const toggleBtn =
        document.getElementById("themeToggleBtn");

    if (theme === "dark") {

        document.body.classList.add("dark-mode");

        if (toggleBtn) {

            toggleBtn.innerHTML =
                "☀️";
        }

    } else {

        document.body.classList.remove("dark-mode");

        if (toggleBtn) {

            toggleBtn.innerHTML =
                "🌙";
        }
    }
}

function initDarkMode() {

    const savedTheme =
        localStorage.getItem("forkly-theme") || "light";

    applyTheme(savedTheme);

    const toggleBtn =
        document.getElementById("themeToggleBtn");

    if (toggleBtn) {

        toggleBtn.addEventListener("click", function () {

            const isDark =
                document.body.classList.contains("dark-mode");

            if (isDark) {

                localStorage.setItem(
                    "forkly-theme",
                    "light"
                );

                applyTheme("light");

            } else {

                localStorage.setItem(
                    "forkly-theme",
                    "dark"
                );

                applyTheme("dark");
            }
        });
    }
}

/* ==============================
   SECTION 9: DOM READY
   ============================== */

if (document.readyState === "loading") {

    document.addEventListener("DOMContentLoaded", function () {

        startCounterAnimation();

        startMenuLiveSearch();

        startAdminMenuSearch();

        initDarkMode();
    });

} else {

    startCounterAnimation();

    startMenuLiveSearch();

    startAdminMenuSearch();

    initDarkMode();
}
/* ==============================
   SECTION 10: MODERN PAYMENT VALIDATION
   ============================== */

function initPaymentValidation() {

    const cardNumber =
        document.getElementById("cardNumber");

    const expiryDate =
        document.getElementById("expiryDate");

    const cvv =
        document.getElementById("cvv");

    const paymentMethod =
        document.getElementById("paymentMethodSelect");

    const paymentForm =
        document.querySelector("form[action*='payment']");

    if (!paymentForm) {
        return;
    }

    /* ==============================
       CARD NUMBER FORMAT
       ============================== */

    if (cardNumber) {

        cardNumber.addEventListener("input", function () {

            let value =
                this.value.replace(/\D/g, "");

            value =
                value.substring(0, 16);

            value =
                value.replace(/(.{4})/g, "$1 ").trim();

            this.value =
                value;
        });
    }

    /* ==============================
       EXPIRY FORMAT MM/YY
       ============================== */

    if (expiryDate) {

        expiryDate.addEventListener("input", function () {

            let value =
                this.value.replace(/\D/g, "");

            if (value.length > 4) {

                value =
                    value.substring(0, 4);
            }

            if (value.length >= 3) {

                value =
                    value.substring(0, 2)
                    + "/"
                    + value.substring(2);
            }

            this.value =
                value;
        });
    }

    /* ==============================
       CVV ONLY 3 DIGITS
       ============================== */

    if (cvv) {

        cvv.addEventListener("input", function () {

            this.value =
                this.value.replace(/\D/g, "");

            if (this.value.length > 3) {

                this.value =
                    this.value.substring(0, 3);
            }
        });
    }

    /* ==============================
       FINAL VALIDATION
       ============================== */

    paymentForm.addEventListener("submit", function (event) {

        if (!paymentMethod) {
            return;
        }

        if (paymentMethod.value !== "CARD") {
            return;
        }

        const holder =
            document.getElementById("cardHolder");

        const number =
            cardNumber.value.replace(/\s/g, "");

        const expiry =
            expiryDate.value;

        const cvvValue =
            cvv.value;

        if (!holder.value.trim()) {

            alert("Enter card holder name");

            holder.focus();

            event.preventDefault();

            return;
        }

        if (number.length !== 16) {

            alert("Card number must contain 16 digits");

            cardNumber.focus();

            event.preventDefault();

            return;
        }

        if (!/^\d{2}\/\d{2}$/.test(expiry)) {

            alert("Expiry date must be MM/YY format");

            expiryDate.focus();

            event.preventDefault();

            return;
        }

        const parts =
            expiry.split("/");

        const month =
            parseInt(parts[0]);

        if (month < 1 || month > 12) {

            alert("Invalid expiry month");

            expiryDate.focus();

            event.preventDefault();

            return;
        }

        if (!/^\d{3}$/.test(cvvValue)) {

            alert("CVV must contain exactly 3 digits");

            cvv.focus();

            event.preventDefault();

            return;
        }
    });
}

/* ==============================
   START PAYMENT VALIDATION
   ============================== */

initPaymentValidation();