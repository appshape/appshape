class JsonArrayEditor
  constructor: (@$element, @templeteSelector, @options = {}) ->
    @options = $.extend({
      fields: {}
    }, @options)

    @template = Handlebars.compile($(@templeteSelector).html())

    @bindDeleteRowButtons()
    @bindNewRowButton()

    @bindExistingRows()

  bindDeleteRowButtons: =>
    @$element.on 'click', 'a.remove-button', @deleteRow

  bindNewRowButton: =>
    $('body').on 'click', @options.addButtonSelector, (e) =>
      e.preventDefault()
      e.stopPropagation()

      @createNewRow({ timestamp: Date.now() })

  bindExistingRows: =>
    $.each @$element.find('.form-group'), (index, row) =>
      @options.onRowAdded($(row)) if @options.onRowAdded

  createNewRow: (object) =>
    $row = $(@template($.extend(@options.fields, object)))
    @$element.append($row)
    @options.onRowAdded($row) if @options.onRowAdded

  deleteRow: (e) =>
    e.preventDefault()
    e.stopPropagation()
    $(e.target).closest('.form-group').remove()

window.JsonArrayEditor = JsonArrayEditor