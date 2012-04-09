class Admin::FourOhFoursController < ApplicationController
  layout 'admin'
  before_filter :authenticate_user!

  def index
    @four_oh_fours = FourOhFour.order("#{$order} #{$ordem}")
                  .paginate(:per_page => params[:per_page],:page => params[:page])
    @count = @four_oh_fours.size
    @model_name = 'Four oh Fours'
    respond_with @four_oh_fours,:location => admin_four_oh_fours_path
  end

  def add_request
    FourOhFour.add_request(request.host, request.path, request.env['HTTP_REFERER'] || '')

    respond_to do |format|
      format.html { render :file => "#{Rails.root.to_s}/public/404.html" }
      format.all { render :nothing => true, :status => "404 Not Found" }
    end
  end
end

