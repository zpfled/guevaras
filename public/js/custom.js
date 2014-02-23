"#test-raise".onSubmit(function(event) {
  event.stop();
  this.send({
    onSuccess: function() {
      $('test-price').update(this.responseText);
    }
  });
});