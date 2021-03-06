require "mini_magick"

class SponsorsController < ApplicationController
  # GET /sponsors
  # GET /sponsors.json
  def index
    @sponsors = Sponsor.by_name

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sponsors }
    end
  end

  # GET /sponsors/1
  # GET /sponsors/1.json
  def show
    @sponsor = Sponsor.find_by_slug(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @sponsor }
    end
  end

  # GET /sponsors/new
  # GET /sponsors/new.json
  def new
    @sponsor = Sponsor.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @sponsor }
    end
  end

  # GET /sponsors/1/edit
  def edit
    @sponsor = Sponsor.find_by_slug(params[:id])
  end

  # POST /sponsors
  # POST /sponsors.json
  def create
    @sponsor = Sponsor.new(params[:sponsor])

    respond_to do |format|
      if @sponsor.save
        format.html { redirect_to @sponsor, notice: 'Sponsor was successfully created.' }
        format.json { render json: @sponsor, status: :created, location: @sponsor }
      else
        format.html { render action: "new" }
        format.json { render json: @sponsor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /sponsors/1
  # PUT /sponsors/1.json
  def update
    @sponsor = Sponsor.find_by_slug(params[:id])

    respond_to do |format|
      if @sponsor.update_attributes(params[:sponsor])
        format.html { redirect_to @sponsor, notice: 'Sponsor was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @sponsor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sponsors/1
  # DELETE /sponsors/1.json
  def destroy
    @sponsor = Sponsor.find_by_slug(params[:id])
    @sponsor.destroy

    respond_to do |format|
      format.html { redirect_to sponsors_url }
      format.json { head :ok }
    end
  end
  
  def image 
    @sponsor = Sponsor.find_by_slug(params[:id])
     
    image = MiniMagick::Image.open(@sponsor.image)
    image.resize params[:size]
    image.format "png"
    
    logger.info "Resizing happened!"
    
    headers['Cache-Control'] = 'public; max-age=2592000'
    
    send_data image.to_blob, :disposition => 'inline', :type => "image/png"
  end
end
