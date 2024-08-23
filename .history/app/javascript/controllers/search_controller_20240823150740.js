import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="search"
export default class extends Controller {
  static targets = ["container"];

  connect() {
    console.log("Hello, Stimulus is working!");
  }

  handleChange(e) {
    e.preventDefault();

    const inputValue = e.target.value.trim(); // Trim whitespace
    console.log(inputValue);

    if (inputValue === "") {
      this.containerTarget.innerHTML = ""; // Clear existing results if input is empty
    } else {
      fetch("/live/suggestions", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "X-CSRF-Token": document
            .querySelector('meta[name="csrf-token"]')
            .getAttribute("content"),
        },
        body: JSON.stringify({ search: inputValue }), // Send the entire input value
      })
        .then((response) => response.json())
        .then((data) => {
          this.containerTarget.innerHTML = ""; // Clear existing results
          if (data.projects && data.projects.length > 0) {
            data.projects.forEach((item) => {
              const p = document.createElement("p");
              p.innerHTML = item.name;
              this.containerTarget.appendChild(p);
            });
          } else {
            const noResults = document.createElement("p");
            noResults.innerHTML = "No results found";
            this.containerTarget.appendChild(noResults);
          }
        })
        .catch((error) => {
          console.error("Error fetching search results:", error);
        });
    }
  }
}
