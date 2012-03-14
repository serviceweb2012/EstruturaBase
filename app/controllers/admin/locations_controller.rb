# coding: utf-8
class Admin::LocationsController < ApplicationController
  layout 'admin'
  before_filter :authenticate_user!

  def index
    @locations = Location.where("street LIKE ?","%#{params[:search]}%")
                  .order("#{$order} #{$ordem}")
                  .paginate(:per_page => session[:per_page],:page => params[:page])
    @count = @locations.size
    respond_with @locations,:location => admin_locations_path
  end

  def show
    @location = Location.find(params[:id])
    respond_with @location,:location => admin_location_path
  end

  def new
    @location = Location.new
    respond_with @location,:location => new_admin_location_path
  end

  def edit
    @location = Location.find(params[:id])
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
end

