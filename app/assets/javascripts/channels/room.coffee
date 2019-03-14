App.room = null

current_user_id = ->
  $('input:hidden[name="from_id"]').val()

user_id = ->
  $('input:hidden[name="to_id"]').val()

room_id = ->
  $('input:hidden[name="room_id"]').val()

room_ch = ->
  id = room_id()
  if id?
    return {channel: 'RoomChannel', room_id: id}
  else
    return null

messages_height = ->
  temp = 0;
  $("div.message").each ->
    temp += ($(this).outerHeight());
  return temp

document.addEventListener 'turbolinks:request-start', ->
  if room_ch()?
    App.room.unsubscribe()

document.addEventListener 'turbolinks:load', ->
  if room_ch()?
    App.room = App.cable.subscriptions.create room_ch(),
      received: (data) ->
        $('#messages').append data['message']
        $('section.message_box').scrollTop(messages_height());

      speak: (from_id, to_id, room_id, content) ->
        @perform 'speak', {
          "from_id": from_id
          "to_id": to_id
          "room_id": room_id
          "content": content
        }

$(document).on 'keypress', '[data-behavior~=room_speaker]', (event) ->
    if event.which is 13 && !event.shiftKey
      value = event.target.value
      if value.replace(/\s/g, '').length > 0 && value.length <= 50
        App.room.speak(current_user_id(), user_id(), room_id(), value)
        event.target.value = ''
        event.preventDefault()
      else if value.length > 50
        alert("Message should be less than 51 characters.")
        event.target.value = ''
        event.preventDefault()
      else
        event.target.value = ''
        event.preventDefault()
