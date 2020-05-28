document.addEventListener('turbolinks:load', function(){
  document.getElementById('exchange_form').addEventListener('ajax:success', function(event) {
    let [result] = event.detail
    document.getElementById('result').value = result.value
  })

  document.getElementById('reverse_conversion').addEventListener('click', function() {
    let temp_currency = document.getElementById('target_currency').value
    if (temp_currency != 'BTC') {
      document.getElementById('target_currency').value = document.getElementById('source_currency').value
      document.getElementById('source_currency').value = temp_currency
      document.forms["exchange_form"].requestSubmit();
    }
  })

  document.getElementById('amount').addEventListener('change', function() {
    let temp_currency = document.getElementById('source_currency').value
    if (temp_currency != 'BTC') {
      document.forms["exchange_form"].requestSubmit();
    }
  })


})
