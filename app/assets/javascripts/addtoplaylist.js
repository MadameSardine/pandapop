jQuery(document).ready( function ($) {

 	$('#results').on('click', '.add-to-playlist', function(event){
    event.preventDefault();
    console.log('ADD TO PLAYLIST POPUP');

    $playlistPopup = $(this).parents('.search-result-container').find('.playlists-popup');
    // $playlistPopup.css('left', event.pageX); //WHY NOT WORKING
    // $playlistPopup.css('top', event.pageY);
    $playlistPopup.css('display','block'); 
    $playlistPopup.css("position", "absolute");
    // $playlistPopup.css( {display: "block", position:"absolute", top:event.pageY, left: event.pageX})
  });

	$(document).on('click', ".playlist-popup-item", function(){

		var $this = $(this);
		var playlistId = $this.data().playlistid;
		var videoTitle = $this.parent().prev('.result-icons').find('.add-to-playlist').data().title;
		var videoId = $this.closest('.search-result-container').find('.title-and-thumbnail').data().video_id;
		var duration = $this.parent().prev('.result-icons').find('.add-to-playlist').data().duration;
		console.log(duration);
		var likeCount;


		$.ajax({
			type: "POST",
			url: "/tracks",
			data: {
				track: {
					playlists: playlistId,
					title: videoTitle,
					video_id: videoId,
					duration: duration
				}
			},
			success: function(data) {
				console.log(data);
				$this.css('background-color', "gray")
				$this.text('Added to playlist')
				$('.playlists-popup').fadeOut(1500)
				// alert("Track has been successfully added to playlist")
			}
		})
	});
});


	// $(document).on('click', ".star-icon", function() {
	// 		console.log('clicked')
	// 		var $this = $(this)
	// 		var starredPlaylist = $(document).find('#starred-playlists-bar').data().starredplaylist;
	// 		var videoTitle = $this.closest("article").find('.queue-item-title').text()
	// 		var videoId = $this.closest("article.queue-item").data().id;
	// 		// $this.attr("src", "/images/star-filled.png")
	// 	//if the image is not already filled, then post the track to the starred tracks playlist and fill the star in
	// 		if($(this).attr("src") == "/images/star.png"){
	// 	  	$.ajax({
	// 	    type: "POST",
	// 	    url: "/tracks",
	// 	    // dataType: 'json', // don't know wtf this is doing but it broke the success call
	// 	    data: {
	// 	      track: { 
	// 	        playlists: starredPlaylist,
	// 	        title: videoTitle,
	// 	        video_id: videoId
	// 	      }
	// 	    },
	// 	    success: function(data) {
	// 	    	console.log(data);
	// 	    	console.log(data.id);
	// 	      $this.attr("src", "/images/star-filled.png");
	// 	      $this.data('id', data.id);
	// 	      $this.attr('data-id', data.id)
	// 				localStorage.setItem('queue-list', $('#queue').html());
	// 	    },
	// 	    error: function(data) {
	// 	    }
	// 	  });
	// 	}
	// 	// else then delete the track from the starred tracks playlist and unfill the star
	// 		else {
	// 		  	$.ajax({
	// 		    type: "DELETE",
	// 		    url: "/tracks/"+ $this.data('id'),
	// 		    data: {},
	// 		    success: function(data) {
	// 		      // alert("The post was successful");
	// 		      $this.attr("src", "/images/star.png");
	// 		      $this.removeAttr('data-id')
	// 		      localStorage.setItem('queue-list', $('#queue').html());

	// 		    },
	// 		    error: function(data) {
	// 		    }
	// 		  });
	// 		}
	// });
// });

