jQuery(document).ready(function ($) {

  $(".search-result-container").draggable({
    
    // helper: "clone", // use a clone for the visual effect
    cursorAt: { top: 0, left: 0, right: 0},
    zIndex: 100000000,
    appendTo: "body",

    helper: function(){
      // return a custom element to be used for dragging
      return $("<div></div>",{ 
        text: $(this).find('.title').text(),
        class:"draggable-title",
      })
    },
    revert: false
  });

  $("#queue-bar").droppable({
    accept: "article",
    hoverClass: "ui-state-active",
    drop: function(event, ui) {

    	var title = ui.draggable.clone().find('.title').text();
    	var videoId = ui.draggable.clone().find('.title-and-thumbnail').data().video_id
    	
    	var newQueueItem = '<p class="queue-item" data-id="' + videoId + '">' + title + '</p>'
      $('#queue').append(newQueueItem)


    	localStorage.setItem('queue-list', $('#queue').html());

      // ui.draggable.clone().appendTo($('#queue')); // actually append a clone to the droppable
    }
  });
});
