module ApplicationHelper
  BOOTSTRAP_FLASH_MSG = {
      success: 'alert-success',
      error: 'alert-error',
      alert: 'alert-warning',
      notice: 'alert-info'
  }

  def bootstrap_class_for(flash_type)
    BOOTSTRAP_FLASH_MSG.fetch(flash_type.to_sym, flash_type)
  end

  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type)}") do
        concat message
      end)
    end
    nil
  end

  def css_provider_name(provider)
    provider == :google_oauth2 ? :google : provider
  end
end
