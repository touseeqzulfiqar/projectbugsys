import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["status"]; // This should match the target in your HTML

  updateStatus(event) {
    console.log(event.target.value);
    const bugType = event.target.value;
    let statusOptions = [];

    if (bugType === "feature") {
      statusOptions = ["New", "Started", "Completed"];
    } else if (bugType === "bug") {
      statusOptions = ["New", "Started", "Resolved"];
    }

    console.log(statusOptions);
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
