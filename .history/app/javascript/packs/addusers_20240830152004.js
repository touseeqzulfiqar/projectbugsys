document.addEventListener("turbo:load", function () {
  const addDeveloperBtn = document.getElementById("add-developer-btn");
  const developerFieldsContainer = document.getElementById(
    "developer-fields-container"
  );
  const developerIdsInput = document.getElementById("developer-ids-input");

  if (!addDeveloperBtn || !developerFieldsContainer || !developerIdsInput) {
    console.error("Required elements are missing from the DOM.");
    return;
  }

  let selectedDevelopers = [];

  function createDeveloperDropdown(selectedDeveloperId = null) {
    const newField = document.createElement("div");
    newField.classList.add("developer-field");

    const options = getDeveloperOptions(selectedDeveloperId);

    newField.innerHTML = `
      <div class="field">
        <select class="developer-select">
          <option value="">Select Developers</option>
          ${options}
        </select>
        <button type="button" class="remove-developer-btn">Remove</button>
      </div>
    `;

    developerFieldsContainer.appendChild(newField);

    const developerSelect = newField.querySelector(".developer-select");
    if (selectedDeveloperId) {
      developerSelect.value = selectedDeveloperId;
    }

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

  function getDeveloperOptions(selectedDeveloperId = null) {
    return developerUsers
      .filter(
        (user) =>
          !selectedDevelopers.includes(user.id.toString()) ||
          user.id.toString() === selectedDeveloperId
      )
      .map((user) => `<option value="${user.id}">${user.email}</option>`)
      .join("");
  }

  function updateSelectedDevelopers() {
    selectedDevelopers = Array.from(
      document.querySelectorAll(".developer-select")
    )
      .map((select) => select.value)
      .filter((value) => value); // Filter out empty values (e.g., "Select Developers")
  }

  function updateDeveloperOptions() {
    const allDeveloperSelects = document.querySelectorAll(".developer-select");

    allDeveloperSelects.forEach((select) => {
      const currentValue = select.value;
      select.innerHTML =
        `<option value="">Select Developers</option>` +
        getDeveloperOptions(currentValue);
      select.value = currentValue;
    });
  }

  function updateDeveloperIdsInput() {
    developerIdsInput.value = selectedDevelopers.join(",");
  }

  addDeveloperBtn.addEventListener("click", function () {
    createDeveloperDropdown();
  });

  // Load pre-selected developers in edit view
  if (
    typeof selectedDeveloperUsers !== "undefined" &&
    selectedDeveloperUsers.length > 0
  ) {
    selectedDeveloperUsers.forEach((userId) => {
      createDeveloperDropdown(userId);
    });
  }
});
