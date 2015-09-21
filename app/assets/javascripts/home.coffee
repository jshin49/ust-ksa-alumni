# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $(".alert-box a.close").on 'click', ->
    $(".alert-box").slideUp()

  $(document).ajaxStart(() -> $("#loading_spinner").css("visibility","visible"))
  $(document).ajaxStop(()-> $("#loading_spinner").css("visibility","hidden"))
