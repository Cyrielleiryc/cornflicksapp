class GroupsController < ApplicationController
  def index
    @groups = policy_scope(Group)
  end

  def show
    @group = Group.find(params[:id])
  end
  
  def new
    @group = Group.new
    authorize @group
  end

  def create
    @group = Group.new(group_params)
    @group.creator = current_user
    authorize @group
    if @group.save!
      redirect_to groups_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def group_params
    params.require(:group).permit(:name)
  end
end
