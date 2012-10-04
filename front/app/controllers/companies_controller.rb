class CompaniesController < ApplicationController
  before_filter :authenticate_user!, :except => [ :publish,:test ]
  
  # GET /companies
  # GET /companies.json
  def index
    @companies = Company.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @companies }
    end
  end

  # GET /companies/1
  # GET /companies/1.json
  def show
    @company = current_user.company
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @company }
    end
  end

  # GET /companies/new
  # GET /companies/new.json
  def new
    @company = Company.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @company }
    end
  end

  # GET /companies/1/edit
  def edit
    @company = current_user.company
  end

  # POST /companies
  # POST /companies.json
  def create
    @company = Company.new(params[:company])

    respond_to do |format|
      if @company.save
        format.html { redirect_to @company, notice: 'Company was successfully created.' }
        format.json { render json: @company, status: :created, location: @company }
      else
        format.html { render action: "new" }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /companies/1
  # PUT /companies/1.json
  def update
    @company = current_user.company

    respond_to do |format|
      if @company.update_attributes(params[:company])
        format.html { redirect_to @company, notice: 'Company was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /companies/1
  # DELETE /companies/1.json
  def destroy
    @company = Company.find(params[:id])
    @company.destroy

    respond_to do |format|
      format.html { redirect_to companies_url }
      format.json { head :no_content }
    end
  end
  
  def dashboard
    @user = current_user
    @company = @user.company
    @operator_server = @company.operator_server
    render layout: false
  end
  
  def publish
    response.headers["Expires"] = CGI.rfc1123_date(Time.now + 1.day)
    @company = Company.find_by_apikey params[:id]
    @plugin_combination = @company.plugin_combinations.find_by_name(params[:combination_id])


    @server = VisitorServer.first
    @apikey = @company.apikey
    @uuid   = "znclrk"
    @usid   = "znclrk_us"
    @plugins = @plugin_combination.plugins.map{|plugin| plugin.path }

    render "publish.js.erb"
  end

  def test
    @apikey = params[:id]
    @set    = params[:combination_id]
    render layout: false
  end 
end
