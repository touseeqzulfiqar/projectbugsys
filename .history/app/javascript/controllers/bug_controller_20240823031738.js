import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["status"];

  updateStatus(event) {
    const bugType = event.target.value;

    let statusOptions;
    console.log("ok gg");
    if (bugType === "feature") {
      statusOptions = [
        { text: "New", value: "new" },
        { text: "Started", value: "started" },
        { text: "Completed", value: "completed" },
      ];
    } else if (bugType === "bug") {
      statusOptions = [
        { text: "New", value: "new" },
        { text: "Started", value: "started" },
        { text: "Resolved", value: "resolved" },
      ];
    }

    this.updateStatusSelect(statusOptions);
  }

  updateStatusSelect(options) {
    const statusSelect = this.statusTarget;
    statusSelect.innerHTML = ""; // Clear existing options

    options.forEach((option) => {
      const opt = document.createElement("option");
      opt.value = option.value;
      opt.textContent = option.text;
      statusSelect.appendChild(opt);
    });
  }
}
