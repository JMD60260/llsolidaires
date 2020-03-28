ActionMailer::Base.smtp_settings = {
  domain: 'les-logements-solidaires.com',
  address:        "smtp.sendgrid.net",
  port:            587,
  authentication: :plain,
  user_name:      ENV['SENDGRID_LOGIN'],
  password:       ENV['SENDGRID_API_KEY']
}
