jQuery(document).ready(function ($) {

  var $queue = $('#queue');

  if(localStorage.getItem('queue-list')) {
    $queue.html(localStorage.getItem('queue-list'));
  };

  $queue.on('trackAdded', function() {
    localStorage.setItem('queue-list', $(this).html());
  });

  $('#results').on('click', '.add-to-queue', function(event){
    event.preventDefault();
    $queue.append('<p class="queue-item" data-id="' + $(this).data('id') + '">' + $(this).data('title')+'</p><br>')
    $queue.trigger('trackAdded')
    // localStorage.setItem('queue-list', $(this).html());

  });

  $('#clear-queue').on('click', function(event){
    event.preventDefault();
    localStorage.clear();
    $queue.html(localStorage.getItem('queue-list'));
  });

  $('#play-queue').on('click', function(event){
    event.preventDefault();

    var youtubeVideoId = $("#queue p:nth-child(1)").data('id')

    window.location = '/player?videoId='+youtubeVideoId
  });

// 'next' on click should
// 1) Put the youtube video id of the n+1 child into the iframe
// 2) delete from the queue the track that was just playing

  if(localStorage.getItem('queue-list', this.innerHTML)) {
    queue.innerHTML = localStorage.getItem('queue-list');
  };

  $('#player-link').on('click', function(event){
    event.preventDefault();
  });

});
