$(document).on('turbolinks:load', function(){
  $('.question-title-body').on('click', '.edit-question-link', function(e) {
      e.preventDefault();
      $(this).hide();
      var questionId = $(this).data('questionId');
      console.log(questionId);
      $('form#edit-question-' + questionId).removeClass('hidden');
  }),
  $('.question-comments').on('click', ".create-link-comment", function(e) {
    e.preventDefault();
    $(this).hide();
    var id = $(this).data('id');
    $('form#create-' + id).removeClass('hidden');
}),
  $(document).on('ajax:error', (event) => {
    $(event.target.parentElement).find('.errors').html(event.detail[0])
  })
});