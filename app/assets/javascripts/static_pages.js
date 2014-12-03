// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

jQuery(document).ready(function ($) {

  $('#playlist-list').hide();

  $('#results').on('click', '.queue', function(event){
    event.preventDefault();
    $('#tracks-queue').append('<li class="queue-title">' + '<a href="http://youtube.com/watch/' + $(this).data('id') + '">' + $(this).data('title') + '</a></li>')
  });

  $('#results').on('click', '.title-and-thumbnail', function(event){
    event.preventDefault();
    var videoId = $(this).data('video_id');
    window.location = '/?videoId=' + videoId;
  });

  var position = 0;

  $('#scroll-right-button').on('click', function(event){
    if (position === -7) {
      return false
    } else {
      position-=1;
    }
    console.log(position)
    event.preventDefault();
    $('#all-search-results').animate({
        marginLeft: "-=340px"
      }, "fast");
  });

    $('#scroll-left-button').on('click', function(event){
    if (position === 0) {
      return false
    } else {
      position+=1;
    }
      console.log(position)
      event.preventDefault();

    $('#all-search-results').animate({
        marginLeft: "+=340px"
      }, "fast");
  })

});
