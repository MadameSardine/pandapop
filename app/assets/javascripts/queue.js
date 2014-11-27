jQuery(document).ready(function ($) {

  // $('#results').on('click', '.queue', function(event){
  //   event.preventDefault();
  //   $('#tracks-queue').append('<li class="queue-title">' + '<a href="http://youtube.com/watch/' + $(this).data('id') + '">' + $(this).data('title') + '</a></li>')
  // });

  // $('#results').on('click', '.search-result-container', function(event){
  //   event.preventDefault();
  //   var $this = $(this);
  //   var videoId = $this.find('#track_video_id').val();
  //   window.location = '/player?videoId=' + videoId;
  // });
  var title;
  if (localStorage.getItem('title') === undefined) {
    title = [];
  } else {
    title = localStorage.getItem('title');
  }

  debugger

  // var queue = document.getElementById('queue-bar')

  // $(queue).bind("DOMSubtreeModified", function() {
  //   localStorage.setItem()

  // })

  $('#results').on('click', '.add-to-queue', function(event){
    event.preventDefault();
    // // $('#queue').text(title)
    title.push($(this).data("title"));
    localStorage.setItem["title"] = title;
    console.log(title)
    $('#queue').text(title)
  });

});
