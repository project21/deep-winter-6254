// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require_tree .
jQuery.ajaxSetup({ 
  'beforeSend': function(xhr, settings) {
    xhr.setRequestHeader("Accept", "application/json");
    settings['dataType'] = "json";
    settings['contentType'] = "application/json";
  }
});
$(document).ready(function() {
  $('#test2').click(function(){
   $(".test").modal();
   $('#test').removeClass('ui-helper-hidden');
});
(function() {
  var subscription;
  jQuery(function() {
    Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'));
    return subscription.setupForm();
  });
  subscription = {
    setupForm: function() {
      return $('#new_token').submit(function() {
        $('input[type=submit]').attr('disabled', true);
        if ($('#card_number').length) {
          subscription.processCard();
          return false;
        } else {
          return true;
        }
      });
    },
    processCard: function() {
      var card;
      card = {
        number: $('#card_number').val(),
        cvc: $('#card_code').val(),
        expMonth: $('#card_month').val(),
        expYear: $('#card_year').val()
      };
      return Stripe.createToken(card, subscription.handleStripeResponse);
    },
    handleStripeResponse: function(status, response) {
      if (status === 200) {
          $('#token_stripe_card_token').val(response.id);
          var quantity= $('#token_buck').val();
               if (quantity > 0 && ($('#accept').is(':checked')) ){
          $('#token_buck').val(quantity*100);
        $('#new_token')[0].submit();}
               else{$('#stripe_error').text("Please  accept the terms and condition before submitting. Quantity has to be atleast 1");
                      $('input[type=submit]').attr('disabled', false);
                   }
      } else {
        $('#stripe_error').text(response.error.message);
       $('input[type=submit]').attr('disabled', false);
      }
    }
  };
}).call(this);



	});