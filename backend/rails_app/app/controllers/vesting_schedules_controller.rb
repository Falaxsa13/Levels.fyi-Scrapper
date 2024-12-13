class VestingSchedulesController < ApplicationController
    # GET /vesting_schedules
    def index
      @vesting_schedules = VestingSchedule.all
      render json: @vesting_schedules
    end
  
    # GET /vesting_schedules/:id
    def show
      @vesting_schedule = VestingSchedule.find(params[:id])
      render json: @vesting_schedule
    end
  
    # POST /vesting_schedules
    def create
      @compensation = Compensation.find(params[:compensation_id])
      @vesting_schedule = @compensation.vesting_schedules.build(vesting_schedule_params)      
      if @vesting_schedule.save
        render json: @vesting_schedule, status: :created
      else
        render json: @vesting_schedule.errors, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /vesting_schedules/:id
    def update
      @vesting_schedule = VestingSchedule.find(params[:id])
      if @vesting_schedule.update(vesting_schedule_params)
        render json: @vesting_schedule
      else
        render json: @vesting_schedule.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /vesting_schedules/:id
    def destroy
      @vesting_schedule = VestingSchedule.find(params[:id])
      @vesting_schedule.destroy
      head :no_content
    end
  
    private
  
    def vesting_schedule_params
      params.require(:vesting_schedule).permit(:compensation_id, :year, :amount, :percentage)
    end
  end