import { Application } from "@hotwired/stimulus";
import BugController from "./controllers/bug_controller";

const application = Application.start();
application.register("bug", BugController);
