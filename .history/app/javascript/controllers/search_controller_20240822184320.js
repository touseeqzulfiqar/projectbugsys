import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search"
export default class extends Controller {
  connect() {
    console.log("hello")
  }

  suggestions(e) {
    console.log(e.target.value)
  }
}
