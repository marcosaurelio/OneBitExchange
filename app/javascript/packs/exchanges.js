document.addEventListener('turbolinks:load', function(){
  document.getElementById('exchange_form').addEventListener('ajax:success', function(event) {
    let [result] = event.detail
    document.getElementById('result').value = result.value
  })

  document.getElementById('amount').addEventListener('change', function() {

    var elem = document.getElementById('exchange_form') // or $('#myform')[0] with jQuery
    Rails.fire(elem, 'submit');
    
    let temp_currency = document.getElementById('source_currency').value
    document.getElementById('source_currency').value = document.getElementById('target_currency').value
    document.getElementById('target_currency').value = temp_currency
  })
})
