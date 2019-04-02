(function () {
  App.valid_user = App.cable.subscriptions.create('ValidUserChannel', {
    connected: function() {
      App.valid_user.valid_user_count()
    },
    disconnected: function() {
      App.valid_user.valid_user_count()
    },
    received: function (data) {
      $("#no_of_valid").text(data['count'])
      if (parseInt(data['count']) >= 3 && location.href.split("/")[location.href.split("/").length - 1] != "1" || parseInt(data['count']) == 0 && location.href.split("/")[location.href.split("/").length - 1] == "1" ) {
        window.location.href = window.location.href;
      }
    },
    valid_user_count: function() {
      return this.perform('valid_user_count')
    }
  });
})();