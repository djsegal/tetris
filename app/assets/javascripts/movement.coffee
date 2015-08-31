$ ->

  gameStarted = false

  gameClock = []
  nextMoveTimer = []
  gettingPiece = []
  ableToHold = []
  ghostPiece = []
  lineCount = []

  move = (playerIndex, direction) ->
    i = j = 0
    switch direction
      when 'u' then i = +1
      when 'd' then i = -1
      when 'l' then j = +1
      when 'r' then j = -1

    removePiece(currentPiece, playerIndex)

    didMove = isValidMove(playerIndex, i, j, currentPiece[playerIndex])

    if didMove
      for permutationNumber in [0..3]
        for blockNumber in [0..3]
          piecePermutations[playerIndex][permutationNumber][blockNumber][0] -= i
          piecePermutations[playerIndex][permutationNumber][blockNumber][1] -= j

    insertPiece(currentPiece, playerIndex)

    return didMove

  rotate = (playerIndex, direction) ->
    debugger if piecePermutations[0] == piecePermutations[1]

    next_index = permutationIndex[playerIndex] + direction
    next_index = 0 if next_index > 3
    next_index = 3 if next_index < 0

    removePiece(currentPiece, playerIndex)

    didMove = isValidMove(playerIndex, 0, 0, piecePermutations[playerIndex][next_index])

    if didMove
      permutationIndex[playerIndex] = next_index
      currentPiece[playerIndex] = piecePermutations[playerIndex][next_index]

    insertPiece(currentPiece, playerIndex)

    return didMove

  ghost = (playerIndex) ->
    if ghostPiece[playerIndex]?
      for block in ghostPiece[playerIndex]
        playerGrid[playerIndex].rows[block[0]].cells[block[1]].style.border = ''

    ghostPiece[playerIndex] = []
    for block in currentPiece[playerIndex]
      ghostPiece[playerIndex].push [block[0], block[1]]

    removePiece(currentPiece, playerIndex)

    i = -1
    didMove = isValidMove(playerIndex, i, 0, ghostPiece[playerIndex])

    unless didMove
      insertPiece(currentPiece, playerIndex)
      return

    while didMove
      i -= 1
      didMove = isValidMove(playerIndex, i, 0, ghostPiece[playerIndex])
    i += 1

    for blockNumber in [0..3]
      ghostPiece[playerIndex][blockNumber][0] -= i

    for block in ghostPiece[playerIndex]
      playerGrid[playerIndex].rows[block[0]].cells[block[1]].style.border = '1px solid black'

    insertPiece(currentPiece, playerIndex)

  hold = (playerIndex) ->
    return unless ableToHold[playerIndex]
    ableToHold[playerIndex] = false
    prepareAjaxCall(playerIndex)
    removePiece(currentPiece, playerIndex)

    url = '/games/' + gameId + '/hold_piece.js?player_index=' + playerIndex
    $.ajax
      type: 'GET'
      url: url
      success: () ->
        finishAjaxCall(playerIndex)

  isValidMove = (playerIndex, i, j, piece) ->
    didMove = true
    for block in piece
      tmpBlock = [ block[0] - i, block[1] - j ]
      unless isValidBlock(playerGrid[playerIndex], tmpBlock, boundaries[playerIndex])
        didMove = false
        break
    return didMove

  isValidBlock = (grid, block, boundaries) ->
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

  removePiece = (piece, playerIndex) ->
    for block in piece[playerIndex]
      playerGrid[playerIndex].rows[block[0]].cells[block[1]].style.backgroundColor = ''

  insertPiece = (piece, playerIndex) ->
    for block in piece[playerIndex]
      playerGrid[playerIndex].rows[block[0]].cells[block[1]].style.backgroundColor = currentColor[playerIndex]

  startGameClock = (playerIndex) ->
    _this = this
    gameClock[playerIndex] = setInterval(((playerIndex)->
      didMove = move(playerIndex,'d')
      return if didMove or nextMoveTimer[playerIndex]?
      nextMoveTimer[playerIndex] = setInterval(((playerIndex)->
        triggerNextPiece(playerIndex)
      ), 200, playerIndex)
    ), 200, playerIndex)

  stopMoveTimer = (playerIndex) ->
    clearInterval(nextMoveTimer[playerIndex]);
    nextMoveTimer[playerIndex] = null

  stopGameClock = (playerIndex) ->
    clearInterval(gameClock[playerIndex])
    gameClock[playerIndex] = null

  clearFullRows = (playerIndex) ->
    checkedRows = []
    fullRows = []
    runs = []

    for block in currentPiece[playerIndex]
      unless block[0] in checkedRows
        checkedRows.push block[0]

    for row in checkedRows.sort().reverse()
      isFullRow = true
      for col in [boundaries[playerIndex][1]..boundaries[playerIndex][3]]
        if playerGrid[playerIndex].rows[row].cells[col].style.backgroundColor == ''
          isFullRow = false
          break
      if isFullRow
        fullRows.push row

    fullRowCount = fullRows.length
    return if fullRowCount < 1

    lineCount[playerIndex] += fullRowCount
    $('.js-line-count').html(lineCount[playerIndex])

    for row in fullRows
      for col in [boundaries[playerIndex][1]..boundaries[playerIndex][3]]
        playerGrid[playerIndex].rows[row].cells[col].style.backgroundColor = ''

    currentRun = 1
    runsCount = 1

    runs[runsCount-1] = [fullRows[0]]
    if fullRowCount > 1
      for rowIndex in [1..fullRowCount-1]
        if runs[runsCount-1][0] == fullRows[rowIndex] + currentRun
          currentRun += 1
          continue
        else
          currentRun = 1
          runs[runsCount-1].push fullRows[rowIndex-1]
          runsCount += 1
          runs[runsCount-1] = [fullRows[rowIndex]]
    runs[runsCount-1].push fullRows[fullRows.length-1]

    runs[runsCount] = [boundaries[playerIndex][0]+fullRowCount]
    lineSubtract = 0
    for runIndex in [0..runsCount-1]
      oldLineSubtract = lineSubtract
      lineSubtract += 1 + runs[runIndex][0] - runs[runIndex][1]
      for row in [runs[runIndex][0]+oldLineSubtract..runs[runIndex+1][0]+lineSubtract]
        for col in [boundaries[playerIndex][1]..boundaries[playerIndex][3]]
          upperColor = playerGrid[playerIndex].rows[row-lineSubtract].cells[col].style.backgroundColor
          playerGrid[playerIndex].rows[row].cells[col].style.backgroundColor = upperColor
          playerGrid[playerIndex].rows[row-lineSubtract].cells[col].style.backgroundColor = ''

  triggerNextPiece = (playerIndex) ->
    return if gettingPiece[playerIndex]
    prepareAjaxCall(playerIndex)
    clearFullRows(playerIndex)

    url = '/games/' + gameId + '/next_piece.js?player_index=' + playerIndex
    $.ajax
      type: 'GET'
      url: url
      success: () ->
        finishAjaxCall(playerIndex)
        ableToHold[playerIndex] = true
        checkForEndOfGame(playerIndex)

  prepareAjaxCall = (playerIndex) ->
    gettingPiece[playerIndex] = true
    stopMoveTimer(playerIndex)
    stopGameClock(playerIndex)

  finishAjaxCall = (playerIndex) ->
    gettingPiece[playerIndex] = false
    ghost(playerIndex)

  checkForEndOfGame = (playerIndex) ->
    return if isValidMove(playerIndex, -1, 0, currentPiece[playerIndex])
    debugger

  $('#js-game-box').on 'gameUpdated', (src, gameId, playerId) ->

    if playerId == ''
      playerCount = playerGrid.length
      for playerIndex in [0..playerCount-1]
        startGameClock(playerIndex)
        ableToHold[playerIndex] = true
        ghost(playerIndex)
        lineCount[playerIndex] = 0
    else
      startGameClock(playerId)
      ghost(playerId)

    return if gameStarted
    gameStarted = true

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
          triggerNextPiece(0)
          gettingPiece[0] = true
          return
        when 81
          # rotate counter-clockwise
          didMove = rotate(0, -1)
        when 69
          # rotate clockwise
          didMove = rotate(0, +1)
        when 32
          hold(0)
          return
        else
          debugger
          return

      if didMove
        stopMoveTimer(0)
        ghost(0)
