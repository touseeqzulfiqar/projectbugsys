import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="search"
export default class extends Controller {
  static targets = ["container"];
  connect() {}

  handleChange(e) {
    e.preventDefault();
    console.log(e.target.value);

    // const inputValue = e.target.value;

    // if (inputValue === "") {
    //   this.containerTarget.innerHTML = "";
    // } else {
    //   fetch("http://127.0.0.1:3000/livesearch/search", {
    //     method: "POST",
    //     headers: {
    //       "Content-Type": "application/json",
    //       "X-CSRF-Token": document
    //         .querySelector('meta[name="csrf-token"]')
    //         .getAttribute("content"),
    //     },
    //     body: JSON.stringify({ search: inputValue }),
    //   })
    //     .then((response) => response.json())
    //     .then((data) => {
    //       data.projects.forEach((item) => {
    //         const p = document.createElement("p");
    //         p.innerHTML = item.name;
    //         this.containerTarget.appendChild(p);
    //       });
    //     });
    }
  }