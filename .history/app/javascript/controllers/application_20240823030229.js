import { Application } from "@hotwired/stimulus"
import BugController from "./bug_controller"
const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }
