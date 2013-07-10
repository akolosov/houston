# encoding: utf-8
class TagsController < ApplicationController
  before_filter :require_login

  load_and_authorize_resource

  # GET /tags
  # GET /tags.json
  def index
    @tags = Tag.accessible_by(current_ability).sort_by{ | tag | tag.problems.count }.reverse

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /tags/new
  # GET /tags/new.json
  def new
    @tag = Tag.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /tags/1/edit
  def edit
    @tag = Tag.find(params[:id])
  end

  # POST /tags
  # POST /tags.json
  def create
    @tag = Tag.new(params[:tag])

    respond_to do |format|
      if @tag.save
        format.html { redirect_to :tags, notice: 'Метка успешно создана.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  # PUT /tags/1
  # PUT /tags/1.json
  def update
    @tag = Tag.find(params[:id])

    respond_to do |format|
      if @tag.update_attributes(params[:tag])
        format.html { redirect_to :tags, notice: 'Метка успешно обновлена.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  # DELETE /tags/1
  # DELETE /tags/1.json
  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy

    respond_to do |format|
      format.html { redirect_to :tags, notice: 'Метка успешно удалена.' }
    end
  end
end
