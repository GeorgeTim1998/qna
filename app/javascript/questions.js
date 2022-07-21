$(document).on('turbolinks:load', function(){
  $('.question-title-body').on('click', '.edit-question-link', function(e) {
      e.preventDefault();
      $(this).hide();
      var questionId = $(this).data('questionId');
      console.log(questionId);
      $('form#edit-question-' + questionId).removeClass('hidden');
  })
});