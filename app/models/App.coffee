#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @.playerCheck21()
    @.listeners()
  
  # check if player has a 21 score. if player is at 21, check if dealer. if both, then tie. if dealer not, then player wins
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
        @.youWin(playerScore)
      else
        allLose.push false 
    console.log(allLose)
    allLose = _.reduce allLose, (accu, value) -> 
      accu and value

    if allLose is true then @.youLose(playerScore)

    




    #else if playerScore[0] > 21 and playerScore[1] > 21
     # @.youLose(playerScore)
    #else if playerScore.length is 1 and 
      
    #else if playerScore[0] is 21 or playerScore[1] is 21
     # @.youWin(playerScore)


  #dealerCheck21: ->
   # dealerScore = @get 'dealerHand'.scores() + 
    #if dealerScore.length is 1 and dealerScore[0] >= 21 
     # @.youLose(dealerScore)
    #else if dealerScore[0] >= 21 or dealerScore[1] >= 21
     # @.youLose(dealerScore)
    
  listeners: ->
    @get('playerHand').on 'playerHit', => 
      @.playerCheck21()
      undefined
    undefined


    # turn based. player goes then dealer goes.
  # if one of dealer's scores is 17, dealer cannot hit again. if dealer score > 21, player wins
  # if player obtains 21 score, check dealer score and same as above
  # if player over 21, dealer wins.

  # after game
  # count win, loss, push tallies.
  youLose: (score) ->
    $('body').text('You Lose!!!!!!!').append($('<button class="playAgain">Play again</button>'));
    $('.playAgain').on 'click', ->
      $('body').text('')
      new AppView(model: new App()).$el.appendTo 'body'



  youWin: (score) ->
    $('body').text('You Win!!!!!!!').append($('<button class="playAgain">Play again</button>'));
    $('.playAgain').on 'click', ->
      $('body').text('')
      new AppView(model: new App()).$el.appendTo 'body'
    
  
  # push button to play new game. reinitialize app

  # later: avoid shuffle between games. if deck.models.length is 0, reshuffle deck excluding cards currently in play.