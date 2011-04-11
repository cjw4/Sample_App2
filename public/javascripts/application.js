$(document).ready(function() {
	var contentContainer = $("#micropost_content")
	
	contentContainer.live("keyup", function() {
		var characters = contentContainer.val().length;
		$(".numberCharacters").html(140 - characters);
	});
});
