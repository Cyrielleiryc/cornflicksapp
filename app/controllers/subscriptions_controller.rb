class SubscriptionsController < ApplicationController
  def create
    @subscription = Subscription.new(subscription_params)
    authorize @subscription
    @subscription.user = current_user
    @subscription.group = Group.find_by(shareablecode: params[:subscription][:group_shareablecode])
    if @subscription.save!
      redirect_to groups_path
    else
      render 'index'
    end
  end

  def destroy
    @subscription = Subscription.find(params[:id])
    authorize @subscription
    @subscription.destroy
    redirect_to groups_path, status: :see_other
  end

  private

  def subscription_params
    params.require(:subscription).permit(:group_shareablecode)
  end
end
