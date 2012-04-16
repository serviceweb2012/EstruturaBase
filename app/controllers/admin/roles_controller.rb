# coding: utf-8
class Admin::RolesController < ApplicationController
  layout 'admin'
  before_filter :authenticate_user!,:load_resources

  def index
    @roles = Role.where("name LIKE ?","%#{params[:search]}%")
                  .order("#{$order} #{$ordem}")
                  .paginate(:per_page => params[:per_page],:page => params[:page])
    @count = @roles.size
    @model_name = t("activerecord.models.role.other")
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
    @model_name = t("activerecord.models.role.one")
    respond_with @role,:location => new_admin_role_path
  end

  def edit
    @role = Role.find(params[:id])
    @model_name = t("activerecord.models.role.one")
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

  def menus
    @menus = Role.find(current_user.role.id).menus.paginate(:per_page => params[:per_page],:page => params[:page])
    @model_name = 'Menus/Permissões'
    respond_with @menus,:location => menus_admin_roles_path
  end

  def sub_menus
    @sub_menus = Role.find(current_user.role.id).sub_menus.paginate(:per_page => params[:per_page],:page => params[:page])
    @model_name = 'SubMenus/Permissões'
    respond_with @sub_menus,:location => sub_menus_admin_roles_path
  end

  protected
  def load_resources
    @menus = Menu.order('position ASC')
  end
end

