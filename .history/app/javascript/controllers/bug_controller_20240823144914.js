import { Controller } from "@hotwired/stimulus";

export default class extends Controller {

  updateStatus(event) {
      let status = document.getElementById("bug_status");
    const bugType = event.target.value;
    let statusOptions = [];
    if (bugType === "feature") {
      statusOptions = ["New", "Started", "Completed"];
    } else if (bugType === "bug") {
      statusOptions = ["New", "Started", "Resolved"];
    }

    this.updateStatusSelect(statusOptions, status);
  }

  updateStatusSelect(options, status) {
    if (status) {
      // Check if the statusTarget exists
      status.innerHTML = options
        .map(
          (option) =>
            `<option value="${option.toLowerCase()}">${option}</option>`
        )
        .join("");
    } else {
      console.error("Status target not found");
    }
  }
}
