# coding: utf-8
class Admin::LocationsController < ApplicationController
  layout 'admin'
  before_filter :authenticate_user!

  def index
    @locations = Location.where("name LIKE ?","%#{params[:search]}%")
                  .order("#{$order} #{$ordem}")
                  .paginate(:per_page => params[:per_page],:page => params[:page])
    @count = @locations.size
    @model_name = t("activerecord.models.location.other")
    respond_with @locations,:location => admin_locations_path
  end

  def show
    @location = Location.find(params[:id])
    respond_with @location,:location => admin_location_path do |format|
      format.html{ render :layout => 'show'}
    end
  end

  def new
    @location = Location.new
    @model_name = t("activerecord.models.location.one")
    respond_with @location,:location => new_admin_location_path
  end

  def edit
    @location = Location.find(params[:id])
    @model_name = t("activerecord.models.location.one")
  end

  def create
    @location = Location.new(params[:location])
    flash[:notice] = 'Localização criada com sucesso!' if @location.save
    respond_with @location,:location => new_admin_location_path
  end

  def update
    @location = Location.find(params[:id])
    flash[:notice] = 'Localização atualizado com sucesso!' if @location.update_attributes(params[:location])
    respond_with @location,:location => admin_locations_path
  end

  def destroy
    @location = Location.find(params[:id])
    flash[:notice] = 'Localização deletado com sucesso' if @location.destroy
    respond_with @location,:location => admin_locations_path
  end


  def delete_image
    url = request.referer
    modelo = Location.find(params[:id])
    nomeImagem = modelo.image_file_name

    modelo.delete_image("#{Rails.root.to_s}/public/images/#{modelo.class.to_s.downcase.pluralize}",nomeImagem)
    modelo.update_attributes(:image_file_name => nil,
                           :image_content_type => nil,
                           :image_file_size => nil)
    flash[:notice] = 'Imagem deletada com sucesso!'
    redirect_to url
   end

end

