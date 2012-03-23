# coding: utf-8
class Admin::ReportErrorsController < ApplicationController
  layout 'admin'
  before_filter :authenticate_user!

  def index
    @report_errors = ReportError.where("name LIKE ?","%#{params[:search]}%")
                  .order("#{$order} #{$ordem}")
                  .paginate(:per_page => params[:per_page],:page => params[:page])
    @count = @report_errors.size
    respond_with @report_errors,:location => admin_report_errors_path
  end

  def show
    @report_error = ReportError.find(params[:id])
    respond_with @report_error,:location => admin_report_error_path
  end

  def new
    @report_error = ReportError.new
    respond_with @report_error,:location => new_admin_report_error_path
  end

  def edit
    @report_error = ReportError.find(params[:id])
  end

  def create
    @report_error = ReportError.new(params[:report_error])
    flash[:notice] = 'Erro reportado criada com sucesso!' if @report_error.save
    respond_with @report_error,:location => new_admin_report_error_path
  end

  def update
    @report_error = ReportError.find(params[:id])
    flash[:notice] = 'Erro reportado atualizado com sucesso!' if @report_error.update_attributes(params[:report_error])
    respond_with @report_error,:location => admin_report_errors_path
  end

  def destroy
    @report_error = ReportError.find(params[:id])
    flash[:notice] = 'Erro reportado deletado com sucesso' if  @report_error.destroy
    respond_with @report_error ,:location => admin_report_error_path
  end
end

