/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

// Get all input fields and text areas
const inputs = document.querySelectorAll('.enable');
const password = document.querySelectorAll('.password');
const saveButton = document.getElementById('save');
console.log(inputs)
// Disable the button initially
saveButton.disabled = true;

// Add event listeners to all inputs and text areas
inputs.forEach(function (input) {
    input.addEventListener('input', function () {
        // Check if any input has a value
        const hasValue = Array.from(inputs).some(function (input) {
            return input.value.trim().length > 0;
        });

        // Enable or disable the button based on input values
        saveButton.disabled = !hasValue;
    });
});

password.forEach(function (input) {
    input.addEventListener('input', function () {
        // Check if any input has a value
        const hasValue = Array.from(password).some(function (input) {
            return input.value.trim().length > 2;
        });

        // Enable or disable the button based on input values
        saveButton.disabled = !hasValue;
    });
});