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
    console.log('ADD TO QUEUE')
    $queue.append('<article class="queue-item" data-id="' + $(this).data('id') + '">' + '<div class="queue-item-title">' + $(this).data('title')+ '</div><div class="queue-item-icons"><img class="star-icon" src="/images/star.png"><img class="delete-from-queue" src="/images/cross.png"></div></article>')
    $queue.trigger('trackAdded')
  });

  $('#clear-queue').on('click', function(event){
    event.preventDefault();
    localStorage.clear();
    $queue.html(localStorage.getItem('queue-list'));
  });

  $('#play-queue').on('click', function(event){
    event.preventDefault();

    var youtubeVideoId = $("#queue article:nth-child(1)").data('id')

    window.location = '/?videoId='+youtubeVideoId
  });

  $('#next-in-queue').on('click', function(event) {
    event.preventDefault();

    var secondyoutubeVideoId =  $("#queue article:nth-child(2)").data('id')
    $('#player-iframe').attr('src', 'http://youtube.com/embed/' + secondyoutubeVideoId + '?autoplay=1')

    $("#queue article:nth-child(1)").remove()
    localStorage.setItem('queue-list', $queue.html());

  });

});
