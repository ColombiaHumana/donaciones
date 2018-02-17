# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  handler = ePayco.checkout.configure({
                                        key: "45b960805ced5c27ce34b1600b4b9f54",
                                        test: false
                                      })

  data = {
          name: "Donaciones Colombia Humana",
          description: "",
          invoice: "1",
          currency: "cop",
          amount: '5000',
          lang: "es",
          country: "co",
          tax: "0",
          tax_base: "0",
          confirmation: "http://localhost:3000/confirmation",
          response: "http://localhost:3000/response"
         }
  $('.boton_pagar').on 'click', ->
    handler.open data

  slider = document.getElementById('slider');

  noUiSlider.create(slider, {
    step: 5000,
  	start: [ 5000 ],
  	range: {
  		'min': [ 5000 ],
  		'max': [ 5000000 ]
  	}
  })
  directionField = $('#field');
  console.log directionField

  slider.noUiSlider.on 'update', ( values, handle ) ->
    directionField.html values[handle]
    data.amount = values[handle]
