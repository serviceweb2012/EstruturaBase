# coding: utf-8
class Admin::MenusController < ApplicationController
  layout 'admin'
  before_filter :authenticate_user!

  def index
    @menus = Menu.where("name LIKE ?","%#{params[:search]}%")
                  .order("#{$order} #{$ordem}")
                  .paginate(:per_page => params[:per_page],:page => params[:page])
    @count = @menus.size
    @model_name = t("activerecord.models.menu.other")
    respond_with @menus,:location => admin_menus_path
  end

  def show
    @menu = Menu.find(params[:id])
    respond_with(@menu,:location => admin_menu_path) do |format|
      format.html { render :layout => "show" }
    end
  end

  def new
    @menu = Menu.new
    @model_name = t("activerecord.models.menu.one")
    respond_with @menu,:location => new_admin_menu_path
  end

  def edit
    @menu = Menu.find(params[:id])
    @model_name = t("activerecord.models.menu.one")
  end

  def create
    @menu = Menu.new(params[:menu])
    flash[:notice] = 'Menu criado com sucesso!' if @menu.save
    respond_with @menu,:location => new_admin_menu_path
  end

  def update
    @menu = Menu.find(params[:id])
    flash[:notice] = 'Menu atualizado com sucesso!' if @menu.update_attributes(params[:menu])
    respond_with @menu,:location => admin_menus_path
  end


  def destroy
    @menu = Menu.find(params[:id])
    flash[:notice] = 'Menu deletado com sucesso!' if @menu.destroy
    respond_with @menu,:location => admin_menus_path
  end

  def ordenar_menus
     @menus = Menu.joins(:roles).where('roles.id = ?',current_user.role.id).order("menus.position ASC")
  end


  def sort
     unless params[:menu].nil?
       params[:menu].each_with_index do |id, index|
         Menu.update_all(['position=?', index], ['id=?', id])
       end
     end

     respond_to do |format|
       format.js { render :nothing => true }
     end
  end
end

