# coding: utf-8
class Admin::PermissionsController < ApplicationController
  layout 'admin'
  before_filter :authenticate_user!,:load_resources

  def index
    @permissions = Permission.where("model_name LIKE ?","%#{params[:search]}%")
                  .order("#{$order} #{$ordem}")
                  .paginate(:per_page => params[:per_page],:page => params[:page])
    @count = @permissions.size
    @model_name = t("activerecord.models.permission.other")
    respond_with @permissions,:location => admin_permissions_path
  end

  def show
    @permission = Permission.find(params[:id])
    @actions = Permission.list_actions_by_model(@permission.model_name)
    respond_with @permission,:location => admin_permission_path do |format|
      format.html {render :layout => 'show'}
    end
  end

  def new
    @permission = Permission.new
    respond_with @permission,:location => new_admin_permission_path
  end

  def edit
    @permission = Permission.find(params[:id])
    @actions = Permission.list_actions_by_model(@permission.model_name)
    @model_name = t("activerecord.models.permission.one")
  end

  def create
    @permission = Permission.new(params[:permission])
    flash[:notice] = 'Permissão criada com sucesso!' if @permission.save
    respond_with @permission,:location => new_admin_permission_path
  end

  def update
    @permission = Permission.find(params[:id])
    flash[:notice] = 'Permissão atualizada com sucesso!' if @permission.update_attributes(params[:permission])
    respond_with @permission,:location => admin_permissions_path
  end

  def destroy
    @permission = Permission.find(params[:id])
    flash[:notice] = 'Permissão deletado com sucesso' if @permission.destroy
    respond_with @permission,:location => admin_permissions_path
  end

  ############

  def find_actions_by_model
    @actions = Permission.list_actions_by_model(params[:model_name])
    respond_to do |format|
      format.js
    end
  end

  protected
  def load_resources
    @roles = Role.order('name ASC')
    @models = Permission.list_models
  end
end

