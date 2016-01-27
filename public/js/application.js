$(document).ready(function() {
  // This is called after the document has loaded in its entirety
  // This guarantees that any elements we bind to will exist on the page
  // when we try to bind to them

  // See: http://docs.jquery.com/Tutorials:Introducing_$(document).ready()
    $('form').on('submit', function( event ){
    event.preventDefault();
    var commentContent = $(this).serialize();

    var createRequest = $.ajax({
      url: 'comments/',
      type: 'POST',
      data: commentContent
    })
    createRequest.done(function(response){
      $('').append(response);
    })
});
