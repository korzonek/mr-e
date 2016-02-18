$(document).on('page:change', function() {
  $('#new-request').hide();
});

function addRequestClick(event) {
  event.preventDefault();
  $('#new-request').show();
  $('#add-request-btn').hide();
}

function cancelRequestClick(event) {
  event.preventDefault();
  $('#request_content').val('');
  $('#new-request').hide();
  $('#add-request-btn').show();
}
