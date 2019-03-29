(function () {
  App.active_user = App.cable.subscriptions.create('ActiveUserChannel', {
    connected: function() {
      App.active_user.user_count($('#no_of_users').text());
    },
    disconnected: function() {
    },
    received: function (data) {
      $("#no_of_active").text(data['count'])
    },
    user_count: function(message) {
      return this.perform('user_count', {
        count: message
      });
  }
  });
})();
