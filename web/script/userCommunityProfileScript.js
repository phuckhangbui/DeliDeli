/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */


const userName = document.getElementById('userFullName');
console.log(userName)

if (userName.innerHTML === " ") {
    userName.textContent = 'Unspecified';
    userName.classList.add('unspecified');
    userName.appendChild(unspecified);
}