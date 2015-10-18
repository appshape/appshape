module ConditionsHelper
  def conditions_options_for_chained_select
    container = Condition.includes(:sources).map do |condition|
      [condition.to_s, condition.code, { class: condition.sources.map(&:code).join(' ') }]
    end
    options_for_select container
  end

  def source_options_for_select
    container = Source.ordered.map do |source|
      [source.to_s, source.code, { data: { property_required: source.property_required }}]
    end

    options_for_select container
  end
end