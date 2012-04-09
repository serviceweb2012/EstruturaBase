# coding: utf-8
class Admin::SubMenusController < ApplicationController
  layout 'admin'
  before_filter :authenticate_user!,:load_resources

  def index
    @sub_menus = SubMenu.where("name LIKE ?","%#{params[:search]}%")
                  .order("#{$order} #{$ordem}")
                  .paginate(:per_page => params[:per_page],:page => params[:page])
    @count = @sub_menus.size
    @model_name = t("activerecord.models.sub_menu.other")
    respond_with @sub_menus,:location => admin_sub_menus_path
  end

  def show
    @sub_menu = SubMenu.find(params[:id])
    respond_with(@sub_menu,:location => admin_sub_menu_path) do |format|
      format.html { render :layout => "show" }
    end
  end

  def new
    @sub_menu = SubMenu.new
    respond_with @sub_menu,:location => new_admin_sub_menu_path
  end

  def edit
    @sub_menu = SubMenu.find(params[:id])
  end

  def create
    @sub_menu = SubMenu.new(params[:sub_menu])
    flash[:notice] = 'SubMenu criado com sucesso!' if @sub_menu.save
    respond_with @sub_menu,:location => new_admin_sub_menu_path
  end

  def update
    @sub_menu = SubMenu.find(params[:id])
    flash[:notice] = 'SubMenu atualizado com sucesso!' if @sub_menu.update_attributes(params[:sub_menu])
    respond_with @sub_menu,:location => admin_sub_menus_path
  end

  def destroy
    @sub_menu = SubMenu.find(params[:id])
    flash[:notice] = 'SubMenu deletado com sucesso' if @sub_menu.destroy
    respond_with @sub_menu,:location => admin_sub_menus_path
  end

  def find_sub_menus_by_menu
    @sub_menus = SubMenu.where(:menu_id => params[:menu_id]).order('position ASC') if params[:menu_id]
    respond_to do |format|
      #format.html # index.html.erb
      format.js
    end
  end

  def ordenar_sub_menus
     @menus = Menu.order('name ASC')
     respond_with @menus,:location => ordenar_sub_menus_admin_sub_menus_path
  end

  def sort
     unless params[:sub_menu].nil?
       params[:sub_menu].each_with_index do |id, index|
         SubMenu.update_all(['position=?', index], ['id=?', id])
       end
     end

     respond_to do |format|
       format.js { render :nothing => true }
     end
  end

  protected
  def load_resources
    @menus = Menu.order("name ASC")
  end
end

