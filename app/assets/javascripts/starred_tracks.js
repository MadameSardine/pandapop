jQuery(document).ready( function ($) {

	$(document).on('click', ".star-icon", function() {
			console.log('clicked')
			var $this = $(this)
			var starredPlaylist = $(document).find('#starred-playlists-bar').data().starredplaylist;
			var videoTitle = $this.closest("article").find('.queue-item-title').text()
			var videoId = $this.closest("article.queue-item").data().id;
			var duration = $this.closest("article.queue-item").data().duration;
			// $this.attr("src", "/images/star-filled.png")
		//if the image is not already filled, then post the track to the starred tracks playlist and fill the star in
			if($(this).attr("src") == "/images/star.png"){
		  	$.ajax({
		    type: "POST",
		    url: "/tracks",
		    // dataType: 'json', // don't know wtf this is doing but it broke the success call
		    data: {
		      track: { 
		        playlists: starredPlaylist,
		        title: videoTitle,
		        video_id: videoId,
		        duration: duration
		      }
		    },
		    success: function(data) {
		    	console.log(data);
		    	console.log(data.id);
		      $this.attr("src", "/images/star-filled.png");
		      $this.data('id', data.id);
		      $this.attr('data-id', data.id)
					localStorage.setItem('queue-list', $('#queue').html());
		    },
		    error: function(data) {
		    }
		  });
		}
		// else then delete the track from the starred tracks playlist and unfill the star
			else {
			  	$.ajax({
			    type: "DELETE",
			    url: "/tracks/"+ $this.data('id'),
			    data: {},
			    success: function(data) {
			      // alert("The post was successful");
			      $this.attr("src", "/images/star.png");
			      $this.removeAttr('data-id')
			      localStorage.setItem('queue-list', $('#queue').html());

			    },
			    error: function(data) {
			    }
			  });
			}
	});
});

