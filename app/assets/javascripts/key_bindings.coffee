$ ->

  gameStarted = false

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
      for permutationNumber in [0..3]
        for blockNumber in [0..3]
          piecePermutations[playerIndex][permutationNumber][blockNumber][0] -= i
          piecePermutations[playerIndex][permutationNumber][blockNumber][1] -= j

    for block in currentPiece[playerIndex]
      playerGrid[playerIndex].rows[block[0]].cells[block[1]].style.backgroundColor = currentColor[playerIndex]

    return didMove

  rotate = (playerIndex, direction) ->
    debugger if piecePermutations[0] == piecePermutations[1]

    next_index = permutationIndex[playerIndex] + direction
    next_index = 0 if next_index > 3
    next_index = 3 if next_index < 0

    for block in currentPiece[playerIndex]
      playerGrid[playerIndex].rows[block[0]].cells[block[1]].style.backgroundColor = ''

    didMove = true
    for block in piecePermutations[playerIndex][next_index]
      tmpBlock = [ block[0], block[1] ]
      unless isValidMove(playerGrid[playerIndex], tmpBlock, boundaries[playerIndex])
        didMove = false
        break

    if didMove
      permutationIndex[playerIndex] = next_index
      currentPiece[playerIndex] = piecePermutations[playerIndex][next_index]

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
    clearInterval(gameClock[playerIndex])
    _this = this
    gameClock[playerIndex] = setInterval(((playerIndex)->
      didMove = move(playerIndex,'d')
      return if didMove or nextMoveTimer[playerIndex]?
      nextMoveTimer[playerIndex] = setInterval(((playerIndex)->
        triggerNextPiece(playerIndex)
      ), 1000, playerIndex)
    ), 1000, playerIndex)

  stopMoveTimer = (playerIndex) ->
    clearInterval(nextMoveTimer[playerIndex]);
    nextMoveTimer[playerIndex] = null

  triggerNextPiece = (playerIndex) ->
    return if gettingPiece[playerIndex]
    gettingPiece[playerIndex] = true
    stopMoveTimer(playerIndex)
    url = '/games/' + gameId + '/next_piece.js?player_index=' + playerIndex
    $.ajax
      type: 'GET'
      url: url
      success: () ->
        setTimeout (->
          gettingPiece[playerIndex] = false
        ), 1000, playerIndex

  $('#js-game-box').on 'gameUpdated', (src, gameId) ->

    return if gameStarted
    gameStarted = true

    playerCount = playerGrid.length
    for playerIndex in [0..playerCount-1]
      restartGameClock(playerIndex)

    $(document).keydown (e) ->
      e.preventDefault()
      return if gettingPiece[0]

      switch e.which
        when 40
          move(0,'d')
          return
        when 37
          didMove = move(0,'l')
        when 39
          didMove = move(0,'r')
        when 38
          morePieces = true
          while morePieces
            morePieces = move(0,'d')
          stopMoveTimer(0)
          triggerNextPiece()
          gettingPiece[playerIndex] = true
          return
        when 81
          # rotate counter-clockwise
          didMove = rotate(0, -1)
        when 69
          # rotate clockwise
          didMove = rotate(0, +1)
        else
          debugger
          return

      stopMoveTimer(0) if didMove
