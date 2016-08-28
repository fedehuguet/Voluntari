class Api::V1::ProjectsController < ApplicationController
	respond_to :json

  def index
    respond_with Project.all
  end

  def show
    response = []
    project = Project.find(params[:id])
    response << project.organization
    response << project
    project.users.each do |x|
      response << x
    end
    respond_with response
  end

  def create
   organization = Organization.find_by(name: organization_params[:name])
   project= organization.projects.new(project_params) 
        # if the project is saved successfully than respond with json data and status code 201
        if project.save 
    render json: project, status: 201
   else
    render json: { errors: project.errors}, status: 422
   end
  end

  def update
    project = Project.find(params[:id])

    if project.update(project_params)
      render json: project, status: 200
    else
      render json: { errors: project.errors }, status: 422
    end
  end

  def destroy
    project = Project.find(params[:id])
    project.destroy
    head 204
  end

def add_user_to_project
  project = Project.find(params[:id])
  user = User.find(params[:user_id])
  pj = ProjectUser.find_or_create_by(user: user, project: project)
  render json: pj, status: 200
end

def delete_user_from_project
  project = Project.find(params[:id])
  project.users.delete(User.find(params[:user_id]))
end

#def project_belongs
  #project = Project.find(params[:id])
  #organization = Organization.find(params[:organization_id])
  #project.organization = organization
#end

  private
  def project_params
   params.require(:project).permit(:name, :capacity, :description, :date, :free_spaces, :money_donated, :categories, :place)
  end
  def organization_params
    params.require(:organization).permit(:name)
  end
end