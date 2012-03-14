class Admin::HomeController < ApplicationController
  layout 'admin'
  before_filter :authenticate_user!

  def index
    #codigo exemplo
    @size = Menu.count
    flash[:notice] = 'Ola bem vindo ao sistema'
  end

  def set_session
     if params[:per_page]
       session[:per_page] = params[:per_page]
     elsif session[:per_page].nil?
       session[:per_page] = 15
     else
       session[:per_page] ||= session[:per_page]
     end

     search = params[:search].blank? ? "" : "?search=#{params[:search]}"
     url = "#{params[:url]}#{search}"
     respond_to do |format|
       format.html { render :redirect_to =>  url }
       format.js { render :update do |page|
        page.redirect_to(url)
       end
       }
     end
   end

   def enabled_disabled
     id = params[:id]
     model_name =  params[:name].to_s.camelize.constantize
     object = model_name.find(id)
      if object.respond_to?(:situation)
        if object.situation
          object.situation = false
        else
          object.situation = true
        end
        object.save
      end
      respond_to do |format|
        format.js { render :update do |page|
          page.reload
        end }
      end
   end

   def delete_all
     ids = params[:ids].to_s.split(',')
     model_name =  params[:name].to_s.camelize.constantize
     url = params[:url].to_s.gsub("_", "/")
     ids.each do |id|
       object = model_name.find(id.to_i)
       object.destroy
      end
      respond_to do |format|
        format.html { redirect_to url }
      end
   end

   def disabled_all
      ids = params[:ids].to_s.split(',')
      model_name =  params[:name].to_s.camelize.constantize
      url = params[:url].to_s.gsub("_", "/")
      ids.each do |id|
        object = model_name.find(id)
        if object.respond_to?(:situation)
           if object.situation
             object.situation = false
           else
             object.situation = true
           end
           object.save
        end
       end
       respond_to do |format|
         format.html { redirect_to url }
       end
    end


end

