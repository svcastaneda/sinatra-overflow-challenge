$(document).ready(function() {
  // This is called after the document has loaded in its entirety
  // This guarantees that any elements we bind to will exist on the page
  // when we try to bind to them

  // See: http://docs.jquery.com/Tutorials:Introducing_$(document).ready()
	$('.answerCommentForm').hide();

	$('body').on('submit', '.answerCommentForm', function( event ) {
		event.preventDefault();
    var commentContent = $(this).serialize();
    var postId = $(this).closest('article').attr('id');

    var createRequest = $.ajax({
      url: '/answers/'+ postId + '/comments/new',
      type: 'POST',
      data: commentContent
    });

		createRequest.done(function(response){
			console.log(response)
      $('.answerDetails').append(response);
    });
	});

	$('body').on('submit', '.questionCommentForm', function( event ) {
		event.preventDefault();
    var commentContent = $(this).serialize();
    var postId = $('.question').attr('id');

    var createRequest = $.ajax({
      url: '/questions/'+ postId + '/comments/new',
      type: 'POST',
      data: commentContent
    });

		createRequest.done(function(response){
			console.log(response)
      $('.questionDetails').append(response);
    });
	});


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

	$('.question .vote a').on('click', function(event) {
		event.preventDefault();
		// var voteCount = $('.question .vote span').text()
//
//     var request = $.ajax({
// 			url: "/questions/" + $('.question').attr('value') + "/votes/new/",
//       method: "post",
//       dataType: "JSON"
//     });
//
//     request.done(function(response) {
// 			console.log(response['value'])
// 			$('.question .vote span').text(voteCount + response['vote']['value']);
//     });

	});

	$('.container').on('click', '.answer .vote a', function(event) {
		event.preventDefault();
    var voteButton = $(this);
		var voteCount = parseInt($(voteButton).parent().children('span').text());

		if (voteButton.attr('class') == 'arrow-up') { var value = 1 }
		else { var value = -1 };

    var request = $.ajax({
      url: "/answers/" + $('.answer').attr('id') + "/votes/new/" + value,
      method: "post",
      dataType: "JSON"
    });

    request.done(function(response) {
			$(voteButton).parent().children('span').text(voteCount + response['vote_value']);
    });

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

