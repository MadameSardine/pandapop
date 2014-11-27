jQuery(document).ready(function ($) {

  var queue = document.getElementById('queue')

  $(queue).bind("DOMSubtreeModified", function() {
    localStorage.setItem('queue-list', this.innerHTML );
  })


  $('#results').on('click', '.add-to-queue', function(event){
    event.preventDefault();
    console.log(this);
    $('#queue').append('<p class="queue-item" id="' + $(this).data('id') + '">' + $(this).data('title')+'</p>')
  });

  if(localStorage.getItem('queue-list', this.innerHTML)) {
    queue.innerHTML = localStorage.getItem('queue-list');
  };

  // $('#clear-queue').on('click', function(event){
  //   event.preventDefault();
  //   window.localStorage.clear();
  // });

});
