$(function() {
  $('#new_request').hide();
  addRequestClick();
});

function addRequestClick() {
  $('#add-request-btn').on('click', function() {
    $('#new_request').show();
  });
}
