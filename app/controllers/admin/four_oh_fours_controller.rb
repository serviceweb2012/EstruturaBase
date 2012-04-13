class Admin::FourOhFoursController < ApplicationController
  layout 'admin'
  before_filter :authenticate_user!

  def index
    @four_oh_fours = FourOhFour.where('host LIKE :t or path LIKE :t or referer LIKE :t',:t => "%#{params[:search]}%")
                  .order("#{$order} #{$ordem}")
                  .paginate(:per_page => params[:per_page],:page => params[:page])
    @count = @four_oh_fours.size
    @model_name = t("activerecord.models.four_oh_four")
    respond_with @four_oh_fours,:location => admin_four_oh_fours_path
  end

  def add_request
    FourOhFour.add_request(request.host, request.path, request.env['HTTP_REFERER'] || '')
    logger.info("URL ERRADA : #{params[:path]}")

    respond_to do |format|
      format.html { render :file => "#{Rails.root.to_s}/public/404.html",:status => 404,:layout => false }
    end
  end

  def show
    @four_oh_four = FourOhFour.find(params[:id])
    respond_with @location,:location => admin_four_oh_four_path do |format|
      format.html{ render :layout => 'show'}
    end
  end
end

