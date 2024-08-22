import "controllers";
import "./packs/users";
import Rails from "@rails/ujs";
import "@hotwired/turbo-rails";
import * as ActiveStorage from "@rails/activestorage";

Rails.start();
ActiveStorage.start();

