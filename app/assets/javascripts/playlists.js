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
