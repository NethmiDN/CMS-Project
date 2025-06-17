// ✅ Show/Hide password toggle
function togglePassword() {
    const pwd = document.getElementById("password");
    const icon = document.getElementById("togglePassword");
    if (pwd.type === "password") {
        pwd.type = "text";
        icon.classList.remove("fa-eye");
        icon.classList.add("fa-eye-slash");
    } else {
        pwd.type = "password";
        icon.classList.remove("fa-eye-slash");
        icon.classList.add("fa-eye");
    }
}

// ✅ Real-world Regex patterns
const usernameRegex = /^(?=.{4,20}$)(?![_\.])(?!.*[_\.]{2})[a-zA-Z0-9._]+(?<![_\.])$/;
const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
const passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?#&_])[A-Za-z\d@$!%*?#&_]{8,}$/;

document.addEventListener("DOMContentLoaded", function () {
    const form = document.querySelector("form");
    form.addEventListener("submit", function (e) {
        let valid = true;
        document.querySelectorAll('.error-msg').forEach(el => el.remove());

        const username = document.getElementById("username");
        const email = document.getElementById("email");
        const password = document.getElementById("password");
        const role = document.getElementById("role");

        // Validate username
        if (!usernameRegex.test(username.value)) {
            showError(username, "Username must be 4–20 characters (letters, numbers, dot or underscore). No leading/trailing symbols.");
            valid = false;
        }

        // Validate email
        if (!emailRegex.test(email.value)) {
            showError(email, "Enter a valid email address.");
            valid = false;
        }

        // Validate password
        if (!passwordRegex.test(password.value)) {
            showError(password, "Password must be 8+ characters, include uppercase, lowercase, number, and special character.");
            valid = false;
        }

        // Validate role (dropdown)
        if (role && role.value.trim() === "") {
            showError(role, "Please select a role.");
            valid = false;
        }

        if (!valid) e.preventDefault();
    });
});

function showError(input, message) {
    const error = document.createElement("div");
    error.className = "error-msg";
    error.style.color = "#e74c3c";
    error.style.fontSize = "0.9em";
    error.style.marginTop = "4px";
    error.textContent = message;

    if (input.parentNode) {
        input.parentNode.appendChild(error);
    }
}
