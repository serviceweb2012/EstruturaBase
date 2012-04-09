# coding: utf-8
class Admin::RolesController < ApplicationController
  layout 'admin'
  before_filter :authenticate_user!,:load_resources

  def index
    @roles = Role.where("name LIKE ?","%#{params[:search]}%")
                  .order("#{$order} #{$ordem}")
                  .paginate(:per_page => params[:per_page],:page => params[:page])
    @count = @roles.size
    respond_with @roles,:location => admin_roles_path
  end

  def show
    @role = Role.find(params[:id])
    respond_with @role,:location => admin_role_path do |format|
      format.html {render :layout => 'show'}
    end
  end

  def new
    @role = Role.new
    respond_with @role,:location => new_admin_role_path
  end

  def edit
    @role = Role.find(params[:id])
  end

  def create
    @role = Role.new(params[:role])
    flash[:notice] = 'Role criada com sucesso!' if @role.save
    respond_with @role,:location => new_admin_role_path
  end

  def update
    @role = Role.find(params[:id])
    flash[:notice] = 'Role atualizado com sucesso!' if @role.update_attributes(params[:role])
    respond_with @role,:location => admin_roles_path
  end

  def destroy
    @role = Role.find(params[:id])
    flash[:notice] = 'Localização deletado com sucesso' if @role.destroy
    respond_with @role,:location => admin_roles_path
  end

  def find_sub_menus_by_menu
    if params[:menu_id]
      @sub_menus = SubMenu.where(:menu_id => params[:menu_id]).order('position ASC')
      @menu = Menu.find(params[:menu_id])
    end
    @role = params[:role_id].nil? ? Role.new : Role.find(params[:role_id])
    respond_to do |format|
      format.js
    end
  end

  def load_resources
    @menus = Menu.order('position ASC')
  end
end

