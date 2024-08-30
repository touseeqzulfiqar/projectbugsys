import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="bugsearch"
export default class extends Controller {
  static targets = ["container"];

  connect() {
    console.log("bugsearch connected...");
  }

  handleChange(e) {
    e.preventDefault();
    console.log(e.target.value);
    const inputValue = e.target.value.trim(); // Trim whitespace

    if (inputValue === "") {
      this.containerTarget.innerHTML = ""; // Clear existing results if input is empty
    } else {
      fetch("/buglive/suggestions", {
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
          if (data.bugs && data.bugs.length > 0) {
            data.bugs.forEach((item) => {
              const a = document.createElement("a");
              a.href = `/projects/${item.project_id}/bugs/${item.id}`; // Link to the specific bug
              a.innerHTML = `${item.description} - ${item.status} (${item.bug_type})`;
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
