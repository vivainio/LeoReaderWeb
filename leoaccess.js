// Generated by CoffeeScript 1.3.3
(function() {
  var opendoc, root;

  root = typeof global !== "undefined" && global !== null ? global : window;

  opendoc = function(url) {
    var doc;
    return doc = $.ajax(url).done(function(data) {
      var t;
      t = $(this);
      return console.log("Ajax ok " + data);
    });
  };

}).call(this);