import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    console.log('DropZone connected');
    this.element.addEventListener('dragover', this.dragover.bind(this));
    this.element.addEventListener('drop', this.drop.bind(this));
  }

  dragover(event) {
    event.preventDefault();
    const date = this.element.dataset.date;
    const time = this.element.dataset.time;
    console.log(`dragover {day: ${date}, time: ${time}}`);
  }

  drop(event) {
    console.log('drop');
    event.preventDefault();
  
    const appointmentId = event.dataTransfer.getData('text/plain');
    console.log(appointmentId);
  
    fetch(`/appointments/${appointmentId}`, {
      method: 'PUT',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
      },
      body: JSON.stringify({
        appointment: {
          selected_date: this.element.dataset.date,
          start_time: this.element.dataset.time,
        },
      }),
    })
    .then(response => {
      if (!response.ok) {
        throw new Error("HTTP error " + response.status);
      }
      return response.json();
    })
    .then(data => {
      console.log(data);
  
      if (data.status === 'success') {
        const appointmentFrame = document.getElementById(`appointment_${appointmentId}`);
        console.log(appointmentFrame);
  
        if (appointmentFrame) {
          // Remove the old appointment block from the DOM
          appointmentFrame.remove();
  
          // Find the new position for the appointment block in the calendar
          let newAppointmentPosition = document.querySelector(`#new-appointment-position-selector`);
          console.log(newAppointmentPosition); // Debug line
  
          // Insert the updated appointment block at the new position
          if (newAppointmentPosition) {
            newAppointmentPosition.insertAdjacentHTML('beforebegin', data.appointment_html);
          } else {
            console.error('Could not find new appointment position');
          }
        } else {
          console.error(`Could not find Turbo Frame with id appointment_${appointmentId}`);
        }
      } else if (data.status === 'error') {
        console.error(data.message);
      }
    })
    .catch(function() {
      console.log("Fetch error: Could not update appointment.");
    });
  }
}