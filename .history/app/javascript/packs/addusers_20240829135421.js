document.addEventListener("DOMContentLoaded", function () {
  const addDeveloperBtn = document.getElementById("add-developer-btn");
  const developerFieldsContainer = document.getElementById(
    "developer-fields-container"
  );

  let selectedDevelopers = [];

  // Function to create developer dropdown
  function createDeveloperDropdown() {
    const newField = document.createElement("div");
    newField.classList.add("developer-field");

    newField.innerHTML = `
      <div class="field">
        <select class="developer-select">
          ${getDeveloperOptions()}
        </select>
        <button type="button" class="remove-developer-btn">Remove</button>
      </div>
    `;

    developerFieldsContainer.appendChild(newField);

    const developerSelect = newField.querySelector(".developer-select");
    developerSelect.addEventListener("change", function () {
      updateSelectedDevelopers();
      updateDeveloperOptions();
    });

    const removeBtn = newField.querySelector(".remove-developer-btn");
    removeBtn.addEventListener("click", function () {
      newField.remove();
      updateSelectedDevelopers();
      updateDeveloperOptions();
    });
  }

  // Function to get developer options excluding selected ones
  function getDeveloperOptions() {
    return developerUsers
      .filter((user) => !selectedDevelopers.includes(user.id.toString()))
      .map((user) => `<option value="${user.id}">${user.email}</option>`)
      .join("");
  }

  // Function to update selected developers list
  function updateSelectedDevelopers() {
    selectedDevelopers = Array.from(
      document.querySelectorAll(".developer-select")
    )
      .map((select) => select.value)
      .filter((value) => value);
  }

  // Function to update developer options in all dropdowns
  function updateDeveloperOptions() {
    const allDeveloperSelects = document.querySelectorAll(".developer-select");

    allDeveloperSelects.forEach((select) => {
      const currentValue = select.value;
      select.innerHTML = getDeveloperOptions();
      select.value = currentValue;
    });
  }

  addDeveloperBtn.addEventListener("click", function () {
    createDeveloperDropdown();
  });
});
