class Api::V1::OrganizationsController < ApplicationController
	respond_to :json

  def show
    response = []
    organization = Organization.find(params[:id])
    response << organization
    organization.projects.each do |x|
      response << x
    end
    respond_with response
  end

  def create
   organization=Organization.new(organization_params) 
        # if the organization is saved successfully than respond with json data and status code 201
        if organization.save 
    render json: organization, status: 201
   else
    render json: { errors: organization.errors}, status: 422
   end
  end

  def update
    organization = Organization.find(params[:id])

    if organization.update(organization_params)
      render json: organization, status: 200
    else
      render json: { errors: organization.errors }, status: 422
    end
  end

  def destroy
    organization = Organization.find(params[:id])
    organization.destroy
    head 204
  end

  private
  def organization_params
   params.require(:organization).permit(:name, :description, :location)
  end
end
