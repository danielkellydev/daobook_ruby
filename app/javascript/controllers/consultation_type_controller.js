import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    url: String
  }

  loadFields() {
    const consultationType = this.element.querySelector('select[name="consultation[consultation_type]"]').value;
    const url = this.urlValue + "?consultation_type=" + consultationType;
  
    fetch(url, {
      headers: {
        Accept: "text/html"
      }
    })
      .then(response => response.text())
      .then(html => {
        document.getElementById('consultation_fields').innerHTML = html;
      });
  }
}