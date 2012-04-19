# coding: utf-8
WillPaginate::ViewHelpers.pagination_options[:previous_label] = '&laquo; Anterior'
WillPaginate::ViewHelpers.pagination_options[:next_label] = 'Próximo &raquo;'
WillPaginate.per_page = 10


#email
ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "", #gmail.com
  :user_name            => "",
  :password             => "",
  :authentication       => "plain",
  :enable_starttls_auto => true
}

