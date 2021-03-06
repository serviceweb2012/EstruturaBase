# coding: utf-8
class Admin::UsersController < ApplicationController
  layout 'admin'
  before_filter :authenticate_user!,:load_resources
  before_filter :load_model_name,:only => [:show,:new,:edit]

  def index
    @users = User.where("name LIKE ?","%#{params[:search]}%")
                  .order("#{$order} #{$ordem}")
                  .paginate(:per_page => params[:per_page],:page => params[:page])#find_all_with_permission(params[:search],current_user)
    @count = @users.size
    @model_name = t("activerecord.models.user.other")
    respond_with @users,:location => admin_users_path
  end

  def show
    @user = User.find(params[:id])
    respond_with @user,:location => admin_user_path do |format|
      format.html { render :layout => "show" }
    end
  end

  def new
    @user = User.new
    respond_with @user,:location => new_admin_user_path
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(params[:user])
    flash[:notice] = 'Usuário criado com sucesso!' if @user.save
    respond_with @user,:location => new_admin_user_path
  end

  def update
    @user = User.find(params[:id])
    flash[:notice] = 'Usuário atualizado com sucesso!' if @user.update_attributes(params[:user])
    respond_with @user,:location => admin_users_path
  end

  def destroy
    @user = User.find(params[:id])
    flash[:notice] = 'Usuário deletado com sucesso' if @user.destroy
    respond_with @users,:location => admin_users_path
  end

  protected
  def load_resources
    @roles = Role.order('value DESC')
  end

  def load_model_name
    @model_name = t("activerecord.models.user.one")
  end
end

