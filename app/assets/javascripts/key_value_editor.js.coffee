class KeyValueEditor
  constructor: (@$element, @options = {}) ->
    @options = $.extend({
      addButtonSelector: null,
      deleteRowButtonName: 'Delete'
      keyFieldPlaceholder: '',
      valueFieldPlaceholder: ''
      fieldName: ''
    }, @options)

    @bindDeleteRowButtons()
    @bindNewRowButton()
    @createRowsForExistingValues(@$element.data('values'))

  bindDeleteRowButtons: =>
    @$element.on 'click', 'a.remove-button', @deleteRow

  bindNewRowButton: =>
    $('body').on 'click', @options.addButtonSelector, (e) =>
      e.preventDefault()
      e.stopPropagation()

      @createNewRow({ "#{@options.keyFieldName}": '', "#{@options.valueFieldName}" : '' })

  createRowsForExistingValues: (values) =>
    @createNewRow object for object in values

  createNewRow: (object) =>
    row = $("
        <div class='row form-group'>
        <div class='col-md-4'>
          <input type='text' value='#{object[@options.keyFieldName]}' class='form-control' name='#{@options.fieldName}[][#{@options.keyFieldName}]' placeholder='#{@options.keyFieldPlaceholder}'>
        </div>
        <div class='col-md-4'>
          <input type='text' value='#{object[@options.valueFieldName]}' class='form-control' name='#{@options.fieldName}[][#{@options.valueFieldName}]' placeholder='#{@options.valueFieldPlaceholder}'>
        </div>
        <div class='col-md-2'>
            <a href='#' class='remove-button'>#{@options.deleteRowButtonName}</a>
        </div>
        </div>
    ")
    @$element.append(row)
    @options.onRowAdded(row) if @options.onRowAdded

  deleteRow: (e) =>
    e.preventDefault()
    e.stopPropagation()
    $(e.target).closest('.form-group').remove()

window.KeyValueEditor = KeyValueEditor