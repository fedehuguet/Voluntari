class Project < ActiveRecord::Base
	belongs_to :organization
	has_many :project_users
  	has_many :users, through: :project_users
end
