// app/javascript/controllers/bug_controller.js

import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["status"];

  updateStatus(event) {
    const bugType = event.target.value;

    let options;
    if (bugType === "feature") {
      options = [
        { text: "New", value: "new" },
        { text: "Started", value: "started" },
        { text: "Completed", value: "completed" },
      ];
    } else if (bugType === "bug") {
      options = [
        { text: "New", value: "new" },
        { text: "Started", value: "started" },
        { text: "Resolved", value: "resolved" },
      ];
    } else {
      options = [];
    }

    // Clear existing options
    this.statusTarget.innerHTML = "";

    // Add new options
    options.forEach((option) => {
      const opt = document.createElement("option");
      opt.value = option.value;
      opt.text = option.text;
      this.statusTarget.appendChild(opt);
    });
  }
}
