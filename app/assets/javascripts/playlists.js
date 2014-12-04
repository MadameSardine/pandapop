// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.


jQuery(document).ready(function ($) {

	var $queue = $('#queue');

	$('#play-all').on('click', function(event){
		event.preventDefault();

	var $this	= $('.playlist-tracks')

		$this.children().find(".track-item").each(function() {
				console.log($(this.data));
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


		// var request = $.ajax({
		//     type: "GET",
		//     url: "/playlists/"+playlistId,
		//     success: function(playlist) {
		//     	console.log(playlist)
		//     	console.log(playlist.tracks)
		//     },
		//     error: function(data) {
		//     }
		// });

		// request.done(function(json){
		// 	var name = json[0]["name"]
		// 	var peep_length = (json[1]).length
		// 	var peep_content = []
		// 	var context = []
		// 	for (i = 0; i< peep_length; i++){
		// 		peep_content[i] = json[1][i]["content"]
		// 		var source = $('#peepTemplate').html();
		// 		var template = Handlebars.compile(source);
		// 		context[i] = {
		// 				name: name,
		// 				username: profile_name,
		// 				peepContent: peep_content[i]
		// 				};
		// 		console.log(context[i])
		// 		$('#user_peeps').append(template(context[i]));
		// 		$('#user_peeps article').last().addClass('peep_list');
		// 			}
		// 	$('#profile_name').val('');

		// });

	});
	
});
