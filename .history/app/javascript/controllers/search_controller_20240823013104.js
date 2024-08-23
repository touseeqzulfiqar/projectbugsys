import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="search"
export default class extends Controller {
  static targets = ["container"];

  connect() {
    console.log("Hello, Stimulus is working!");
  }

  handleChange(e) {
    e.preventDefault();

    const inputValue = e.target.value;
    console.log(inputValue);

    if (inputValue === "") {
      this.containerTarget.innerHTML = "";
    } else {
      fetch("/live/suggestions", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "X-CSRF-Token": document
            .querySelector('meta[name="csrf-token"]')
            .getAttribute("content"),
        },
        body: JSON.stringify({ search: inputValue }),
      })
        .then((response) => response.json())
        .then((data) => {
          this.containerTarget.innerHTML = ""; // Clear existing results
          data.projects.forEach((item) => {
            const p = document.createElement("p");
            p.innerHTML = item.name;
            this.containerTarget.appendChild(p);
          });
        });
    }
  }
}
