import { Application } from "@hotwired/stimulus";
import BugController from "./bug_controller";

const application = Application.start();
application.register("bug", BugController);
