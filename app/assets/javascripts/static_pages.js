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
    var $this = $(this);
    var videoId = $this.find('#track_video_id').val();
    window.location = '/player?videoId=' + videoId;
  });

});
