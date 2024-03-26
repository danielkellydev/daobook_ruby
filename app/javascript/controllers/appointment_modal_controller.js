import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ['modal', 'date', 'showModal', 'editModal'];

  openModal(event) {
    if (event.target.closest('[data-appointment-modal-target="date"]')) {
      this.modalTarget.classList.remove('hidden');
      const selectedDate = event.target.getAttribute('data-date');
      const selectedTime = event.target.getAttribute('data-time');
      const selectedTime12Hour = this.convertTo12HourFormat(selectedTime);
      document.getElementById('selected_date').value = selectedDate;
      document.getElementById('start_time').value = `${selectedDate}T${selectedTime}`;
      this.setStartTimeDropdown(selectedTime12Hour);

      // Update the URL with the start_time parameter
      const url = new URL(window.location.href);
      url.searchParams.set('start_time', `${selectedDate}T${selectedTime}`);
      window.history.pushState({}, '', url);
    }
  }

  closeModal() {
    this.modalTarget.classList.add('hidden');
  }

  showAppointment(event) {
    event.preventDefault();
    const appointmentId = event.target.closest('[data-appointment-id]').getAttribute('data-appointment-id');
    fetch(`/appointments/${appointmentId}`)
      .then(response => response.text())
      .then(html => {
        document.getElementById('appointment-details').innerHTML = html;
        this.showModalTarget.classList.remove('hidden');
      });
  }

  closeShowModal() {
    this.showModalTarget.classList.add('hidden');
  }

  openEditModal() {
    const appointmentId = document.querySelector('#appointment-details [data-appointment-id]').getAttribute('data-appointment-id');
    fetch(`/appointments/${appointmentId}/edit`)
      .then(response => response.text())
      .then(html => {
        document.getElementById('edit-appointment-form').innerHTML = html;
        this.showModalTarget.classList.add('hidden');
        this.editModalTarget.classList.remove('hidden');
      });
  }

  closeEditModal() {
    this.editModalTarget.classList.add('hidden');
    this.showModalTarget.classList.remove('hidden');
  }

  setStartTimeDropdown(selectedTime) {
    const startTimeDropdown = document.getElementById('start_time_dropdown');
  
    for (let i = 0; i < startTimeDropdown.options.length; i++) {
      if (startTimeDropdown.options[i].text === selectedTime) {
        startTimeDropdown.selectedIndex = i;
        break;
      }
    }
  }

  convertTo12HourFormat(time24) {
    let [hour, minutes] = time24.split(':');
    hour = parseInt(hour);
    const period = hour >= 12 ? 'PM' : 'AM';
  
    if (hour > 12) hour -= 12;
    else if (hour === 0) hour = 12;
  
    return `${hour.toString().padStart(2, '0')}:${minutes} ${period}`;
  }
}