$ ->

  $('#js-game-box').on 'gameReady', (src, gameId) ->

    $(document).keypress (event) ->
      debugger

      keycode = if event.keyCode then event.keyCode else event.which
      if keycode == 13
        alert 'You pressed a "enter" key in somewhere'
