class ApplicationController < ActionController::Base
  protect_from_forgery

  respond_to :html,:xml,:js

  before_filter :load_order,:set_locale,:load_owners

  def load_order
		$order = params[:order].nil? ? 'id' : params[:order]
		$ordem = params[:ordem].nil? ? 'DESC' : params[:ordem]
	end

	def load_owners
    @owner = Owner.last
  end


	private
	def set_locale
    I18n.locale = "ptbr"
  end

end

