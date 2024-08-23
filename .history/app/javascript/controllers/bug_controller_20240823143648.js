import { Controller } from "@hotwired/stimulus";

export default class extends Controller {

  updateStatus(event) {
      let status = document.getElementById("bug_status");
    const bugType = event.target.value;
    console.log(status);
    let statusOptions = [];
console.log("called");
    if (bugType === "feature") {
      statusOptions = ["New", "Started", "Completed"];
    } else if (bugType === "bug") {
      statusOptions = ["New", "Started", "Resolved"];
    }

    // this.updateStatusSelect(statusOptions);
  }

  updateStatusSelect(options) {
    if (this.hasStatusTarget) {
      // Check if the statusTarget exists
      this.statusTarget.innerHTML = options
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
