// app/javascript/controllers/search_controller.js
import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["input", "dropdown"];

  perform() {
    const query = this.inputTarget.value;

    if (query.length > 0) {
      fetch(`/projects/search?query=${query}`, {
        headers: { accept: "application/json" },
      })
        .then((response) => response.json())
        .then((data) => {
          let results = data
            .map(
              (item) =>
                `<div class="dropdown-item"><a href="/projects/${item[0]}">${item[1]}</a></div>`
            )
            .join("");
          this.dropdownTarget.innerHTML = results;
          this.dropdownTarget.classList.add("show");
        });
    } else {
      this.dropdownTarget.classList.remove("show");
      this.dropdownTarget.innerHTML = "";
    }
  }
}
