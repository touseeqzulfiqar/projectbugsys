import { Application } from "@hotwired/stimulus"
import BugController from "./bug_controller"
const application = Application.start()
application.register("bug", BugController);
// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }
