# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  if $('.subscribe-button').length > 0
    registerSubscribeEvents 'subscribed', 'not-subscribed', 'unsubscribe', true
    registerSubscribeEvents 'not-subscribed', 'subscribed', 'subscribe', false

registerSubscribeEvents = (linkClassBefore, linkClassAfter, actionName, shouldPromptUser) ->
  $('.subscribe-button .' + linkClassBefore + ' a').each ->
    $(this).on 'click', (e) ->
      if !shouldPromptUser || confirm("Are you sure you want to unsubscribe from this board?")
        boardId = $(this).data('board-id')
        subscribeButton = $('#board-' + boardId + ' .subscribe-button')
        subscribeButton.removeClass('subscribed').removeClass('not-subscribed').addClass('pending')
        $.post '/boards/'+boardId+'/'+actionName+'.json', (data) ->
          if data == 'OK'
            subscribeButton.removeClass('pending').removeClass(linkClassBefore).addClass(linkClassAfter)
          else
            alert("We could not perform this operation at this time; please try again later.")
        return false
