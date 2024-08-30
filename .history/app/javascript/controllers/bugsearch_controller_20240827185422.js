import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="search"
export default class extends Controller {
  connect() {
    console.log("bugsearch connect...........");
  }
  static targets = ["container"];
  handleChange(e) {
    e.preventDefault();

  }
}
