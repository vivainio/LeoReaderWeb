// Generated by CoffeeScript 1.3.3
(function() {
  var LeoAccess, root;

  root = window;

  LeoAccess = (function() {

    function LeoAccess() {
      var _this = this;
      this.nodes = {};
      this.parentgnx = "";
      this.pstack = [];
      $("#btnback").click(function() {
        console.log("Click back");
        return _this.goBack();
      });
    }

    LeoAccess.prototype.isTop = function() {
      return this.pstack.length === 0;
    };

    LeoAccess.prototype.goTop = function() {
      this.pstack = [];
      this.parentgnx = "";
      this.showSubtree("");
      $("#btnback").hide();
      return this.updateCrumb();
    };

    LeoAccess.prototype.drillTo = function(gnx) {
      if (this.isTop()) {
        $("#btnback").show();
      }
      this.pstack.push(this.parentgnx);
      this.parentgnx = gnx;
      this.showSubtree(gnx);
      return this.updateCrumb();
    };

    LeoAccess.prototype.updateCrumb = function() {
      var cs, gnx, hs;
      hs = (function() {
        var _i, _len, _ref, _results;
        _ref = this.pstack.slice(1).concat([this.parentgnx]);
        _results = [];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          gnx = _ref[_i];
          _results.push(this.nodes[gnx].h.slice(0, 40));
        }
        return _results;
      }).call(this);
      hs.reverse();
      cs = hs.join(" < ");
      $("#lfooter").text(cs);
      return hs;
    };

    LeoAccess.prototype.goBack = function() {
      var newp;
      if (this.pstack.length === 1) {
        this.goTop();
        return;
      }
      newp = this.pstack.pop();
      this.parentgnx = newp;
      this.showSubtree(newp);
      return this.updateCrumb();
    };

    LeoAccess.prototype.opendoc = function(url) {
      var _this = this;
      return $.getJSON(url, function(data) {
        var n, _i, _len, _ref;
        console.log("got json! ");
        _ref = data.nodes;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          n = _ref[_i];
          _this.nodes[n.gnx] = {
            b: n.b,
            h: n.h,
            children: n.children
          };
          console.log("Got h " + _this.nodes[n.gnx].h);
        }
        _this.nodes[""] = {
          b: "hidden root",
          h: "hidden root",
          children: data.top
        };
        return _this.goTop("");
      });
    };

    LeoAccess.prototype.showSubtree = function(parentGnx) {
      var $a, $b, $n, $r, chignx, chin, n, that, _i, _len, _ref;
      n = this.nodes[parentGnx];
      $r = $("#lchildren");
      that = this;
      $r.empty();
      $b = $("#bodytext");
      $b.text(n.b);
      $("#hstring").text(n.h);
      console.log("Show subtree for " + parentGnx);
      _ref = n.children;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        chignx = _ref[_i];
        chin = this.nodes[chignx];
        console.log("h = " + chin.h);
        $n = $('<li><a href="#">' + chin.h + '</a></li>');
        $a = $n.find("a");
        $a.data("gnx", chignx);
        $a.click(function() {
          var gnx;
          gnx = $(this).data("gnx");
          return that.drillTo(gnx);
        });
        $r.append($n);
      }
      return $r.listview('refresh');
    };

    return LeoAccess;

  })();

  console.log("Parsing");

  $(document).ready(function() {
    console.log("Start dl");
    root.la = new LeoAccess();
    return root.la.opendoc("test_doc.leo.json");
  });

}).call(this);
