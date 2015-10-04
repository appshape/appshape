class OmniauthService
  def initialize(oauth, current_user)
    @oauth = oauth
    @current_user = current_user
  end

  def perform
    User.transaction do
      identity.user = user
      identity.save!
      user
    end
  rescue ActiveRecord::RecordInvalid => ex
    ex.record
  end

  private
  def user
    @user ||= @current_user || identity.user || User.find_by(email: @oauth['email']) || create_user
  end

  def create_user
    User.new(
      name: @oauth['extra']['raw_info']['name'],
      email: @oauth['email'],
      password: Devise.friendly_token[0, 20]
    ).tap do |user|
      user.skip_confirmation!
      user.save!
    end
  end

  def identity
    @identity ||= Identity.where(uid: @oauth['uid'], provider: @oauth['provider']).first_or_create!
  end
end