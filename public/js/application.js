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
      $('.questionComments').append(response);
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
});
