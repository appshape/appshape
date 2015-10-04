class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def self.callback_for(provider)
    define_method(provider) do
      @user = OmniauthService.new(env['omniauth.auth'], current_user).perform
      if @user.persisted?
        sign_in_and_redirect
      else
        redirect_to new_user_registration_path
      end
    end
  end

  User.omniauth_providers.each { |provider| callback_for(provider) }

  private
  def sign_in_and_redirect
    sign_in(@user) && redirect_to(root_path)
  end
end