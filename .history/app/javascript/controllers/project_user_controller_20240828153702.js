import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    console.log("project_user connect");
    this.usersContainer = document.getElementById("users-fields");
    this.addButton = document.getElementById("add-user-button");

    this.addButton.addEventListener("click", (event) => {
      event.preventDefault();
      this.addUserFields();
    });
  }

  addUserFields() {
    console.log("addUserFields");
    const template = document.querySelector("#user-fields-template").innerHTML;
    const newUserFields = template.replace(
      /TEMPLATE_INDEX/g,
      new Date().getTime()
    );
    this.usersContainer.insertAdjacentHTML("beforeend", newUserFields);

    this.usersContainer.querySelectorAll(".remove-user").forEach((button) => {
      button.addEventListener("click", (event) => {
        event.preventDefault();
        button.closest(".nested-fields").remove();
      });
    });
  }
}
