document.addEventListener("DOMContentLoaded", function () {
  const addRoleBtn = document.getElementById("add-role-btn");
  const removeRoleBtn = document.getElementById("remove-role-btn");
  const roleDropdowns = document.getElementById("role-dropdowns");
  const roleSelect = document.getElementById("role-select");
  const qaDropdown = document.getElementById("qa-users-dropdown");
  const developerDropdown = document.getElementById("developer-users-dropdown");

  // Show role dropdowns when "Add Role" button is clicked
  addRoleBtn.addEventListener("click", function () {
    roleDropdowns.style.display = "block";
    addRoleBtn.style.display = "none"; // Hide the "Add Role" button
  });

  // Hide role dropdowns when "Remove Role" button is clicked
  removeRoleBtn.addEventListener("click", function () {
    roleDropdowns.style.display = "none";
    qaDropdown.style.display = "none";
    developerDropdown.style.display = "none";
    addRoleBtn.style.display = "inline"; // Show the "Add Role" button again
  });

  // Show the appropriate dropdown based on role selection
  roleSelect.addEventListener("change", function () {
    const selectedRole = this.value;

    // Hide both dropdowns initially
    qaDropdown.style.display = "none";
    developerDropdown.style.display = "none";

    // Show the appropriate dropdown based on the selection
    if (selectedRole === "qa") {
      qaDropdown.style.display = "block";
    } else if (selectedRole === "developer") {
      developerDropdown.style.display = "block";
    }
  });
});
