document.addEventListener("DOMContentLoaded", function () {
  const addRoleBtn = document.getElementById("add-role-btn");
  const roleFieldsContainer = document.getElementById("role-fields-container");

  // Function to create new role fields
  function createRoleFields() {
    const newField = document.createElement("div");
    newField.classList.add("role-field");

    newField.innerHTML = `
      <div class="field">
        <label>Select Role</label>
        <select class="role-select">
          <option value="">Select Role</option>
          <option value="qa">QA</option>
          <option value="developer">Developer</option>
        </select>
      </div>
      <div class="field qa-users-dropdown" style="display: none;">
        <label>Select QA Users</label>
        <select class="user-select" data-role="qa">
          ${getUserOptions("qa")}
        </select>
      </div>
      <div class="field developer-users-dropdown" style="display: none;">
        <label>Select Developer Users</label>
        <select class="user-select" data-role="developer">
          ${getUserOptions("developer")}
        </select>
      </div>
      <button type="button" class="remove-role-btn">Remove Role</button>
    `;

    roleFieldsContainer.appendChild(newField);

    const roleSelect = newField.querySelector(".role-select");
    const qaDropdown = newField.querySelector(".qa-users-dropdown");
    const developerDropdown = newField.querySelector(
      ".developer-users-dropdown"
    );

    roleSelect.addEventListener("change", function () {
      const role = this.value;
      qaDropdown.style.display = role === "qa" ? "block" : "none";
      developerDropdown.style.display = role === "developer" ? "block" : "none";
      updateUserOptions();
    });

    // Handle user selection changes
    newField
      .querySelector(".user-select")
      .addEventListener("change", updateUserOptions);
  }

  // Function to get user options excluding selected ones
  function getUserOptions(role) {
    if (
      typeof qaUsers === "undefined" ||
      typeof developerUsers === "undefined"
    ) {
      console.error("User data is not defined.");
      return "";
    }

    const selectedUsers = Array.from(document.querySelectorAll(".user-select"))
      .map((select) => select.value)
      .filter((value) => value);

    let users = role === "qa" ? qaUsers : developerUsers;
    users = users.filter((user) => !selectedUsers.includes(user.id.toString()));

    return users
      .map((user) => `<option value="${user.id}">${user.email}</option>`)
      .join("");
  }

  // Function to update user options in all dropdowns
  function updateUserOptions() {
    document.querySelectorAll(".role-field").forEach((field) => {
      const roleSelect = field.querySelector(".role-select");
      const role = roleSelect.value;
      const userSelect = field.querySelector(
        ".user-select[data-role='" + role + "']"
      );

      if (role) {
        userSelect.innerHTML = getUserOptions(role);
      }
    });
  }

  // Add initial role fields
  addRoleBtn.addEventListener("click", function () {
    createRoleFields();
  });

  // Remove role fields
  document.addEventListener("click", function (event) {
    if (event.target.classList.contains("remove-role-btn"))y {
      event.target.closest(".role-field").remove();
      updateUserOptions();
    }
  });
});
