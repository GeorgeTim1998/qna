$(document).on('turbolinks:load', function(){
  $('.answers').on('click', '.edit-answer-link', function(e) {
      e.preventDefault();
      $(this).hide();
      var answerId = $(this).data('answerId');
      console.log(answerId);
      $('form#edit-answer-' + answerId).removeClass('hidden');
  }),
  $('.answer-comments').on('click', ".create-link-comment", function(e) {
    e.preventDefault();
    $(this).hide();
    var id = $(this).data('id');
    $('form#create-' + id).removeClass('hidden');
})
});