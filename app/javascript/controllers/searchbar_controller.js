import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="searchbar"
export default class extends Controller {
  connect() {
  }

  addActive(event) {
    event.target.classList.add('active');
    event.target.value = "";
  }
}
