class ServiceClassesController < ApplicationController
  before_filter :require_login

  load_and_authorize_resource

  # GET /service/:service_id/class/new
  def new
    @service_class = ServiceClass.new
    @service_class.service = Service.find(params[:service_id])

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @service_class }
    end
  end

  # GET /service/:service_id/class/1/edit
  def edit
    @service_class = ServiceClass.find(params[:id])
  end

  # POST/service/:service_id/class
  def create
    @service_class = ServiceClass.new(params[:service_class])

    respond_to do |format|
      if @service_class.save
        format.html { redirect_to @service_class.service, notice: 'Класс обслуживания успешно создан.' }
      else
        format.html { render action: "new", alert: params[:message] }
      end
    end
  end

  # PUT /service/:service_id/class/1
  def update
    @service_class = ServiceClass.find(params[:id])

    respond_to do |format|
      if @service_class.update_attributes(params[:service_class])
        format.html { redirect_to Service.find(params[:service_id]), notice: 'Класс обслуживания успешно обновлен.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /service/:service_id/class/1/delete
  def destroy
    @service_class = ServiceClass.find(params[:id])
    @service_class.destroy

    respond_to do |format|
      format.html { redirect_to Service.find(params[:service_id]), notice: 'Класс обслуживания успешно удален.' }
    end
  end
end
