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
      $('#'+postId + ' .answerDetails').append(response);
      $(".answerCommentForm").trigger("reset");
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
      $('.questionComments').append(response);
      $(".questionCommentForm").trigger("reset");
    });
	});


	$('.container').on('click', 'button.addComment', function(event) {
		$('form.newComment').show();
	});

	$('.container').on('click', '.answer .addComment', function(event) {
		$(this).hide();
		$(this).next().show();
	});

	$('.container').on('submit', '.answer .answerCommentForm', function(event) {
		event.preventDefault();
		$(this).hide();
		$(this).prev().show();
	});

	$('.container').on('click', '.question .vote a', function(event) {
		event.preventDefault();

    var request = $.ajax({
			url: $(this).attr('href'),
      method: "post",
      dataType: "JSON"
    });

    request.done(function(response) {
			$('.question .vote span').text(response['score']);
    });

	});

	$('.container').on('click', '.answer .vote a', function(event) {
		event.preventDefault();
    var voteButton = $(this);

    var request = $.ajax({
			url: $(this).attr('href'),
      method: "post",
      dataType: "JSON"
    });

    request.done(function(response) {
			$(voteButton).parent().children('span').text(response['score']);
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

	$('.container').on('submit', '.answer_form', function(event) {
		event.preventDefault();
		var answerForm = $(this);
		var submitPath = $(this).attr('action');
		var answerData = $(this).serialize();
		var answerSubmit = $.ajax({
			url: submitPath,
			type: 'POST',
			data: answerData
		});
		answerSubmit.done(function(response) {
			$('.container').append(response);
			$('.answerCommentForm').hide();
			var answersCount = parseInt($('.answers-count').text())
			answersCount++;
			$('.answers-count').text(answersCount+' answers');
			answerForm.trigger('reset');
		});
	});
});

