class ApartmentsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

    def index
        render json: Apartment.all
    end

    def show
        render json: find_apartment
    end

    def create
        render json: Apartment.create(number: params[:number]), status: :created
    end

    def update 
        apartment = find_apartment
        apartment.update(number: params[:number])
        render json: apartment, status: :accepted
    end

    def destroy
        find_apartment.destroy
        head :no_content
    end

    private

    def record_not_found
        render json: { error: 'Apartment not found' }, status: :not_found 
    end

    def find_apartment 
        Apartment.find(params[:id])
    end
end
