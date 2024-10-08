// Import and register all your controllers from the importmap under controllers/

// Eager load all controllers defined in the import map under controllers/**/*_controller
import { Application } from "@hotwired/stimulus";
import BugController from "./bug_controller";
import SearchController from "./search_controller";
import ProjectUserController from "./project_user_controller";

// Lazy load controllers as they appear in the DOM (remember not to preload controllers in import map!)
// import { lazyLoadControllersFrom } from "@hotwired/stimulus-loading"
// lazyLoadControllersFrom("controllers", application)

const application = Application.start();
application.register("bug", BugController);
application.register("search", SearchController);
application.register("project-user", ProjectUserController);