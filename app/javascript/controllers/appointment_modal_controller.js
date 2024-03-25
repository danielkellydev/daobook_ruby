import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ['modal', 'date'];

  openModal(event) {
    const dateElement = event.target.closest('[data-appointment-modal-target="date"]');
    if (dateElement) {
      this.modalTarget.classList.remove('hidden');
      const selectedDate = dateElement.getAttribute('data-date');
      const selectedTime = dateElement.getAttribute('data-time');
      document.getElementById('selected_date').value = selectedDate;
      document.getElementById('start_time').value = `${selectedDate}T${selectedTime}`;
      console.log('Selected Date:', selectedDate);
      console.log('Selected Time:', selectedTime);
    }
  }

  closeModal() {
    this.modalTarget.classList.add('hidden');
  }
}