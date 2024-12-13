class OffersController < ApplicationController
    # GET /offers
    def index
      @offers = Offer.all
      render json: @offers
    end
  
    # GET /offers/:id
    def show
      @offer = Offer.find(params[:id])
      render json: @offer, include: :compensation
    end
  
    # POST /offers
    def create
        @role = Role.find(params[:role_id])
        @offer = @role.offers.build(offer_params)
    
        if @offer.save
          render json: @offer, status: :created
        else
          render json: @offer.errors, status: :unprocessable_entity
        end
      end
    
      private
    
    def offer_params
        params.require(:offer).permit(:location, :employment_type, :work_mode, :years_at_company, :years_of_experience)
    end
      
    # PATCH/PUT /offers/:id
    def update
      @offer = Offer.find(params[:id])
      if @offer.update(offer_params)
        render json: @offer
      else
        render json: @offer.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /offers/:id
    def destroy
      @offer = Offer.find(params[:id])
      @offer.destroy
      head :no_content
    end
  
    private
  
    def offer_params
      params.require(:offer).permit(:role_id, :location, :employment_type, :work_mode, :years_at_company, :years_of_experience)
    end
  end