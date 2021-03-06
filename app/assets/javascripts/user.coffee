# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
ready = ->
  ## users/edit

  console.log "javascript loaded correctly"

  autocomplete_url = (field, url) ->
    field.autocomplete
      minLength: 2,
      source: (request, response) ->
        $.ajax
          url: url
          dataType: "json"
          data:
            term: request.term
          success: (data) ->
            response(data)

  autocomplete_url($('#user_location'), "/user/autocomplete_location")
  autocomplete_url($('#user_organization'), "/user/autocomplete_organization")

  $('.more_industries a').on 'click', (event)->
    console.log "click more choices"
    $(this).hide()
    $(this).parent().next().show("slow")
    event.preventDefault()

  if $('#alumni-joyride').length && $.cookie("alumni-edit-joyride") == null
    console.log "alumni edit joyride"
    $.cookie("alumni-edit-joyride", "true");
    $(document).foundation('joyride', 'start')
  else if $('#linkedin-joyride').length
    console.log "linkedin-joyride"
    $('#alumni-joyride').remove()
    $(document).foundation('joyride', 'start')
  ## users

  if $("#index-joyride").length
    console.log "index-joyride"
    $(document).foundation('joyride', 'start')

  if $("#filter-joyride").length && $.cookie("filter-joyride") ==null
    console.log "filter-joyride"
    $.cookie("filter-joyride", "true")
    $(document).foundation('joyride', 'start')

  dropDown = [$('#toggle_school'), $('#toggle_major'),$('#toggle_industry'),$('#toggle_entrance_year'),$('#toggle_graduation_year'),$('#toggle_location')]
  resetDropDown = (count) ->
    $("#reset-filter").css('visibility','visible')
    for i in [0..5]
      if (i!=count)
       dropDown[i].val('');
       dropDown[i].css("font-weight","normal");
      else
       dropDown[i].css("font-weight","bold");


  user_index_path = "/users"
  result = (data) ->

  $('#toggle_school').on 'change', ->
    $.get(user_index_path + "?school="+this.value, result)
    resetDropDown(0)
  $('#toggle_major').on 'change', ->
    $.get(user_index_path + "?major="+this.value, result)
    resetDropDown(1)
  $('#toggle_industry').on 'change', ->
    $.get(user_index_path + "?industry="+this.value, result)
    resetDropDown(2)
  $('#toggle_entrance_year').on 'change', ->
    $.get(user_index_path + "?entrance_year="+this.value, result)
    resetDropDown(3)
  $('#toggle_graduation_year').on 'change', ->
    $.get(user_index_path + "?graduation_year="+this.value, result)
    resetDropDown(4)
  $('#toggle_location').on 'change', ->
    $.get(user_index_path + "?location="+this.value, result)
    resetDropDown(5)

  ## users/new

  $('#user_sign_up_submit').on 'click', ->
    $('#user_email').prop('disabled', false)

$(document).ready(ready)
$(document).on('page:load', ready)
