import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="votes"
export default class extends Controller {
  static targets = ["likes", "dislikes"];

  connect() {
    console.log("Votes controller connected!");
  }

  upvote(event) {
    event.preventDefault();
    console.log("Upvote clicked!");

    const billboardId = event.currentTarget.dataset.id;

    fetch(`/home/${billboardId}/upvote`, {
      method: "POST",
      headers: { "X-CSRF-Token": document.querySelector("meta[name='csrf-token']").content, "Content-Type": "application/json" }
    })
    .then(response => response.json())
    .then(data => {
      console.log("Upvote response:", data);
      this.likesTarget.textContent = data.likes;
      this.dislikesTarget.textContent = data.dislikes;
    })
    .catch(error => console.error("Error:", error));
  }

  downvote(event) {
    event.preventDefault();
    console.log("Downvote clicked!"); 

    const billboardId = event.currentTarget.dataset.id;

    fetch(`/home/${billboardId}/downvote`, {
      method: "POST",
      headers: { "X-CSRF-Token": document.querySelector("meta[name='csrf-token']").content, "Content-Type": "application/json" }
    })
    .then(response => response.json())
    .then(data => {
      console.log("Downvote response:", data); 
      this.likesTarget.textContent = data.likes;
      this.dislikesTarget.textContent = data.dislikes;
    })
    .catch(error => console.error("Error:", error));
  }
}
