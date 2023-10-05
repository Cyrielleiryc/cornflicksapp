class GroupsController < ApplicationController
  def index
    @groups = policy_scope(Group)
    @subscription = Subscription.new
    @group = Group.new
  end

  def show
    @group = policy_scope(Group).find(params[:id])
    @recommendations = Recommendation.where(group: @group)
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
    params.require(:group).permit(:name, :image_id)
  end
end
