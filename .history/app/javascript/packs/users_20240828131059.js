console.log("users.js loaded");

document.addEventListener("turbo:load", function () {
  // Select the elements
  let addUserButton = document.getElementById("add-user-button");
  let usersFields = document.getElementById("users-fields");

  // Check if elements exist
  if (addUserButton && usersFields) {
    // Store the template of the user fields
    let template = document.createElement("div");
    template.innerHTML = usersFields.querySelector(".nested-fields").outerHTML;

    // Initially, hide or clear the usersFields container
    usersFields.innerHTML = "";

    // Add event listener to the button
    addUserButton.addEventListener("click", function () {
      let newUserField = document.createElement("div");
      newUserField.innerHTML = template.innerHTML;
      newUserField
        .querySelectorAll("input")
        .forEach((input) => (input.value = ""));
      usersFields.appendChild(newUserField);
    });

    // Add event listener to the container
    usersFields.addEventListener("click", function (event) {
      if (event.target.classList.contains("remove-user-button")) {
        event.target.closest(".nested-fields").remove();
      }
    });
  } else {
    console.log("Elements not found");
  }
});
