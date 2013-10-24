getId = (el) ->
  $(el).data "id"

$('.check').on 'click', (evt) ->
  mixpanel.track("Checked - #{getId(evt.target)}")

$('.x').on 'click', (evt) ->
  mixpanel.track("X-ed - #{getId(evt.target)}")