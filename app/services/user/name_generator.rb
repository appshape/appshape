class User::NameGenerator

  def generate_from_email(email)
    random_hash = SecureRandom.hex(4)
    "#{name_from_email(email)}##{random_hash}"
  end

  private

  def name_from_email(email)
    email.split('@').first
  end

end