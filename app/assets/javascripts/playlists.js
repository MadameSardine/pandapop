// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.


jQuery(document).ready(function ($) {

	var $queue = $('#queue');

	$('#play-all').on('click', function(event){
		event.preventDefault();

		$("li").each(function() {
			$queue.append('<article class="queue-item" data-id="' + $(this).data('id') + '">' + $(this).data('title')+'</article>')	
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

		$this = $(this);
		playlistId = $this.data("playlistid");

		// $.ajax({
		//     type: "GET",
		//     url: "/playlists/"+playlistId,
		//     success: function(playlist) {
		//     	console.log(playlist)
		//     	console.log(playlist.tracks)
		//     },
		//     error: function(data) {
		//     }
		// });


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
			var exampleTrackTitle = json.tracks[1].title
			console.log(exampleTrackTitle)
			var trackTitle = [];
			var trackDuration = [];
			var context = []

			for (i = 0; i < numberOfTracks; i++) {
				trackTitle[i] = json.tracks[i].title
				trackDuration[i] = json.tracks[i].duration
				var source = $('#trackTemplate').html();
				var template = Handlebars.compile(source);
				context[i] = {
					playlistname: playlistName,
					dateplaylistcreated: datePlaylistCreated,
					fullname: fullName,
					tracktitle: trackTitle[i],
					trackduration: trackDuration[i]
					};
				console.log(context[i])
				$('.inner-grid-right').append(template(context[i]));
			};



			// var name = json[0]["name"]
			// var peep_length = (json[1]).length
			// var peep_content = []
			// var context = []
			// for (i = 0; i< peep_length; i++){
			// 	peep_content[i] = json[1][i]["content"]
			// 	var source = $('#peepTemplate').html();
			// 	var template = Handlebars.compile(source);
			// 	context[i] = {
			// 			name: name,
			// 			username: profile_name,
			// 			peepContent: peep_content[i]
			// 			};
			// 	console.log(context[i])
			// 	$('#user_peeps').append(template(context[i]));
			// 	$('#user_peeps article').last().addClass('peep_list');
			// 		}
			// $('#profile_name').val('');

		});

	});
	
});
