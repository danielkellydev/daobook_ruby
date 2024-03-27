import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    this.element.setAttribute('draggable', 'true');
    this.element.addEventListener('dragstart', this.dragstart.bind(this));
  }

  dragstart(event) {
    console.log('dragstart');
    event.dataTransfer.setData('text/plain', this.element.dataset.appointmentId);
  }
}