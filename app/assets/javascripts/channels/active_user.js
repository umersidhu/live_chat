(function () {
  App.active_user = App.cable.subscriptions.create('ActiveUserChannel', {
    connected: function() {
      App.active_user.user_count();
    },
    disconnected: function() {
      App.active_user.user_count();
    },
    received: function (data) {
      $("#no_of_active").text(data['count'])
    },
    user_count: function() {
      return this.perform('user_count');
  }
  });
})();
