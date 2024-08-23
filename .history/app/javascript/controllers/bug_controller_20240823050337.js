import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["status"]; // This should match the data-target in your HTML

  updateStatus(event) {
    const bugType = event.target.value;
    let statusOptions = [];

    if (bugType === "feature") {
      statusOptions = ["New", "Started", "Completed"];
    } else if (bugType === "bug") {
      statusOptions = ["New", "Started", "Resolved"];
    }

    this.updateStatusSelect(statusOptions);
  }

  updateStatusSelect(options) {
    this.statusTarget.innerHTML = options
      .map(
        (option) => `<option value="${option.toLowerCase()}">${option}</option>`
      )
      .join("");
  }
}
