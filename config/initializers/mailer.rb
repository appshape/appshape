ActionMailer::Base.smtp_settings = {
    :user_name => ENV['MAILER_USER'],
    :password => ENV['MAILER_PASSWORD'],
    :domain => 'appshape.io',
    :address => ENV['MAILER_ADDRESS'],
    :port => 587,
    :authentication => :plain,
    :enable_starttls_auto => true
}