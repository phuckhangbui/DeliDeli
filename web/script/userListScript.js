// const element =document.querySelector(".type-color");

// document.addEventListener("load", () =>{
//     alert("banana");
//     switch(element) {
//         case "Admin":
//             element.style.color = "#ec9131";
//             break;
//         case "Moderator":
//             element.style.color = "#79c141";
//             break;
//     }
// })

// Change the color of the active link at the bottom bar
const userList = document.querySelector(".table-redirect").querySelectorAll("a");
console.log(userList);

userList.forEach( element =>{
    element.addEventListener("click", function() {
        userList.forEach(page=>page.classList.remove("table-redirect-active-link"))
        this.classList.add('table-redirect-active-link');
    })
})

// Change the color of account status
const activeList = document.querySelectorAll("td:nth-child(6)");
console.log(activeList)
activeList.forEach( element =>{
    if(element.innerHTML == "Active"){
        element.style.color = "green";
    } else {
        element.style.color = "red";
    }
})

//Change the color of the user role
const roleList = document.querySelectorAll("td:nth-child(3)");
console.log(roleList)
roleList.forEach ( element =>{
    if(element.innerHTML == "Admin"){
        element.style.color = "#ec9131";
    }else if(element.innerHTML == "Moderator"){
        element.style.color = "#79c141";
    }
})