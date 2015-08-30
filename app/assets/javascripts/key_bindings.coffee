$ ->

  gameClock = []
  nextMoveTimer = []
  gettingPiece = []

  move = (playerIndex, direction) ->
    i = j = 0
    switch direction
      when 'u' then i = +1
      when 'd' then i = -1
      when 'l' then j = +1
      when 'r' then j = -1

    for block in currentPiece[playerIndex]
      playerGrid[playerIndex].rows[block[0]].cells[block[1]].style.backgroundColor = ''

    didMove = true
    for block in currentPiece[playerIndex]
      tmpBlock = [ block[0] - i, block[1] - j ]
      unless isValidMove(playerGrid[playerIndex], tmpBlock, boundaries[playerIndex])
        didMove = false
        break

    if didMove
      for block in currentPiece[playerIndex]
        block[0] -= i
        block[1] -= j

    for block in currentPiece[playerIndex]
      playerGrid[playerIndex].rows[block[0]].cells[block[1]].style.backgroundColor = currentColor[playerIndex]

    return didMove

  isValidMove = (grid, block, boundaries) ->
    return false if blockOutOfBounds(block, boundaries)
    backgroundColor = grid.rows[block[0]].cells[block[1]].style.backgroundColor
    return false unless backgroundColor == ''
    return true

  blockOutOfBounds = (block, boundaries) ->
    return true if block[0] < boundaries[0]
    return true if block[0] > boundaries[2]
    return true if block[1] < boundaries[1]
    return true if block[1] > boundaries[3]
    return false

  restartGameClock = (playerIndex) ->
    clearInterval(gameClock[playerIndex]);
    _this = this
    gameClock[playerIndex] = setInterval(((playerIndex)->
      didMove = move(playerIndex,'d')
      return if didMove or nextMoveTimer[playerIndex]?
      nextMoveTimer[playerIndex] = setInterval(((playerIndex)->
        triggerNextPiece(playerIndex)
      ), 300, playerIndex)
    ), 300, playerIndex)

  stopMoveTimer = (playerIndex) ->
    clearInterval(nextMoveTimer[playerIndex]);
    nextMoveTimer[playerIndex] = null

  triggerNextPiece = (playerIndex) ->
    return if gettingPiece[playerIndex]
    gettingPiece[playerIndex] = true
    url = '/games/' + gameId + '/next_piece.js?player_index=' + playerIndex
    $.ajax
      type: 'GET'
      url: url
      success: () ->
        stopMoveTimer(playerIndex)
        gettingPiece[playerIndex] = false

  $('#js-game-box').on 'gameStart', (src, gameId) ->

    playerCount = playerGrid.length
    for playerIndex in [0..playerCount-1]
      restartGameClock(playerIndex)

    $(document).keydown (e) ->
      e.preventDefault()
      switch e.which
        when 37
          move(0,'l')
        when 38
          move(0,'u')
          # up
        when 39
          move(0,'r')
        when 40
          move(0,'d')
        else
          return
      stopMoveTimer(0)
