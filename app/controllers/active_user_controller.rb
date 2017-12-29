class ActiveUserController < ApplicationController
  def home
  	@countElectronic=Admin.where(division:"Electronic").count
  	@countElectrical=Admin.where(division:"Electrical").count
  	@countMechanical=Admin.where(division:"Mechanical").count
    

# finding all the ongoing projects in which current_user is involved 
    users = ProjectUserAdminRelation.where("user_id1=? OR user_id2=? OR user_id3=? OR user_id4=? OR user_id5=?",
      current_user.id,current_user.id,current_user.id,current_user.id,current_user.id)

    s_projectIds = []
    users.each do|project|
      s_projectIds<<project.SelectedProject_id
    end
    
    @selectedProjects=SelectedProject.where(id:s_projectIds)


# finding all the completed projects in which current_user is involved     
    users = CompleteProject.where("user1=? OR user2=? OR user3=? OR user4=? OR user5=?",current_user.id,
      current_user.id,current_user.id,current_user.id,current_user.id)
    
    c_projectIds = []
    users.each do|project|
      c_projectIds<<project.SelectedProject_id
    end

    @completedProjects=SelectedProject.where(id:c_projectIds)


# finding all the tasks in which current_user is involved 
    users = UserTaskRelation.where(user_id:current_user.id)
        
    task_ids = []
    users.each do|t|
      task_ids<<t.task_id
    end
    
    @tasks=Task.where(id:task_ids)


  end

  def facultyIndex
  	@division=params[:division]
	  @faculty=Admin.where(:division=>@division)
  end

  def facultyShow
    @name=params[:name]
	  @faculty=Admin.where(:name=>@name).first    
  end

  def profile
    @user=User.find_by_id(params[:id])
  end

  def edit_profile
  end

  def update_profile
    byebug
  end
end