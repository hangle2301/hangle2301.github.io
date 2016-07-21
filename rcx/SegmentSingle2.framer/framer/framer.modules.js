require=(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);var f=new Error("Cannot find module '"+o+"'");throw f.code="MODULE_NOT_FOUND",f}var l=n[o]={exports:{}};t[o][0].call(l.exports,function(e){var n=t[o][1][e];return s(n?n:e)},l,l.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({"SVGLayer":[function(require,module,exports){
"SVGLayer class\n\nproperties\n- linecap <string> (\"round\" || \"square\" || \"butt\")\n- fill <string> (css color)\n- stroke <string> (css color)\n- strokeWidth <number>\n- dashOffset <number> (from -1 to 1, defaults to 0)";
var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
  hasProp = {}.hasOwnProperty;

exports.SVGLayer = (function(superClass) {
  extend(SVGLayer, superClass);

  function SVGLayer(options) {
    var cName, d, footer, header, path, t;
    if (options == null) {
      options = {};
    }
    options = _.defaults(options, {
      dashOffset: 1,
      strokeWidth: 2,
      stroke: "#28affa",
      backgroundColor: null,
      clip: false,
      fill: "transparent",
      linecap: "round"
    });
    SVGLayer.__super__.constructor.call(this, options);
    if (options.fill === null) {
      this.fill = null;
    }
    this.width += options.strokeWidth / 2;
    this.height += options.strokeWidth / 2;
    d = new Date();
    t = d.getTime();
    cName = "c" + t;
    header = "<svg class='" + cName + "' x='0px' y='0px' width='" + this.width + "' height='" + this.height + "' viewBox='-" + (this.strokeWidth / 2) + " -" + (this.strokeWidth / 2) + " " + (this.width + this.strokeWidth / 2) + " " + (this.height + this.strokeWidth / 2) + "'>";
    path = options.path;
    footer = "</svg>";
    this.html = header + path + footer;
    Utils.domComplete((function(_this) {
      return function() {
        var domPath;
        domPath = document.querySelector('.' + cName + ' path');
        _this._pathLength = domPath.getTotalLength();
        _this.style = {
          "stroke-dasharray": _this.pathLength
        };
        return _this.dashOffset = options.dashOffset;
      };
    })(this));
  }

  SVGLayer.define("pathLength", {
    get: function() {
      return this._pathLength;
    },
    set: function(value) {
      return print("SVGLayer.pathLength is readonly");
    }
  });

  SVGLayer.define("linecap", {
    get: function() {
      return this.style.strokeLinecap;
    },
    set: function(value) {
      return this.style.strokeLinecap = value;
    }
  });

  SVGLayer.define("strokeLinecap", {
    get: function() {
      return this.style.strokeLinecap;
    },
    set: function(value) {
      return this.style.strokeLinecap = value;
    }
  });

  SVGLayer.define("fill", {
    get: function() {
      return this.style.fill;
    },
    set: function(value) {
      if (value === null) {
        value = "transparent";
      }
      return this.style.fill = value;
    }
  });

  SVGLayer.define("stroke", {
    get: function() {
      return this.style.stroke;
    },
    set: function(value) {
      return this.style.stroke = value;
    }
  });

  SVGLayer.define("strokeColor", {
    get: function() {
      return this.style.stroke;
    },
    set: function(value) {
      return this.style.stroke = value;
    }
  });

  SVGLayer.define("strokeWidth", {
    get: function() {
      return Number(this.style.strokeWidth.replace(/[^\d.-]/g, ''));
    },
    set: function(value) {
      return this.style.strokeWidth = value;
    }
  });

  SVGLayer.define("dashOffset", {
    get: function() {
      return this._dashOffset;
    },
    set: function(value) {
      var dashOffset;
      this._dashOffset = value;
      if (this.pathLength != null) {
        dashOffset = Utils.modulate(value, [0, 1], [this.pathLength, 0]);
        return this.style.strokeDashoffset = dashOffset;
      }
    }
  });

  return SVGLayer;

})(Layer);


},{}],"myModule":[function(require,module,exports){
exports.myVar = "myVariable";

exports.myFunction = function() {
  return print("myFunction is running");
};

exports.myArray = [1, 2, 3];


},{}]},{},[])
//# sourceMappingURL=data:application/json;charset:utf-8;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbIm5vZGVfbW9kdWxlcy9icm93c2VyLXBhY2svX3ByZWx1ZGUuanMiLCIvVXNlcnMvaGFuZ2xlL0RvY3VtZW50cy9naXQvaGFuZ2xlMjMwMS5naXRodWIuaW8vcmN4L1NlZ21lbnRTaW5nbGUyLmZyYW1lci9tb2R1bGVzL1NWR0xheWVyLmNvZmZlZSIsIi9Vc2Vycy9oYW5nbGUvRG9jdW1lbnRzL2dpdC9oYW5nbGUyMzAxLmdpdGh1Yi5pby9yY3gvU2VnbWVudFNpbmdsZTIuZnJhbWVyL21vZHVsZXMvbXlNb2R1bGUuY29mZmVlIl0sIm5hbWVzIjpbXSwibWFwcGluZ3MiOiJBQUFBO0FDQUE7QUFBQSxJQUFBOzs7QUFXTSxPQUFPLENBQUM7OztFQUVBLGtCQUFDLE9BQUQ7QUFDWixRQUFBOztNQURhLFVBQVU7O0lBQ3ZCLE9BQUEsR0FBVSxDQUFDLENBQUMsUUFBRixDQUFXLE9BQVgsRUFDVDtNQUFBLFVBQUEsRUFBWSxDQUFaO01BQ0EsV0FBQSxFQUFhLENBRGI7TUFFQSxNQUFBLEVBQVEsU0FGUjtNQUdBLGVBQUEsRUFBaUIsSUFIakI7TUFJQSxJQUFBLEVBQU0sS0FKTjtNQUtBLElBQUEsRUFBTSxhQUxOO01BTUEsT0FBQSxFQUFTLE9BTlQ7S0FEUztJQVFWLDBDQUFNLE9BQU47SUFFQSxJQUFHLE9BQU8sQ0FBQyxJQUFSLEtBQWdCLElBQW5CO01BQ0MsSUFBQyxDQUFBLElBQUQsR0FBUSxLQURUOztJQUdBLElBQUMsQ0FBQSxLQUFELElBQVUsT0FBTyxDQUFDLFdBQVIsR0FBc0I7SUFDaEMsSUFBQyxDQUFBLE1BQUQsSUFBVyxPQUFPLENBQUMsV0FBUixHQUFzQjtJQUdqQyxDQUFBLEdBQVEsSUFBQSxJQUFBLENBQUE7SUFDUixDQUFBLEdBQUksQ0FBQyxDQUFDLE9BQUYsQ0FBQTtJQUNKLEtBQUEsR0FBUSxHQUFBLEdBQU07SUFDZCxNQUFBLEdBQVMsY0FBQSxHQUFlLEtBQWYsR0FBcUIsMkJBQXJCLEdBQWdELElBQUMsQ0FBQSxLQUFqRCxHQUF1RCxZ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QyxXQUFXLENBQUMsT0FBbkIsQ0FBMkIsVUFBM0IsRUFBdUMsRUFBdkMsQ0FBUDtJQUFILENBQUw7SUFDQSxHQUFBLEVBQUssU0FBQyxLQUFEO2FBQ0osSUFBQyxDQUFBLEtBQUssQ0FBQyxXQUFQLEdBQXFCO0lBRGpCLENBREw7R0FERDs7RUFLQSxRQUFDLENBQUEsTUFBRCxDQUFRLFlBQVIsRUFDQztJQUFBLEdBQUEsRUFBSyxTQUFBO2FBQUcsSUFBQyxDQUFBO0lBQUosQ0FBTDtJQUNBLEdBQUEsRUFBSyxTQUFDLEtBQUQ7QUFDSixVQUFBO01BQUEsSUFBQyxDQUFBLFdBQUQsR0FBZTtNQUNmLElBQUcsdUJBQUg7UUFDQyxVQUFBLEdBQWEsS0FBSyxDQUFDLFFBQU4sQ0FBZSxLQUFmLEVBQXNCLENBQUMsQ0FBRCxFQUFJLENBQUosQ0FBdEIsRUFBOEIsQ0FBQyxJQUFDLENBQUEsVUFBRixFQUFjLENBQWQsQ0FBOUI7ZUFDYixJQUFDLENBQUEsS0FBSyxDQUFDLGdCQUFQLEdBQTBCLFdBRjNCOztJQUZJLENBREw7R0FERDs7OztHQXJFOEI7Ozs7QUNQL0IsT0FBTyxDQUFDLEtBQVIsR0FBZ0I7O0FBRWhCLE9BQU8sQ0FBQyxVQUFSLEdBQXFCLFNBQUE7U0FDcEIsS0FBQSxDQUFNLHVCQUFOO0FBRG9COztBQUdyQixPQUFPLENBQUMsT0FBUixHQUFrQixDQUFDLENBQUQsRUFBSSxDQUFKLEVBQU8sQ0FBUCIsImZpbGUiOiJnZW5lcmF0ZWQuanMiLCJzb3VyY2VSb290IjoiIiwic291cmNlc0NvbnRlbnQiOlsiKGZ1bmN0aW9uIGUodCxuLHIpe2Z1bmN0aW9uIHMobyx1KXtpZighbltvXSl7aWYoIXRbb10pe3ZhciBhPXR5cGVvZiByZXF1aXJlPT1cImZ1bmN0aW9uXCImJnJlcXVpcmU7aWYoIXUmJmEpcmV0dXJuIGEobywhMCk7aWYoaSlyZXR1cm4gaShvLCEwKTt2YXIgZj1uZXcgRXJyb3IoXCJDYW5ub3QgZmluZCBtb2R1bGUgJ1wiK28rXCInXCIpO3Rocm93IGYuY29kZT1cIk1PRFVMRV9OT1RfRk9VTkRcIixmfXZhciBsPW5bb109e2V4cG9ydHM6e319O3Rbb11bMF0uY2FsbChsLmV4cG9ydHMsZnVuY3Rpb24oZSl7dmFyIG49dFtvXVsxXVtlXTtyZXR1cm4gcyhuP246ZSl9LGwsbC5leHBvcnRzLGUsdCxuLHIpfXJldHVybiBuW29dLmV4cG9ydHN9dmFyIGk9dHlwZW9mIHJlcXVpcmU9PVwiZnVuY3Rpb25cIiYmcmVxdWlyZTtmb3IodmFyIG89MDtvPHIubGVuZ3RoO28rKylzKHJbb10pO3JldHVybiBzfSkiLCJcIlwiXCJcblNWR0xheWVyIGNsYXNzXG5cbnByb3BlcnRpZXNcbi0gbGluZWNhcCA8c3RyaW5nPiAoXCJyb3VuZFwiIHx8IFwic3F1YXJlXCIgfHwgXCJidXR0XCIpXG4tIGZpbGwgPHN0cmluZz4gKGNzcyBjb2xvcilcbi0gc3Ryb2tlIDxzdHJpbmc+IChjc3MgY29sb3IpXG4tIHN0cm9rZVdpZHRoIDxudW1iZXI+XG4tIGRhc2hPZmZzZXQgPG51bWJlcj4gKGZyb20gLTEgdG8gMSwgZGVmYXVsdHMgdG8gMClcblwiXCJcIlxuXG5jbGFzcyBleHBvcnRzLlNWR0xheWVyIGV4dGVuZHMgTGF5ZXJcblxuXHRjb25zdHJ1Y3RvcjogKG9wdGlvbnMgPSB7fSkgLT5cblx0XHRvcHRpb25zID0gXy5kZWZhdWx0cyBvcHRpb25zLFxuXHRcdFx0ZGFzaE9mZnNldDogMVxuXHRcdFx0c3Ryb2tlV2lkdGg6IDJcblx0XHRcdHN0cm9rZTogXCIjMjhhZmZhXCJcblx0XHRcdGJhY2tncm91bmRDb2xvcjogbnVsbFxuXHRcdFx0Y2xpcDogZmFsc2Vcblx0XHRcdGZpbGw6IFwidHJhbnNwYXJlbnRcIlxuXHRcdFx0bGluZWNhcDogXCJyb3VuZFwiXG5cdFx0c3VwZXIgb3B0aW9uc1xuXG5cdFx0aWYgb3B0aW9ucy5maWxsID09IG51bGxcblx0XHRcdEBmaWxsID0gbnVsbFxuXG5cdFx0QHdpZHRoICs9IG9wdGlvbnMuc3Ryb2tlV2lkdGggLyAyXG5cdFx0QGhlaWdodCArPSBvcHRpb25zLnN0cm9rZVdpZHRoIC8gMlxuXG5cdFx0IyBIVE1MIGZvciB0aGUgU1ZHIERPTSBlbGVtZW50LCBuZWVkIHVuaXF1ZSBjbGFzcyBuYW1lc1xuXHRcdGQgPSBuZXcgRGF0ZSgpXG5cdFx0dCA9IGQuZ2V0VGltZSgpXG5cdFx0Y05hbWUgPSBcImNcIiArIHRcblx0XHRoZWFkZXIgPSBcIjxzdmcgY2xhc3M9JyN7Y05hbWV9JyB4PScwcHgnIHk9JzBweCcgd2lkdGg9JyN7QHdpZHRofScgaGVpZ2h0PScje0BoZWlnaHR9JyB2aWV3Qm94PSctI3tAc3Ryb2tlV2lkdGgvMn0gLSN7QHN0cm9rZVdpZHRoLzJ9ICN7QHdpZHRoICsgQHN0cm9rZVdpZHRoLzJ9ICN7QGhlaWdodCArIEBzdHJva2VXaWR0aC8yfSc+XCJcblx0XHRwYXRoID0gb3B0aW9ucy5wYXRoXG5cdFx0Zm9vdGVyID0gXCI8L3N2Zz5cIlxuXHRcdEBodG1sID0gaGVhZGVyICsgcGF0aCArIGZvb3RlclxuXG5cdFx0IyB3YWl0IHdpdGggcXVlcnlpbmcgcGF0aGxlbmd0aCBmb3Igd2hlbiBkb20gaXMgZmluaXNoZWRcblx0XHRVdGlscy5kb21Db21wbGV0ZSA9PlxuXHRcdFx0ZG9tUGF0aCA9IGRvY3VtZW50LnF1ZXJ5U2VsZWN0b3IoJy4nK2NOYW1lKycgcGF0aCcpXG5cdFx0XHRAX3BhdGhMZW5ndGggPSBkb21QYXRoLmdldFRvdGFsTGVuZ3RoKClcblx0XHRcdEBzdHlsZSA9IHtcInN0cm9rZS1kYXNoYXJyYXlcIjpAcGF0aExlbmd0aDt9XG5cdFx0XHRAZGFzaE9mZnNldCA9IG9wdGlvbnMuZGFzaE9mZnNldFxuXG5cdEBkZWZpbmUgXCJwYXRoTGVuZ3RoXCIsXG5cdFx0Z2V0OiAtPiBAX3BhdGhMZW5ndGhcblx0XHRzZXQ6ICh2YWx1ZSkgLT4gcHJpbnQgXCJTVkdMYXllci5wYXRoTGVuZ3RoIGlzIHJlYWRvbmx5XCJcblxuXHRAZGVmaW5lIFwibGluZWNhcFwiLFxuXHRcdGdldDogLT4gQHN0eWxlLnN0cm9rZUxpbmVjYXBcblx0XHRzZXQ6ICh2YWx1ZSkgLT5cblx0XHRcdEBzdHlsZS5zdHJva2VMaW5lY2FwID0gdmFsdWVcblxuXHRAZGVmaW5lIFwic3Ryb2tlTGluZWNhcFwiLFxuXHRcdGdldDogLT4gQHN0eWxlLnN0cm9rZUxpbmVjYXBcblx0XHRzZXQ6ICh2YWx1ZSkgLT5cblx0XHRcdEBzdHlsZS5zdHJva2VMaW5lY2FwID0gdmFsdWVcblxuXHRAZGVmaW5lIFwiZmlsbFwiLFxuXHRcdGdldDogLT4gQHN0eWxlLmZpbGxcblx0XHRzZXQ6ICh2YWx1ZSkgLT5cblx0XHRcdGlmIHZhbHVlID09IG51bGxcblx0XHRcdFx0dmFsdWUgPSBcInRyYW5zcGFyZW50XCJcblx0XHRcdEBzdHlsZS5maWxsID0gdmFsdWVcblxuXHRAZGVmaW5lIFwic3Ryb2tlXCIsXG5cdFx0Z2V0OiAtPiBAc3R5bGUuc3Ryb2tlXG5cdFx0c2V0OiAodmFsdWUpIC0+IEBzdHlsZS5zdHJva2UgPSB2YWx1ZVxuXG5cdEBkZWZpbmUgXCJzdHJva2VDb2xvclwiLFxuXHRcdGdldDogLT4gQHN0eWxlLnN0cm9rZVxuXHRcdHNldDogKHZhbHVlKSAtPiBAc3R5bGUuc3Ryb2tlID0gdmFsdWVcblxuXHRAZGVmaW5lIFwic3Ryb2tlV2lkdGhcIixcblx0XHRnZXQ6IC0+IE51bWJlcihAc3R5bGUuc3Ryb2tlV2lkdGgucmVwbGFjZSgvW15cXGQuLV0vZywgJycpKVxuXHRcdHNldDogKHZhbHVlKSAtPlxuXHRcdFx0QHN0eWxlLnN0cm9rZVdpZHRoID0gdmFsdWVcblxuXHRAZGVmaW5lIFwiZGFzaE9mZnNldFwiLFxuXHRcdGdldDogLT4gQF9kYXNoT2Zmc2V0XG5cdFx0c2V0OiAodmFsdWUpIC0+XG5cdFx0XHRAX2Rhc2hPZmZzZXQgPSB2YWx1ZVxuXHRcdFx0aWYgQHBhdGhMZW5ndGg/XG5cdFx0XHRcdGRhc2hPZmZzZXQgPSBVdGlscy5tb2R1bGF0ZSh2YWx1ZSwgWzAsIDFdLCBbQHBhdGhMZW5ndGgsIDBdKVxuXHRcdFx0XHRAc3R5bGUuc3Ryb2tlRGFzaG9mZnNldCA9IGRhc2hPZmZzZXRcbiIsIiMgQWRkIHRoZSBmb2xsb3dpbmcgbGluZSB0byB5b3VyIHByb2plY3QgaW4gRnJhbWVyIFN0dWRpby4gXG4jIG15TW9kdWxlID0gcmVxdWlyZSBcIm15TW9kdWxlXCJcbiMgUmVmZXJlbmNlIHRoZSBjb250ZW50cyBieSBuYW1lLCBsaWtlIG15TW9kdWxlLm15RnVuY3Rpb24oKSBvciBteU1vZHVsZS5teVZhclxuXG5leHBvcnRzLm15VmFyID0gXCJteVZhcmlhYmxlXCJcblxuZXhwb3J0cy5teUZ1bmN0aW9uID0gLT5cblx0cHJpbnQgXCJteUZ1bmN0aW9uIGlzIHJ1bm5pbmdcIlxuXG5leHBvcnRzLm15QXJyYXkgPSBbMSwgMiwgM10iXX0=
