class SliderInput < SimpleForm::Inputs::Base
  def input(wrapper_options)
    input_html_options.merge!({ type: :hidden })
    merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)
    template.capture do
      template.concat(template.content_tag(:div, class: 'col-sm-10') do
        template.concat @builder.text_field(attribute_name, merged_input_options)
        template.concat template.content_tag(:div, nil, id: "#{attribute_name}-slider")
      end)
      template.concat(template.content_tag(:div, class: 'col-sm-2') do
        template.concat template.content_tag(:p, nil, id: "#{attribute_name}-label")
      end)
    end
  end
end