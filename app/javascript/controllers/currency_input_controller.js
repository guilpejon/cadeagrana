import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["display", "hidden"]

  connect() {
    const val = this.hiddenTarget.value
    if (val && parseFloat(val) > 0) {
      const cents = Math.round(parseFloat(val) * 100)
      this.displayTarget.value = this._format(cents)
    }
  }

  input(event) {
    const digits = event.target.value.replace(/\D/g, "")
    const cents = parseInt(digits || "0", 10)
    this.displayTarget.value = cents > 0 ? this._format(cents) : ""
    this.hiddenTarget.value = (cents / 100).toFixed(2)
    this.hiddenTarget.dispatchEvent(new Event("input", { bubbles: true }))
  }

  _format(cents) {
    return (cents / 100).toFixed(2).replace(".", ",")
  }
}
