# coding: utf-8
class Admin::OwnersController < ApplicationController
  layout 'admin'
  before_filter :authenticate_user!
  before_filter :load_model_name,:only => [:show,:new,:edit]

  def index
    @menus = Menu.all
    @owners = Owner.where("name LIKE ?","%#{params[:search]}%")
                  .order("#{$order} #{$ordem}")
                  .paginate(:per_page => params[:per_page],:page => params[:page])
    @count = @owners.size
    @model_name = t("activerecord.models.owner.other")
    respond_with @owners,:location => admin_owners_path
  end

  def show
    @owner = Owner.find(params[:id])
    respond_with @owner,:location => admin_owner_path do |format|
      format.html{ render :layout => 'show'}
    end
  end

  def new
    @owner = Owner.new
    respond_with @owner,:location => new_admin_owner_path
  end

  def edit
    @owner = Owner.find(params[:id])
  end

  def create
    @owner = Owner.new(params[:owner])
    flash[:notice] = 'Representante empresa criado com sucesso!' if @owner.save
    respond_with @owner,:location => new_admin_owner_path
  end

  def update
    @owner = Owner.find(params[:id])
    flash[:notice] = 'Representante empresa atualizado com sucesso!' if @owner.update_attributes(params[:location])
    respond_with @owner,:location => admin_owners_path
  end

  def destroy
    @owner = Owner.find(params[:id])
    flash[:notice] = 'Localização deletado com sucesso' if @owner.destroy
    respond_with @owner,:location => admin_owners_path
  end


  def delete_image
    url = request.referer
    modelo = Owner.find(params[:id])
    nomeImagem = modelo.image_file_name

    modelo.delete_image("#{Rails.root.to_s}/public/images/#{modelo.class.to_s.downcase.pluralize}",nomeImagem)
    modelo.update_attributes(:image_file_name => nil,
                           :image_content_type => nil,
                           :image_file_size => nil)
    flash[:notice] = 'Imagem deletada com sucesso!'
    redirect_to url
   end
  protected
  def load_model_name
    @model_name = t("activerecord.models.owner.one")
  end
end

