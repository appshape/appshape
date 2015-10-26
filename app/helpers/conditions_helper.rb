module ConditionsHelper
  def conditions_options_for_chained_select(selected = nil)
    container = Condition.includes(:sources).map do |condition|
      [condition.to_s, condition.code, { class: condition.sources.map(&:code).join(' ') }]
    end
    options_for_select container, selected: selected
  end
end