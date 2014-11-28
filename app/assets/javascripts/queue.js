jQuery(document).ready(function ($) {

  var queue = document.getElementById('queue');

  $(queue).bind("DOMSubtreeModified", function() {
    localStorage.setItem('queue-list', JSON.stringify(this.innerHTML));
  });

  $('#results').on('click', '.add-to-queue', function(event){
    event.preventDefault();
    console.log(this);
    $('#queue').append('<p class="queue-item" id="' + $(this).data('id') + '">' + $(this).data('title')+'</p>')
  });

  $('#clear-queue').on('click', function(event){
    event.preventDefault();
    localStorage.clear();
    queue.innerHTML = JSON.parse(localStorage.getItem('queue-list'));
  });

  if(localStorage.getItem('queue-list', this.innerHTML)) {
    queue.innerHTML = JSON.parse(localStorage.getItem('queue-list'));
  };

});
