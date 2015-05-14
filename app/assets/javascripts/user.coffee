# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
$ ->
	user_index_path = "/users"
	result = (data) ->
	
	$('#toggle_school').on 'change', ->
		$.get(user_index_path + "?school="+this.value, result)
	$('#toggle_major').on 'change', ->
		$.get(user_index_path + "?major="+this.value, result)
	$('#toggle_industry').on 'change', ->
		$.get(user_index_path + "?industry="+this.value, result)
	$('#toggle_entrance_year').on 'change', ->
		$.get(user_index_path + "?entrance_year="+this.value, result)
	$('#toggle_graduation_year').on 'change', ->
		$.get(user_index_path + "?graduation_year="+this.value, result)
	$('#toggle_location').on 'change', ->
		$.get(user_index_path + "?location="+this.value, result)
		
		