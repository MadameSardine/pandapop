// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.


jQuery(document).ready(function ($) {

	var $queue = $('#queue');

	$('#play-all').on('click', function(){
		// event.preventDefault();

	var $playlist	= $('#playlist-tracks-container')

		$playlist.children("#track-title").each(function() {
			$queue.append('<article class="queue-item" data-id="' + $(this).data('videoid') + '">' + '<div class="queue-item-title">' + $(this).find('.track-title-value').text() +'</div><div class="queue-item-icons"><img class="star-icon" src="/images/star.png"><img class="delete-from-queue" src="/images/cross.png"></div></article>')
		});

		localStorage.setItem('queue-list', $queue.html());

	});

	$('.add-playlist-track-to-queue').on('click', function(event) {
		event.preventDefault();

		$queue.append('<article class="queue-item" data-id="' + $(this).closest('li').data('id') + '">' + $(this).closest('li').data('title')+'</article>')

		localStorage.setItem('queue-list', $queue.html());

	});
 // when you click play all
 // append each track item in the playlist to the queue
});


// AJAX GETS FOR THE PLAYLIST PAGE

jQuery(document).ready(function ($) {

	$(document).on('click', ".playlist-button", function() {

		$('#playlist-tracks-container').empty();

		$this = $(this);
		var playlistId = $this.data("playlistid");
		console.log('this is playlist id',playlistId)


		var request = $.ajax({
		    type: "GET",
		    url: "/playlists/"+playlistId,
		});

		request.done(function(json){
			console.log(json);

			var playlistName = json.name;
			console.log(playlistName);
			var datePlaylistCreated = json.created_at;
			console.log(datePlaylistCreated)
			var fullName = json.user.first_name + " " + json.user.last_name;
			console.log(fullName);
			var fullName = json.user.first_name + " " + json.user.last_name;
			console.log(fullName);
			var numberOfTracks = json.tracks.length
			console.log(numberOfTracks)
			var trackTitle = [];
			var trackDuration = [];
			var videoId = []
			var context = []



			for (i = 0; i < numberOfTracks; i++) {
				trackTitle[i] = json.tracks[i].title
				trackDuration[i] = json.tracks[i].duration
				videoId[i] = json.tracks[i].video_id
				var source = $('#trackTemplate').html();
				var template = Handlebars.compile(source);
				context[i] = {
					playlistname: playlistName,
					dateplaylistcreated: datePlaylistCreated,
					fullname: fullName,
					tracktitle: trackTitle[i],
					trackduration: trackDuration[i],
					videoid: videoId[i]
					};
				console.log(context[i])
				$('#playlist-tracks-container').append(template(context[i]));
			};

		});

	});

});
