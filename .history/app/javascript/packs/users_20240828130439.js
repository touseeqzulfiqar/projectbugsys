console.log("users.js loaded");

document.addEventListener("turbo:load", function () {
  // Select the elements
  let addUserButton = document.getElementById("add-user-button");
  let usersFields = document.getElementById("users-fields");

  // Check if elements exist
  if (addUserButton && usersFields) {
    // Clone the structure of the user fields
    let template = usersFields.querySelector(".nested-fields").cloneNode(true);

    // Clear the input values in the cloned template
    template.querySelectorAll("input").forEach((input) => (input.value = ""));

    // Add event listener to the button
    addUserButton.addEventListener("click", function () {
      let newUserField = template.cloneNode(true);
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
