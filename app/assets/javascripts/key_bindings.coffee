$ ->

  move = (playerIndex, direction) ->
    i = j = 0
    switch direction
      when 'u' then i = +1
      when 'd' then i = -1
      when 'l' then j = +1
      when 'r' then j = -1
      else alert('bad direction')

    for block in currentPiece[playerIndex]
      tmpBlock = [ block[0] - i, block[1] - j ]
      return false if blockOutOfBounds(tmpBlock, boundaries[playerIndex])

    for block in currentPiece[playerIndex]
      playerGrid[playerIndex].rows[block[0]].cells[block[1]].style.backgroundColor = ''
      block[0] -= i
      block[1] -= j

    for block in currentPiece[playerIndex]
      playerGrid[playerIndex].rows[block[0]].cells[block[1]].style.backgroundColor = currentColor[playerIndex]

    return true

  blockOutOfBounds = (block, boundaries) ->
    return true if block[0] < boundaries[0]
    return true if block[0] > boundaries[2]
    return true if block[1] < boundaries[1]
    return true if block[1] > boundaries[3]
    return false

  $('#js-game-box').on 'gameStart', (src, gameId) ->

    gameClock = []
    playerCount = playerGrid.length
    for playerIndex in [0..playerCount-1]
      gameClock[playerIndex] = setInterval(((playerIndex)->
        didMove = move(playerIndex,'d')
        alert('red') unless didMove
      ), 300, playerIndex)

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

