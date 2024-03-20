import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['modal'];

  connect() {
    this.element.addEventListener('click', this.openModal.bind(this));
  }

  openModal(event) {
    if (event.target.hasAttribute('data-modal-target')) {
      this.modalTarget.classList.remove('hidden');
    }
  }

  closeModal() {
    this.modalTarget.classList.add('hidden');
  }
}