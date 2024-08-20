// app/javascript/packs/users.js (or include in application.js)
document.addEventListener("DOMContentLoaded", function () {
  const usersFields = document.getElementById("users-fields");
  const addUserButton = document.getElementById("add-user-button");

  addUserButton.addEventListener("click", function () {
    const newUserFields = document
      .querySelector(".nested-fields")
      .cloneNode(true);
    newUserFields
      .querySelectorAll("input")
      .forEach((input) => (input.value = ""));
    usersFields.appendChild(newUserFields);
  });

  usersFields.addEventListener("click", function (event) {
    if (event.target.classList.contains("remove-user-button")) {
      event.target.closest(".nested-fields").remove();
    }
  });
});
