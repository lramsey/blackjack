// Generated by CoffeeScript 1.6.3
(function() {
  var _ref,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  window.Deck = (function(_super) {
    __extends(Deck, _super);

    function Deck() {
      _ref = Deck.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    Deck.prototype.model = Card;

    Deck.prototype.initialize = function() {
      var priorCards;
      this.add(_(_.range(0, 52)).shuffle().map(function(card) {
        return new Card({
          rank: card % 13,
          suit: Math.floor(card / 13)
        });
      }));
      this.inUse = {};
      console.log(this.discardPile);
      priorCards = window.localStorage.getItem('discardPile');
      this.discardPile = JSON.parse(priorCards) || {};
      return console.log(this);
    };

    Deck.prototype.dealPlayer = function() {
      var hand;
      return hand = new Hand([], this);
    };

    Deck.prototype.dealDealer = function() {
      return new Hand([], this, true);
    };

    return Deck;

  })(Backbone.Collection);

}).call(this);

/*
//@ sourceMappingURL=Deck.map
*/
