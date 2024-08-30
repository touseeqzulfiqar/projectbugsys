document.addEventListener("DOMContentLoaded", function () {
  const addDeveloperBtn = document.getElementById("add-developer-btn");
  const developerFieldsContainer = document.getElementById(
    "developer-fields-container"
  );
  const developerIdsInput = document.getElementById("developer-ids-input");

  let selectedDevelopers = [];

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
      updateDeveloperIdsInput();
    });

    const removeBtn = newField.querySelector(".remove-developer-btn");
    removeBtn.addEventListener("click", function () {
      newField.remove();
      updateSelectedDevelopers();
      updateDeveloperOptions();
      updateDeveloperIdsInput();
    });
  }

  function getDeveloperOptions() {
    return developerUsers
      .filter((user) => !selectedDevelopers.includes(user.id.toString()))
      .map((user) => `<option value="${user.id}">${user.email}</option>`)
      .join("");
  }

  function updateSelectedDevelopers() {
    selectedDevelopers = Array.from(
      document.querySelectorAll(".developer-select")
    )
      .map((select) => select.value)
      .filter((value) => value);
  }

  function updateDeveloperOptions() {
    const allDeveloperSelects = document.querySelectorAll(".developer-select");

    allDeveloperSelects.forEach((select) => {
      const currentValue = select.value;
      select.innerHTML = getDeveloperOptions();
      select.value = currentValue;
    });
  }

  function updateDeveloperIdsInput() {
    developerIdsInput.value = selectedDevelopers.join(",");
  }

  addDeveloperBtn.addEventListener("click", function () {
    createDeveloperDropdown();
  });
});
