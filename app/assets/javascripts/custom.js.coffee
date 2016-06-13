@add_fields = (link, association, content) ->
  new_id = (new Date).getTime()
  regexp = new RegExp('new_' + association, 'g')
  $(content.replace(regexp, new_id)).insertBefore 'input[type=\'submit\']'

@remove_fields = (link) ->
  ip = $(link).parent().find('input[type=\'hidden\']')
  $(ip).val 'true'
  $(link).closest('.nested-fields').hide()
