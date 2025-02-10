// document.addEventListener("DOMContentLoaded", () => {
//   let navbarButtons = document.querySelectorAll('.collapse');

//   if (navbarButtons.length == 0) return

//   navbarButtons.forEach(button => {
//     button.addEventListener("click", collapseParticularMenu)
//   });

//   function collapseParticularMenu(event) {
//     event.preventDefault();
//     let activeElements = document.querySelectorAll('.active');
//     let target = this.getAttribute('data-target'),
//       targetContent = document.querySelector(`#${target}`);

//     activeElements.forEach(element => element.classList.remove('active'));

//     targetContent.classList.toggle("active");
//   }
// });
