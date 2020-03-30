var bouton = document.querySelector("#soignant");
var rr = document.querySelector("#rr");
var aa = document.querySelector(".login-wrap");
var dd = document.querySelector("#aa");
function check() {
    bouton.checked = true;
    if (bouton.value = true) {
        rr.style.display = "block";
        dd.classList.remove("col-12")
        rr.classList.add("col-6")
        dd.classList.add("col-6")
        aa.style.maxWidth = "750px";
    }
    
  }
  function ChechOut() {
    rr.style.display = "none";
    aa.style.maxWidth = "450px";
    dd.classList.add("col-12")
    rr.classList.remove("col-6")
    dd.classList.remove("col-6")
  }
 
  // Get the modal
  var modal = document.getElementById("myModal");

  // Get the button that opens the modal
  var btn = document.getElementById("myBtn");
  
  // Get the <span> element that closes the modal
  var span = document.getElementsByClassName("close")[0];
  
  // When the user clicks on the button, open the modal
  btn.onclick = function() {
    modal.style.display = "block";
  }
  
  // When the user clicks on <span> (x), close the modal
  span.onclick = function() {
    modal.style.display = "none";
  }
  
  // When the user clicks anywhere outside of the modal, close it
  window.onclick = function(event) {
    if (event.target == modal) {
      modal.style.display = "none";
    }
  }
  


