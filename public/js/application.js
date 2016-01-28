$(document).ready(function() {
  // This is called after the document has loaded in its entirety
  // This guarantees that any elements we bind to will exist on the page
  // when we try to bind to them

  // See: http://docs.jquery.com/Tutorials:Introducing_$(document).ready()
	$('.answerCommentForm').hide();

	// $('form.').on('submit', function( event ) {
// 		event.preventDefault();
//     var commentContent = $(this).serialize();
//
//     var createRequest = $.ajax({
//       url: 'comments/',
//       type: 'POST',
//       data: commentContent
//     });
//
// 		createRequest.done(function(response){
//       $('').append(response);
//     });
// 	});

	$('button.addComment').on('click', function(event) {
		$('form.newComment').show();
	});

	$('.container').on('click', '.answer .addComment', function(event) {
		console.log('wuuuuuut');
		$(this).hide();
		$(this).next().show();
	});

	$('.container').on('submit', '.answer .answerCommentForm', function(event) {
		event.preventDefault();
		$(this).hide();
		$(this).prev().show();
	});


	$('.container').on('click','.starred-clickable', function(event) {
		event.preventDefault();
		var answerID = $(this).closest('article').attr('id');
		var star = $(this);
		var changeStar = $.ajax({
			url: '/answers/'+answerID,
			type: 'PUT',
			data: {"starred":false}
		});
		changeStar.done(function() {
			// change to appropriate CSS
		});
	});

$('.container').on('click','.not-starred', function(event) {
		event.preventDefault();
		var questionID
		var answerID = $(this).closest('article').attr('id');
		var star = $(this);
		var changeStar = $.ajax({
			url: '/answers/'+answerID,
			type: 'PUT',
			data: {starred: "true"}
		});
		changeStar.done(function() {
			// change to appropriate CSS
		});
	});

});

