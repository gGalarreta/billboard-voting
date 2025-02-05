import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["list", "pagination"];

  connect() {
    console.log("Billboards Stimulus Controller Connected");
  }

  filter(event) {
    event.preventDefault();
    const url = event.currentTarget.href;

    fetch(url, {
      headers: { "X-Requested-With": "XMLHttpRequest" },
    })
      .then((response) => response.text())
      .then((html) => {
        this.listTarget.innerHTML = new DOMParser()
          .parseFromString(html, "text/html")
          .querySelector("#billboards-container").innerHTML;

        this.paginationTarget.innerHTML = new DOMParser()
          .parseFromString(html, "text/html")
          .querySelector("#pagination-container").innerHTML;
      });
  }
}
