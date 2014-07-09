$(function () {
  var settings =  {
    placeholder: 'Search for an organization',
    minimumInputLength: 3,
    width: '100%',
    ajax: {
      url: function () {
        return $(this).data('url');
      },
      dataType: 'json',
      quietMillis: 200,
      data: function (term, page) {
        return { q: term };
      },
      results: function (data, page) {
        return {results: data};
      }
    },
    formatSelection: function(obj, container) {
      return obj.name;
    },
    formatResult: function(obj, container, query) {
      return obj.name + ', signed on ' + obj.signed_at;
    }
  }

  $('.transfer-ccla-organization').select2(settings);
});
