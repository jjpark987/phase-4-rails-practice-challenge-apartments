class LeasesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

    def create 
        render json: Lease.create(lease_params), status: :created
    end

    def destroy
        Lease.find(params[:id]).destroy
        head :no_content
    end

    private

    def record_not_found
        render json: { error: 'Lease not found' }, status: :not_found
    end

    def lease_params
        params.permit(:rent, :apartment_id, :tenant_id)
    end
end
