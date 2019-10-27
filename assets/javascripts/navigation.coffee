# this gets the navigation running.
# Watch for the event 'turbolinks:load'
# https://github.com/turbolinks/turbolinks
$(document).on 'turbolinks:load', ->
  $("#toggle").on 'click', (e) ->
    e.preventDefault()
    $("#tuckedMenu").toggleClass "custom-menu-tucked"
    $("#toggle").toggleClass "x"
    if $(".pure-menu-list").width() < $(window).width() 
      menuWidth = $(window).width() 
    else 
      menuWidth = $(".pure-menu-list").width()
    $(".custom-menu-screen").css("width", menuWidth)
