class RolesController < ApplicationController
    # GET /roles
    def index
      @roles = Role.all
      render json: @roles
    end
  
    # GET /roles/:id
    def show
      @role = Role.find(params[:id])
      render json: @role, include: :offers
    end
  
    # POST /roles
    def create
        @company = Company.find(params[:company_id])
        @role = @company.roles.build(role_params) # Associates the role with the company
    
        if @role.save
          render json: @role, status: :created
        else
          render json: @role.errors, status: :unprocessable_entity
        end
      end
    
      private
    
    def role_params
        params.require(:role).permit(:title, :level, :tag)
    end
  
    # PATCH/PUT /roles/:id
    def update
      @role = Role.find(params[:id])
      if @role.update(role_params)
        render json: @role
      else
        render json: @role.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /roles/:id
    def destroy
      @role = Role.find(params[:id])
      @role.destroy
      head :no_content
    end
  
    private
  
    def role_params
      params.require(:role).permit(:company_id, :title, :level, :tag)
    end
  end