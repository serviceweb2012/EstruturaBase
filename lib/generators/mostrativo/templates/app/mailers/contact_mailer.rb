# coding: utf-8
class ContactMailer < ActionMailer::Base
  #to => email para onde será enviado
  #from => email de quem enviou a mensagem
  default :to => "email@email.com",:subject => "Formulário de Contato"


  def send_email_contact(contato)
    @contato = contato
    @owner = Owner.last.nil? ? "" : Owner.last.name
    mail(:from => contato.email)
  end
end

