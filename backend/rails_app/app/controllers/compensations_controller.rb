class CompensationsController < ApplicationController
    # GET /compensations
    def index
      @compensations = Compensation.all
      render json: @compensations
    end
  
    # GET /compensations/:id
    def show
      @compensation = Compensation.find(params[:id])
      render json: @compensation, include: :vesting_schedules
    end
  
    # POST /compensations
    def create
      @compensation = Compensation.new(compensation_params)
      if @compensation.save
        render json: @compensation, status: :created
      else
        render json: @compensation.errors, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /compensations/:id
    def update
      @compensation = Compensation.find(params[:id])
      if @compensation.update(compensation_params)
        render json: @compensation
      else
        render json: @compensation.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /compensations/:id
    def destroy
      @compensation = Compensation.find(params[:id])
      @compensation.destroy
      head :no_content
    end
  
    private
  
    def compensation_params
      params.require(:compensation).permit(:offer_id, :base_salary, :stock_annual, :bonus, :stock_total)
    end
  end