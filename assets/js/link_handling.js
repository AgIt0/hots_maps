$('.map-link').click(function() {
  $('.map').hide();
  const mapName = $(this).data('map');
  const element = $(`div*[data-map="${mapName}"]`);
  element.show();
  return false;
})
