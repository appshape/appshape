class Tests
  constructor: ->
    @createTypeaheadSourceForHeaders()

    @enableSelect2()
    @enableHeadersEditor()
    @enableUrlParametersEditor()
    @enableFormParametersEditor()
    @enableAssertionsEditor()
    @enableDataPointsEditor()

    @enableSourcePlaceholderInteraction()

    @enableActionsToolbar()

  enableSelect2: =>
    $('.select2').select2()

  createTypeaheadSourceForHeaders: =>
    @httpHeaderBloodhound = new Bloodhound(
      datumTokenizer: Bloodhound.tokenizers.whitespace
      queryTokenizer: Bloodhound.tokenizers.whitespace
      prefetch: {
        url: '/http_headers.json'
      }
    )

  enableHeadersEditor: =>
    new JsonArrayEditor($('#headers'), '#key-value-row-template', {
      fields: {
        key: { name: 'test[headers][][name]', placeholder: 'Header name'},
        value: { name: 'test[headers][][value]', placeholder: 'Header value' },
        removeButtonText: 'Remove'
      },
      addButtonSelector: 'a.headers-add-button',
      onRowAdded: @onNewHttpHeaderRow
    })

  enableUrlParametersEditor: =>
    new JsonArrayEditor($('#url-params'), '#key-value-row-template', {
      fields: {
        key: { name: 'test[url_params][][name]', placeholder: 'Header name'},
        value: { name: 'test[url_params][][value]', placeholder: 'Header value' },
        removeButtonText: 'Remove'
      },
      addButtonSelector: 'a.url-params-add-button',
    })

  enableFormParametersEditor: =>
    new JsonArrayEditor($('#form-params'), '#key-value-row-template', {
      fields: {
        key: { name: 'test[form_params][][name]', placeholder: 'Header name'},
        value: { name: 'test[form_params][][value]', placeholder: 'Header value' },
        removeButtonText: 'Remove'
      },
      addButtonSelector: 'a.form-params-add-button'
    })

  enableAssertionsEditor: =>
    new JsonArrayEditor($('#assertions'), '#assertion-row-template', {
      fields: {
        source: { name: 'test[assertions][][source]' },
        property: { name: 'test[assertions][][property]', placeholder: 'header name or json path or xpath' },
        condition: { name: 'test[assertions][][condition]' },
        value: { name: 'test[assertions][][value]', placeholder: 'value' },
        removeButtonText: 'Remove'
      },
      addButtonSelector: 'a.assertions-add-button',
      onRowAdded: @onNewAssertionRow
    })

  enableDataPointsEditor: =>
    new JsonArrayEditor($('#data-points'), '#data-point-row-template', {
      fields: {
        source: { name: 'test[data_points][][source]' },
        property: { name: 'test[data_points][][property]', placeholder: 'header name or json path or xpath' },
        removeButtonText: 'Remove'
      },
      addButtonSelector: 'a.data-points-add-button',
      onRowAdded: @onNewDataPointRow
    })

  enableSourcePlaceholderInteraction: =>
    $('body').on 'change', 'select[name$="[source]"]', (e) =>
      @onSourceSelectChange($(e.target))

  onSourceSelectChange: ($select) ->
    input = $select.parents('.form-group').find('input[name$="[property]"]')
    if $select.find(':selected').data('property-required')
      input.prop('disabled', false)
      input.attr('placeholder', input.data('placeholder-for-enabled'))
    else
      input.prop('disabled', true)
      input.val('')
      input.attr('placeholder', input.data('placeholder-for-disabled'))

  onNewHttpHeaderRow: (row) =>
    row.find('input[name$="[name]"]').typeahead({
      hint: true,
      highlight: true,
      minLength: 1
    }, {
      name: 'header_names',
      source: @httpHeaderBloodhound
    })

  onNewAssertionRow: (row) =>
    row.find('select[name$="[condition]"]').chained(row.find('select[name$="[source]"]'))
    @onSourceSelectChange(row.find('select[name$="[source]"]'))

  onNewDataPointRow: (row) =>
    @onSourceSelectChange(row.find('select[name$="[source]"]'))

  enableActionsToolbar: =>
    $('#sticker').sticky({ className: 'custom-sticked', topSpacing: 0, widthFromWrapper: false });
    $('#sticker .btn-group a').on 'click', (e) ->
      e.preventDefault()
      e.stopPropagation()
      document.getElementById($(e.target).attr('rel')).scrollIntoView();


$ ->
  new Tests()