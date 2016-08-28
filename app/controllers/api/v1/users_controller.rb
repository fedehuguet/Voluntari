class Api::V1::UsersController < ApplicationController
  respond_to :json

  def index
    respond_with User.all
  end

  def show
    response = []
    user = User.find(params[:id])
    response << user
    user.projects.each do |x|
      response << x
    end
    respond_with response
  end

  def create
   user=User.new(user_params) 
        # if the user is saved successfully than respond with json data and status code 201
        if user.save 
    render json: user, status: 201
   else
    render json: { errors: user.errors}, status: 422
   end
  end

  def update
    user = User.find(params[:id])

    if user.update(user_params)
      render json: user, status: 200
    else
      render json: { errors: user.errors }, status: 422
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    head 204
  end

def add_project_to_user
  user = User.find(params[:id])
  project = Project.find(params[:project_id])
  pj = ProjectUser.find_or_create_by(user: user, project: project)
  render json: pj, status: 200
end

def delete_project_from_user
  user = User.find(params[:id])
  user.projects.delete(Project.find(params[:project_id]))
  render json: user.projects, status: 200
end

  private
  def user_params
   params.require(:user).permit(:email, :password, :password_confirmation) 
  end

end  