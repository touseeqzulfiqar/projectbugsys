// app/javascript/packs/users.js (or include in application.js)
document.addEventListener("DOMContentLoaded", function () {
  const usersFields = document.getElementById("users-fields");
  const addUserButton = document.getElementById("add-user-button");

  addUserButton.addEventListener("click", function () {
    const newUserFields = document.createElement("div");
    newUserFields.innerHTML = document.getElementById(
      "user-fields-template"
    ).innerHTML;
    usersFields.appendChild(newUserFields);

    // Attach event listener for removing fields
    newUserFields
      .querySelector(".remove-user-button")
      .addEventListener("click", function () {
        newUserFields.remove();
      });
  });
});
