import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="bugsearch"
export default class extends Controller {
  static targets = ["container"];

  connect() {
    console.log("bugsearch connected...");
  }

  handleChange(e) {
    console.log("bugsearch handleChange", e.target.value);
    
    e.preventDefault();
  }
}
