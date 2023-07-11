class TenantsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

    def index
        render json: Tenant.all
    end

    def show
        render json: find_tenant
    end

    def create
        render json: Tenant.create!(tenant_params), status: :created
    end

    def update 
        tenant = find_tenant
        tenant.update!(tenant_params)
        render json: tenant, status: :accepted
    end

    def destroy
        find_tenant.destroy
        head :no_content
    end

    private

    def record_not_found
        render json: { error: 'Tenant not found' }, status: :not_found 
    end

    def record_invalid e 
        render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
    end

    def find_tenant 
        Tenant.find(params[:id])
    end

    def tenant_params
        params.permit(:name, :age)
    end
end
