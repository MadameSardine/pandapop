// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

jQuery(document).ready(function ($) {

  $('#top-bar-search').keyup(function () {

    // the search term
    var q = $('#top-bar-search').val().trim();

    // container to display search results
    var $results = $('#results');

    // YouTube Data API base URL (JSON response)
    // var url = "http://gdata.youtube.com/feeds/api/videos/?v=2&alt=jsonc&callback=?"

    var url = "https://www.googleapis.com/youtube/v3/search?part=snippet&maxResults=3"

    var api_key = "AIzaSyDX1TrCX_GkuuCFBaQHvVDRc24Rq3HL-Sk"
    var type = "video"


    // // set paid-content as false to hide movie rentals
    // url = url + '&paid-content=false';

    // // set duration as long to filter partial uploads
    // url = url + '&duration=any';

    // // order search results by view count
    // url = url + '&orderby=viewCount';

    // // we can request a maximum of 50 search results in a batch
    // url = url + '&max-results=50';

    $.getJSON(url + "&q=" + q + "&type=" + type +"&key=" + api_key, function (json) {

      var count = 0;

      if (json.items) {

        var items = json.items;
        var html = "";

        items.forEach(function (item) {
          console.log('item:', item)


          // Check the duration of the video,
          // full-length movies are generally longer than 1 hour
          var duration = Math.round((item.duration) / (60 * 60));

          // Filter out videos that aren't in the Music category

            // Include the YouTube Watch URL youtu.be
            html += '<p><a href="http://youtu.be/' + item.id.videoId + '">';

            // Add the default video thumbnail (default quality)
            // html += '<img src="http://i.ytimg.com/vi/' + item.id + '/default.jpg">';

            // Add the embed video
            html += '<iframe width="640" height="390" src="http://youtube.com/embed/' + item.id.videoId + '"/>'

            // Add the video title and the duration
            html += '<h2>' + item.snippet.title + ' ' + '</h2></a></p>';
            count++;

        });
      }

      // Did YouTube return any search results?
      if (count === 0) {
        $results.html("No videos found");
      } else {
        // Display the YouTube search results
        $results.html(html);
      }
    });
  });
});

