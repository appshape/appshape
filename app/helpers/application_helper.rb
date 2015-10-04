module ApplicationHelper
  def css_provider_name(provider)
    provider == :google_oauth2 ? :google : provider
  end
end
