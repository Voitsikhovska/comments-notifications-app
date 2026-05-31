import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "dropdown"]

  connect() {
    this.mentionStart = null
    this.boundClose = this.closeOnClickOutside.bind(this)
    document.addEventListener("click", this.boundClose)
  }

  disconnect() {
    document.removeEventListener("click", this.boundClose)
  }

  async onInput() {
    const textarea = this.inputTarget
    const cursorPos = textarea.selectionStart
    const textBeforeCursor = textarea.value.substring(0, cursorPos)
    const match = textBeforeCursor.match(/@([a-zA-Z0-9_]*)$/)

    if (match) {
      this.mentionStart = cursorPos - match[0].length
      const query = match[1]
      const response = await fetch(`/users/search?q=${encodeURIComponent(query)}`)
      const usernames = await response.json()
      if (usernames.length > 0) {
        this.positionDropdown(textarea, this.mentionStart)
        this.showSuggestions(usernames)
      } else {
        this.hideSuggestions()
      }
    } else {
      this.hideSuggestions()
    }
  }

  positionDropdown(textarea, caretPos) {
    const coords = this.getCaretCoordinates(textarea, caretPos)
    const lineHeight = parseInt(window.getComputedStyle(textarea).lineHeight) || 20

    this.dropdownTarget.style.top = `${coords.top + lineHeight - textarea.scrollTop}px`
    this.dropdownTarget.style.left = `${coords.left}px`
  }

  getCaretCoordinates(textarea, position) {
    const mirror = document.createElement("div")
    const style = window.getComputedStyle(textarea)

    Object.assign(mirror.style, {
      position: "fixed",
      visibility: "hidden",
      top: "0",
      left: "0",
      width: style.width,
      padding: style.padding,
      border: style.border,
      font: style.font,
      lineHeight: style.lineHeight,
      whiteSpace: "pre-wrap",
      wordWrap: "break-word",
      overflow: "hidden"
    })

    mirror.textContent = textarea.value.substring(0, position)
    const marker = document.createElement("span")
    marker.textContent = "\u200b"
    mirror.appendChild(marker)

    document.body.appendChild(mirror)
    const mirrorRect = mirror.getBoundingClientRect()
    const markerRect = marker.getBoundingClientRect()
    document.body.removeChild(mirror)

    return {
      top: markerRect.top - mirrorRect.top,
      left: markerRect.left - mirrorRect.left
    }
  }

  showSuggestions(usernames) {
    this.dropdownTarget.innerHTML = usernames.map(username =>
      `<button type="button" class="mention-suggestion" data-username="${username}" data-action="click->mention-autocomplete#select">
        <span class="mention-suggestion-at">@</span>${username}
      </button>`
    ).join("")
    this.dropdownTarget.classList.remove("hidden")
  }

  select(event) {
    const username = event.currentTarget.dataset.username
    const textarea = this.inputTarget
    const cursorPos = textarea.selectionStart
    const before = textarea.value.substring(0, this.mentionStart)
    const after = textarea.value.substring(cursorPos)

    textarea.value = `${before}@${username} ${after}`
    const newPos = before.length + username.length + 2
    textarea.setSelectionRange(newPos, newPos)
    textarea.focus()
    this.hideSuggestions()
  }

  hideSuggestions() {
    this.dropdownTarget.classList.add("hidden")
    this.dropdownTarget.innerHTML = ""
  }

  closeOnClickOutside(event) {
    if (!this.element.contains(event.target)) {
      this.hideSuggestions()
    }
  }
}
