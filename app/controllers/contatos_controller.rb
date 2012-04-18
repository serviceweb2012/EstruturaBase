class ContatosController < ApplicationController
  def index
    @contato = Contato.new
  end

  def enviar
    contato  = Contato.new
    contato.name     = params[:name]
    contato.phone    = params[:phone]
    contato.email    = params[:email]
    contato.subject  = params[:subject]
    contato.message  = params[:message]
    contato.city     = params[:city]

    unless contato.name.blank? && contato.email.blank? && contato.subject.blank? && contato.message.blank?
      ContactMailer.send_email_contact(contato).deliver
      flash[:notice] = 'Mensagem enviada com sucesso!'
    else
      flash[:notice] = 'Erro ao enviar mensagem'
    end

    redirect_to contato_path
  end
end

