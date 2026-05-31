import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["modal", "box", "deleteForm"]

  show(event) {
    event.preventDefault()
    this.deleteFormTarget.action = event.currentTarget.dataset.confirmUrl
    this.modalTarget.classList.add("is-open")
    document.body.classList.add("overflow-hidden")
  }

  hide() {
    this.modalTarget.classList.remove("is-open")
    document.body.classList.remove("overflow-hidden")
  }

  backdropClick(event) {
    if (!this.boxTarget.contains(event.target)) {
      this.hide()
    }
  }
}

