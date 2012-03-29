class Admin::HomeController < ApplicationController
  layout 'admin'
  before_filter :authenticate_user!

  def index
    flash[:notice] = 'Ola bem vindo ao sistema'
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
        format.js
      end

   end

   def delete_all
     ids        = params[:ids].split(",")
     model_name = params[:modelo].camelize.constantize
     url        = request.referer

     ids.each do |id|
       object = model_name.find(id.to_i)
       object.destroy
     end
      respond_to do |format|
        format.html { redirect_to url }
      end
   end

   def disabled_all
      ids        = params[:ids].split(",")
      model_name = params[:modelo].camelize.constantize
      url        = request.referer

      ids.each do |id|
        objeto = model_name.find(id)
        if objeto.respond_to? :situation
          if objeto.situation == true
            objeto.situation = false
          else
            objeto.situation = true
          end
          objeto.save
        end
      end

      respond_to do |format|
       format.html {redirect_to(url)}
     end
   end


end

