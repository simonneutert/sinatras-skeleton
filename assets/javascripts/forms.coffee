$(document).on 'turbolinks:load', ->
  # empties the model form's input placeholder on click
  # http://coffeescript.org
  # i love coffeescript, open your mind, it makes javascript usable!
  # It's true!
  $("input#skeleton_name").one 'click', (e) ->
    $(@).val("") if $(@).val() is "Enter Skeleton Name"
