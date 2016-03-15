class TestForm
  constructor: ->
    @createTypeaheadSourceForHeaders()

    @enableSelect2()
    @enableDependendProjectsSelect()
    @enableHeadersEditor()
    @enableUrlParametersEditor()
    @enableFormParametersEditor()
    @enableAssertionsEditor()
    @enableDataPointsEditor()

    @enableSourcePlaceholderInteraction()

    @enableActionsToolbar()

  enableSelect2: ->
    $('.select2').select2()

  enableDependendProjectsSelect: ->
    $('.organizations-select').change(@organizationChange)

  organizationChange: (event) ->
    organization_id = event.currentTarget.value
    $.get("/organizations/#{organization_id}/projects.json", {}, (response) ->
      $select = $('.dependent-projects-select')
      $select.html ''
      for project in response.projects
        $select.append "<option value='" + project.id + "'>" + project.name + "</option>"
    , 'json')

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
        prefix: 'test[request_attributes][headers_attributes]'
        key: { name: 'name', placeholder: 'Header name'},
        value: { name: 'value', placeholder: 'Header value' },
        removeButtonText: 'Remove'
      },
      addButtonSelector: 'a.headers-add-button',
      onRowAdded: @onNewHttpHeaderRow
    })

  enableUrlParametersEditor: =>
    new JsonArrayEditor($('#url-params'), '#key-value-row-template', {
      fields: {
        prefix: 'test[request_attributes][url_params_attributes]',
        key: { name: 'name', placeholder: 'Param name'},
        value: { name: 'value', placeholder: 'Param value' },
        removeButtonText: 'Remove'
      },
      addButtonSelector: 'a.url-params-add-button',
    })

  enableFormParametersEditor: =>
    new JsonArrayEditor($('#form-params'), '#key-value-row-template', {
      fields: {
        prefix: 'test[request_attributes][form_params_attributes]',
        key: { name: 'name', placeholder: 'Param name'},
        value: { name: 'value', placeholder: 'Param value' },
        removeButtonText: 'Remove'
      },
      addButtonSelector: 'a.form-params-add-button'
    })

  enableAssertionsEditor: =>
    new JsonArrayEditor($('#assertions'), '#assertion-row-template', {
      fields: {
        prefix: 'test[request_attributes][assertions_attributes]',
        source: { name: 'source_code' },
        property: { name: 'property', placeholder: 'header name or json path or xpath' },
        condition: { name: 'condition_code' },
        value: { name: 'value', placeholder: 'value' },
        removeButtonText: 'Remove'
      },
      addButtonSelector: 'a.assertions-add-button',
      onRowAdded: @onNewAssertionRow
    })

  enableDataPointsEditor: =>
    new JsonArrayEditor($('#data-points'), '#data-point-row-template', {
      fields: {
        prefix: 'test[request_attributes][data_points_attributes]',
        source: { name: 'source_code' },
        property: { name: 'property', placeholder: 'header name or json path or xpath' },
        removeButtonText: 'Remove'
      },
      addButtonSelector: 'a.data-points-add-button',
      onRowAdded: @onNewDataPointRow
    })

  enableSourcePlaceholderInteraction: =>
    $('body').on 'change', 'select[name$="[source_code]"]', (e) =>
      @onSourceSelectChange($(e.target))

  onSourceSelectChange: ($select) ->
    input = $select.closest('.form-group').find('input[name$="[property]"]')
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
    row.find('select[name$="[condition_code]"]').chained(row.find('select[name$="[source_code]"]'))
    @onSourceSelectChange(row.find('select[name$="[source_code]"]'))

  onNewDataPointRow: (row) =>
    @onSourceSelectChange(row.find('select[name$="[source_code]"]'))

  enableActionsToolbar: =>
    $('#sticker').sticky({ className: 'custom-sticked', topSpacing: 0, widthFromWrapper: false });
    $('#sticker .btn-group a').on 'click', (e) ->
      e.preventDefault()
      e.stopPropagation()
      document.getElementById($(e.target).attr('rel')).scrollIntoView();

$ ->
  new TestForm() if $('form.test-form').length > 0