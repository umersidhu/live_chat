(function () {
  $("#no_of_users").hide();
  $("#no_of_valid_users").hide();
  var roomId = $('#room-id').val();
  if (!roomId) return;

  var $messageArea = $('.message-area');
  var $messageForm = $('.message-form textarea');

  App.room = App.cable.subscriptions.create({channel: 'RoomChannel', room_id: roomId}, {
    connected: function() {
      App.room.update_students_counter
    },
    disconnected: function() {
      App.cable.subscriptions.remove(this)
    },
    received: function (data) {
      if (data["username"] != "undefined") {
        $messageArea.append(this.renderMessage(data));
        scrollToBottom();
      }
    },
    renderMessage: function (data) { return messageItemTmpl(data.username, data.content); }
  });

  $(function () {
    scrollToBottom();
    onScrollMessageArea();
    onEnterMessageform();
  });

  function scrollToBottom () {
    $messageArea.scrollTop($messageArea[0].scrollHeight);
  }

  function onEnterMessageform () {
    $messageForm.on('keydown', function (e) {
      if (!this.value || !this.value.trim()) return;
      if (e.keyCode == 13 && !e.shiftKey) {
        e.preventDefault();
        $('form#new_message').submit();
        $messageForm.val('');
      }
    });
  }

  function onScrollMessageArea () {
    $messageArea.on('scroll', function (e) {
      var firstMessageId = $('#first-message-id').val();
      var scrollPosition = $messageArea.scrollTop();
      if (scrollPosition != 0 || firstMessageId <= 1) return;
      $.ajax({
        url: '/rooms/'+ roomId + '/messages/old/' + firstMessageId,
        method: 'GET',
        statusCode: {
          200: function (response) {
            response.forEach(function (item) {
              $messageArea.prepend(messageItemTmpl(item.username, item.content))
            });
            $messageArea.scrollTop(response.length * 20);
            $('#first-message-id').val(response[response.length - 1].id);
          }
        }
      });
    });
  }

  function setObject(key, obj) {
    localStorage.setItem(key, JSON.stringify(obj));
  }

  function updateItem(key, property, value)
  {
      var obj = getObject(key);
      obj = value;    
      setObject(key, obj);
  }

  function getObject(key) {
    return JSON.parse(localStorage.getItem(key));
  }

  function messageItemTmpl(user, message) {
    return '<div class="message-item"><strong class="message-user">'+ user +': </strong><span>'+ message +'</span></div>'
  }
})();
