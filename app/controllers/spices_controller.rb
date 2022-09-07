class SpicesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :spice_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :spice_invalid
    
    
    def index
      spices = Spice.all
      render json: spices, status: :ok
    end

    def create
        spices = Spice.create!(spice_params)
        render json: spices, status: :created
    end

    def update
        spices = find_spice
        spices.update!(spice_params)
        render json: spices, status: :accepted
    end

    def destroy
        spices = find_spice
        spices.destroy!
        head :no_content
    end

    private

    def spice_not_found
        render json: {error: "Spice not found"}, status: :not_found
    end

    def spice_invalid
        render json: {error: "Spice invalid"}, status: :invalid
    end

    def find_spice
        Spice.find(params[:id])
    end

    def spice_params
        params.permit(:title, :image, :description, :notes, :rating)
    end

end
