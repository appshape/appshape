module SourcesHelper
  def source_options_for_select(selected = nil)
    container = Source.ordered.map do |source|
      [source.to_s, source.code, { data: { property_required: source.property_required }}]
    end

    options_for_select container, selected: selected
  end
end