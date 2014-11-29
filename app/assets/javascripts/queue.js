jQuery(document).ready(function ($) {

  var $queue = $('#queue');

  if(localStorage.getItem('queue-list')) {
    $queue.html(localStorage.getItem('queue-list'));
  };

  $queue.on('trackAdded', function() {
    localStorage.setItem('queue-list', $(this).html());
    console.log('track added')
    $queue.scrollTop($queue.height());
  });

  $('#results').on('click', '.add-to-queue', function(event){
    event.preventDefault();
    $queue.append('<p class="queue-item" data-id="' + $(this).data('id') + '">' + $(this).data('title')+'</p>')
    $queue.trigger('trackAdded')
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

  $('#next-in-queue').on('click', function(event) {
    event.preventDefault();

    var secondyoutubeVideoId =  $("#queue p:nth-child(2)").data('id')
    $('#player-iframe').attr('src', 'http://youtube.com/embed/' + secondyoutubeVideoId + '?autoplay=1')

    $("#queue p:nth-child(1)").remove()
    localStorage.setItem('queue-list', $queue.html());

  });

});
