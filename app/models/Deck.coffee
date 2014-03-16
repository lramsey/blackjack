class window.Deck extends Backbone.Collection

  model: Card

  initialize: ->
    @add _(_.range(0, 52)).shuffle().map (card) ->
      new Card
        rank: card % 13
        suit: Math.floor(card / 13)
    @inUse = {}
    console.log @discardPile
    priorCards = window.localStorage.getItem('discardPile')
    @discardPile = JSON.parse(priorCards) or {}
    console.log(@)
    #@checkDeck()
   # @.discardPile = usedCards #discard object constant lookup time. linear total time. go through deck, and check if cards discarded. if so splice

    
    # prior round hands , object with player's hands and dealer hands at game index. form on side to access each game result

    # win loss tie tally maybe, i dunno  
 # checkDeck: ->
  #  _.each(@, (thisCard, index)->
   #   console.log(@)
    #  if @discardPile[thisCard.rank + thisCard.suit*13]
     #   console.log(@)
      #  @.splice index,1

  dealPlayer: ->
    hand = new Hand [], @

  dealDealer: -> 
    new Hand [], @, true