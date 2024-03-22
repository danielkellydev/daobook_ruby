import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['modal', 'date'];

  connect() {
    this.element.addEventListener('click', this.openModal.bind(this));
  }

  openModal(event) {
    if (event.target.hasAttribute('data-appointment-modal-target')) {
      this.modalTarget.classList.remove('hidden');
      const selectedDate = event.target.getAttribute('data-date');
      this.dateTarget.value = selectedDate;
    }
  }

  closeModal() {
    this.modalTarget.classList.add('hidden');
  }
}