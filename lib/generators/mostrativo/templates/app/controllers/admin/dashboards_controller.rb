# coding: utf-8
class Admin::DashboardsController < ApplicationController
  layout 'admin'
  before_filter :authenticate_user!
  before_filter :load_resourcez,:only => [:new,:edit]
  before_filter :load_model_name,:only => [:show,:new,:edit]

  def index
    @dashboards = Dashboard.where("name LIKE ?","%#{params[:search]}%")
                  .order("#{$order} #{$ordem}")
                  .paginate(:per_page => params[:per_page],:page => params[:page])
    @count = @dashboards.size
    @model_name = t("activerecord.models.dashboard.other")
    respond_with @dashboards,:location => admin_dashboards_path
  end

  def show
    @dashboard = Dashboard.find(params[:id])
    respond_with @dashboard,:location => admin_dashboard_path do |format|
      format.html{ render :layout => 'show'}
    end
  end

  def new
    @dashboard = Dashboard.new
    respond_with @dashboard,:location => new_admin_dashboard_path
  end

  def edit
    @dashboard = Dashboard.find(params[:id])
  end

  def create
    @dashboard = Dashboard.new(params[:dashboard])
    flash[:notice] = 'Atalho criada com sucesso!' if @dashboard.save
    respond_with @dashboard,:location => new_admin_dashboard_path
  end

  def update
    @dashboard = Dashboard.find(params[:id])
    flash[:notice] = 'Atalho atualizado com sucesso!' if @dashboard.update_attributes(params[:dashboard])
    respond_with @dashboard,:location => admin_dashboards_path
  end

  def destroy
    @dashboard = Dashboard.find(params[:id])
    flash[:notice] = 'Atalho deletado com sucesso' if @dashboard.destroy
    respond_with @dashboard,:location => admin_dashboards_path
  end

  protected
  def load_resourcez
    @sub_menus_list = SubMenu.list_sub_menu_by_permission(current_user)
    @icones = Dashboard.list_icons
  end

  def load_model_name
    @model_name = t("activerecord.models.dashboard.one")
  end

end

