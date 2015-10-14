class Tests
  constructor: ->
    @createTypeaheadSourceForHeaders()

    @enableSelect2()
    @enableHeadersEditor()
    @enableUrlParametersEditor()
    @enableFormParametersEditor()

    $('#sticker').sticky({ className: 'custom-sticked', topSpacing: 0, widthFromWrapper: false });

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
    new KeyValueEditor($('#headers'), {
      keyFieldName: 'name',
      keyFieldPlaceholder: 'Header name',
      valueFieldName: 'value',
      valueFieldPlaceholder: 'Header value',
      fieldName: 'test[headers]',
      addButtonSelector: 'a.headers-add-button',
      deleteRowButtonName: 'Remove'
      onRowAdded: @onNewHttpHeaderRow
    })

  enableUrlParametersEditor: =>
    new KeyValueEditor($('#url-params'), {
      keyFieldName: 'name',
      keyFieldPlaceholder: 'Param name',
      valueFieldName: 'value',
      valueFieldPlaceholder: 'Param value',
      fieldName: 'test[url_params]',
      addButtonSelector: 'a.url-params-add-button',
      deleteRowButtonName: 'Remove'
    })

  enableFormParametersEditor: =>
    new KeyValueEditor($('#form-params'), {
      keyFieldName: 'name',
      keyFieldPlaceholder: 'Param name',
      valueFieldName: 'value',
      valueFieldPlaceholder: 'Param value',
      fieldName: 'test[form_params]',
      addButtonSelector: 'a.form-params-add-button',
      deleteRowButtonName: 'Remove'
    })

  onNewHttpHeaderRow: (row) =>
    row.find('input[name$="[name]"]').typeahead({
      hint: true,
      highlight: true,
      minLength: 1
    }, {
      name: 'header_names',
      source: @httpHeaderBloodhound
    })

$ ->
  new Tests()