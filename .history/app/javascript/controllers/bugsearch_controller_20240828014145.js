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
            throw new Error(`HTTP error! status: ${response.status}`);
          }
          return response.json();
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
          console.error("Error fetching bug suggestions:", error);
          this.containerTarget.innerHTML =
            "<p>An error occurred. Please try again later.</p>";
        });
    }
  }
}
