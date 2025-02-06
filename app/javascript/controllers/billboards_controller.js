import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["list", "pagination"];

  connect() {
    console.log(" Billboards Stimulus Controller Connected");
  }

  filter(event) {
    console.log(event);
    event.preventDefault(); 
    const url = event.currentTarget.href;
    const currentPath = window.location.pathname;

    if (currentPath.startsWith("/home/batch_import")) {
      window.location.href = "/";
    }

    fetch(url, {
      headers: { 
        "X-Requested-With": "XMLHttpRequest",
        "Accept": "application/json"
      }
    })
      .then(response => response.json())
      .then(data => {
        const billboardContainer = document.querySelector("#billboards-container")
        if (billboardContainer) {
            billboardContainer.innerHTML = data.html
        }
      })
      .catch(error => console.error(" Fetch error:", error));
  }
}
