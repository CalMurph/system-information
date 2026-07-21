import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["source", "button"]
  static values = {
    successDuration: { type: Number, default: 2000 }
  }

  copied = document.getElementById('copied')

  connect() {
    // Save the original button text so we can revert it later
    if (this.hasButtonTarget) {
      this.originalText = this.buttonTarget.innerText
    }
  }

  copy(event) {
    event.preventDefault()

    const text = this.textToCopy()

    // Copy to clipboard
    navigator.clipboard.writeText(text).then(() => {
      this.showSuccess()
    }).catch(() => {
      console.error("Failed to copy text")
    })
  }

  // Helper to determine what text to copy
  textToCopy() {
    if (this.sourceTarget.nodeName === "INPUT" || this.sourceTarget.nodeName === "TEXTAREA") {
      return this.sourceTarget.value
    } else {
      return this.sourceTarget.textContent.trim()
    }
  }

  // Visual feedback
  showSuccess() {
    if (!this.hasButtonTarget) return

    const copied = document.getElementById('copied')
    const copy = document.getElementById('copy')

    // this.buttonTarget.innerText = "Copied!"
    copy.classList.add('hidden')
    copied.classList.remove('hidden')
    this.buttonTarget.disabled = true

    setTimeout(() => {
      // this.buttonTarget.innerText = "Copy"
      copy.classList.remove('hidden')
    copied.classList.add('hidden')
      this.buttonTarget.disabled = false
    }, this.successDurationValue)
  }
}
