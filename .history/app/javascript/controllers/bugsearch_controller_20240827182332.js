import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="search"
export default class extends Controller {
  static targets = ["container"];

  handleChange(e) {
    e.preventDefault();

    const inputValue = e.target.value.trim(); // Trim whitespace

    if (inputValue === "") {
      this.containerTarget.innerHTML = ""; // Clear existing results if input is empty
    } else {
      fetch("/live/bugs/suggestions", {
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
              const a = document.createElement("a");
              a.href = "/projects/" + item.id + ""; // Set the href to the project's show page URL
              a.innerHTML = item.name;
              this.containerTarget.appendChild(a);
              this.containerTarget.appendChild(document.createElement("br")); // Optional: Add a line break between links
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
