console.log("users.js loaded");

document.addEventListener("turbo:load", function () {
  // Select the elements
  let addUserButton = document.getElementById("add-user-button");
  let usersFields = document.getElementById("users-fields");

  // Check if elements exist
  if (addUserButton && usersFields) {
    // Add event listener to the button
    addUserButton.addEventListener("click", function () {
      let newUserField = document.createElement("div");
      newUserField.innerHTML =
        usersFields.querySelector(".nested-fields").outerHTML;
      newUserField.querySelector("input").value = ""; // Clear the input values
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
