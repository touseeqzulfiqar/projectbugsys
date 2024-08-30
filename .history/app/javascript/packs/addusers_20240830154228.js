document.addEventListener("turbo:load", function () {
  const addDeveloperBtn = document.getElementById("add-developer-btn");
  const developerFieldsContainer = document.getElementById(
    "developer-fields-container"
  );
  const developerIdsInput = document.getElementById("developer-ids-input");

  if (!addDeveloperBtn) {
    console.log("Button with ID 'add-developer-btn' not found.");
    return;
  }

  if (!developerFieldsContainer || !developerIdsInput) {
    console.log("Required elements are missing from the DOM.");
    return;
  }

  let selectedDevelopers = [];

  function createDeveloperDropdown(selectedDeveloperId = null) {
    console.log("Creating dropdown. Selected ID:", selectedDeveloperId);
    const newField = document.createElement("div");
    newField.classList.add("developer-field");

    // Generate options including the "Select Developers" placeholder
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
    console.log(
      "Fetching developer options. Selected ID:",
      selectedDeveloperId
    );
    return developerUsers
      .filter(
        (user) =>
          !selectedDevelopers.includes(user.id.toString()) ||
          user.id.toString() === selectedDeveloperId
      )
      .map(
        (user) =>
          `<option value="${user.id}" ${
            user.id === parseInt(selectedDeveloperId) ? "selected" : ""
          }>${user.email}</option>`
      )
      .join("");
  }

  function updateSelectedDevelopers() {
    console.log("Updating selected developers.");
    selectedDevelopers = Array.from(
      document.querySelectorAll(".developer-select")
    )
      .map((select) => select.value)
      .filter((value) => value); // Filter out empty values (e.g., "Select Developers")
    console.log("Selected developers:", selectedDevelopers);
  }

  function updateDeveloperOptions() {
    console.log("Updating developer options.");
    const allDeveloperSelects = document.querySelectorAll(".developer-select");

    allDeveloperSelects.forEach((select) => {
      const currentValue = select.value;
      console.log("Current select value:", currentValue);
      select.innerHTML =
        `<option value="">Select Developers</option>` +
        getDeveloperOptions(currentValue);
      select.value = currentValue;
    });
  }

  function updateDeveloperIdsInput() {
    console.log("Updating developer IDs input.");
    developerIdsInput.value = selectedDevelopers.join(",");
    console.log("Developer IDs input value:", developerIdsInput.value);
  }

  addDeveloperBtn.addEventListener("click", function () {
    console.log("Add developer button clicked.");
    createDeveloperDropdown();
  });

  // Load pre-selected developers in edit view
  if (
    typeof selectedDeveloperUsers !== "undefined" &&
    selectedDeveloperUsers.length > 0
  ) {
    console.log("Loading pre-selected developers:", selectedDeveloperUsers);
    selectedDeveloperUsers.forEach((userId) => {
      createDeveloperDropdown(userId);
    });
  }

  // Initialize selectedDevelopers from existing values
  updateSelectedDevelopers();
});
