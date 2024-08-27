import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["container"];

  connect() {
    console.log("bugsearch connected...");
  }

  handleChange(e) {
    e.preventDefault();

    const inputValue = e.target.value.trim();

    if (inputValue === "") {
      this.containerTarget.innerHTML = "";
    } else {
      fetch("/buglive/suggestions", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "X-CSRF-Token": document
            .querySelector('meta[name="csrf-token"]')
            .getAttribute("content"),
        },
        body: JSON.stringify({ search: inputValue }),
      })
        .then((response) => {
          if (!response.ok) {
            console.error(`HTTP error! status: ${response.status}`);
            return response.text().then((text) => {
              throw new Error(text);
            });
          }
          return response.json();
          console.log("entered");
        })
        .then((data) => {
          this.containerTarget.innerHTML = "";
          if (data.bugs && data.bugs.length > 0) {
            data.bugs.forEach((item) => {
              const a = document.createElement("a");
              a.href = `/projects/${item.project_id}/bugs/${item.id}`;
              a.innerHTML = `${item.description} - ${item.status} (${item.bug_type})`;
              this.containerTarget.appendChild(a);
              this.containerTarget.appendChild(document.createElement("br"));
            });
          } else {
            const noResults = document.createElement("p");
            noResults.innerHTML = "No results found";
            this.containerTarget.appendChild(noResults);
          }
        })
        .catch((error) => {
          console.log(error);
          console.error("Error fetching bug suggestions:", error.message);
          this.containerTarget.innerHTML = `<p>An error occurred: ${error.message}. Please try again later.</p>`;
        });
    }
  }
}
