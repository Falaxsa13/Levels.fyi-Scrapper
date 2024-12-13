class CompaniesController < ApplicationController
    # GET /companies
    def index
      @companies = Company.all
      render json: @companies
    end
  
    # GET /companies/:id
    def show
      @company = Company.includes(:roles).find(params[:id])
      render json: @company, include: :roles
    end
  
    # POST /companies
    def create
      @company = Company.new(company_params)
      if @company.save
        render json: @company, status: :created
      else
        render json: @company.errors, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /companies/:id
    def update
      @company = Company.find(params[:id])
      if @company.update(company_params)
        render json: @company
      else
        render json: @company.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /companies/:id
    def destroy
      @company = Company.find(params[:id])
      @company.destroy
      head :no_content
    end
  
    private
  
    def company_params
      params.require(:company).permit(:name, :website, :year_founded, :num_employees, :estimated_revenue, :description)
    end
  end