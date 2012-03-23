# coding: utf-8
class Admin::SubMenusController < ApplicationController
  layout 'admin'
  before_filter :authenticate_user!,:load_resources

  def index
    @sub_menus = SubMenu.where("name LIKE ?","%#{params[:search]}%")
                  .order("#{$order} #{$ordem}")
                  .paginate(:per_page => params[:per_page],:page => params[:page])
    @count = @sub_menus.size
    respond_with @sub_menus,:location => admin_sub_menus_path
  end

  def show
    @sub_menu = SubMenu.find(params[:id])
    respond_with @sub_menu,:location => admin_sub_menu_path
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

  ########
  #teste
  def search
    @count = Menu.count
    if params[:search]
      @menus = Menu.where("name LIKE ?",params[:search]).order(:position => :asc).paginate(:per_page => session[:per_page],:page => params[:page])
    else
      @menus = Menu.order(:position => :asc).paginate(:per_page => params[:per_page],:page => params[:page])
    end
    @search_model_name = Menu.human_name.camelize
    logger.info("TO AQUI !!! #{@menus.size}")
    render :layout => "search"
  end


  def find_sub_menus_by_menu
     @sub_menus = SubMenu.all(:conditions => ["menu_id = ?", params[:menu]], :order => "position")
     respond_to do |format|
       format.html { redirect_to :action => 'index' }
       format.js { render :update do |page|
        page.replace_html "order_sub_menus_list", :partial => "all_sub_menus", :object => @sub_menus
       end }
     end
   end

   def ordenar_sub_menus
     @sub_menus = SubMenu.all(:order => 'position')
   end

   def sort
     unless params[:order_sub_menus_list].nil?
       params[:order_sub_menus_list].each_with_index do |id, index|
         SubMenu.update_all(['position=?', index], ['id=?', id])
       end
     end

     respond_to do |format|
       format.html { redirect_to "/admin/sub_menus/ordenar_sub_menus" }
       format.js { render :nothing => true }
     end
   end


  protected
  def load_resources
    @menus = Menu.order(:name => "asc")
  end
end

