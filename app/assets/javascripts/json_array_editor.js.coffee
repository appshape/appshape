class JsonArrayEditor
  constructor: (@$element, @templeteSelector, @options = {}) ->
    @options = $.extend({
      fields: {}
    }, @options)

    @template = Handlebars.compile($(@templeteSelector).html())

    @bindDeleteRowButtons()
    @bindNewRowButton()

    @createRowsForExistingValues(@$element.data('values'))

  bindDeleteRowButtons: =>
    @$element.on 'click', 'a.remove-button', @deleteRow

  bindNewRowButton: =>
    $('body').on 'click', @options.addButtonSelector, (e) =>
      e.preventDefault()
      e.stopPropagation()

      @createNewRow({})

  createRowsForExistingValues: (objects) =>
    @createNewRow object for object in objects

  createNewRow: (object) =>
    $row = $(@template($.extend(@options.fields, object)))
    @$element.append($row)
    @options.onRowAdded($row) if @options.onRowAdded

  deleteRow: (e) =>
    e.preventDefault()
    e.stopPropagation()
    $(e.target).closest('.form-group').remove()

window.JsonArrayEditor = JsonArrayEditor