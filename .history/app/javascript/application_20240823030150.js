// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

import "trix"
import "@rails/actiontext"
import { Application } from "@hotwired/stimulus";
import BugController from "./controllers/bug_controller";
const application = Application.start();
application.register("bug", BugController);
