#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @.playerCheck21()
    @.listeners()
  


  
  # check if player has a 21 score. if player is at 21, check if dealer. if both, then tie. if dealer not, then player wins
  dealerDraw: -> 
    console.log(@get 'deck')
    dealer = @get 'dealerHand'
    dealerScore = parseInt(dealer.scores()) + parseInt(dealer.models[0].attributes.value)
    console.log(dealer)
    console.log(dealerScore)
    if dealerScore < 17
      dealer.drawCard()
      setTimeout( () =>
        @.dealerDraw() 
      1000)  
    else
      dealer.models[0].flip()
      @.finalCheck21()


  playerCheck21: ->
    player = @get 'playerHand'
    playerScore = player.scores();
    console.log(playerScore)
    
    allLose = []
    length = playerScore.length
    for i in playerScore
      if i > 21
        allLose.push true
      else if i is 21
        @.youWin()
        return undefined
      else
        allLose.push false 
    console.log(allLose)
    allLose = _.reduce allLose, (accu, value) -> 
      accu and value

    if allLose is true 
      @.youLose()


  finalCheck21: ->
    player = @get 'playerHand'
    playerScore = player.scores();

    dealer = @get 'dealerHand'
    dealerScore = dealer.scores()
    
    dealerBust = []
    length = dealerScore.length
    
    for i in dealerScore
      if i > 21
        dealerBust.push true
      else
        dealerBust.push false 
    console.log(dealerBust)
    dealerBust = _.reduce dealerBust, (accu, value) -> 
      accu and value

    if dealerBust is true or playerScore > dealerScore
      @.youWin()
    else if playerScore is dealerScore
      @.tie()
    else 
      @.youLose()
    
  listeners: ->
    @get('playerHand').on 'playerHit', => 
      @.playerCheck21()
      undefined
    @get('playerHand').on 'dealerHit', => 
      @.dealerDraw()
      undefined
    undefined


    # turn based. player goes then dealer goes.
  # if one of dealer's scores is 17, dealer cannot hit again. if dealer score > 21, player wins
  # if player obtains 21 score, check dealer score and same as above
  # if player over 21, dealer wins.
  addToDiscard: ->
    deck = @.attributes.deck
    _.each deck.inUse,(value,key)->
      deck.discardPile[key] = true
    deck.inUse = {}
    window.localStorage.setItem('discardPile',deck.discardPile)
  # after game
  # count win, loss, push tallies.
  youLose: () ->
    setTimeout( () =>
      $('body').text('You Lose!!!!!!!').append($('<button class="playAgain">Play again</button>'));
      @.addToDiscard()
      $('.playAgain').on 'click', ->
        $('body').text('')
        new AppView(model: new App()).$el.appendTo 'body'
    1000)



  youWin: () ->
    setTimeout( () =>
      $('body').text('You Win!!!!!!!').append($('<button class="playAgain">Play again</button>'));
      @.addToDiscard()
      $('.playAgain').on 'click', ->
        $('body').text('')
        new AppView(model: new App()).$el.appendTo 'body'
    1000)

  tie: ->
    setTimeout( () =>
      $('body').html('Tie...').append($('<button class="playAgain">Play again</button>'));
      @.addToDiscard()
      $('.playAgain').on 'click', ->
        $('body').text('')
        new AppView(model: new App()).$el.appendTo 'body'
    1000)

    
  
  # push button to play new game. reinitialize app

  # later: avoid shuffle between games. if deck.models.length is 0, reshuffle deck excluding cards currently in play.