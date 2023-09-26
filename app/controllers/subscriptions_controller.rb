class SubscriptionsController < ApplicationController
  def index
    @subscriptions = policy_scope(Subscription)
    @subscription = Subscription.new
  end

  def create
    @subscription = Subscription.new(subscription_params)
    authorize @subscription
    @subscription.user = current_user
    @subscription.group = Group.find_by(shareablecode: params[:subscription][:group_shareablecode])
    if @subscription.save!
      redirect_to subscriptions_path
    else
      render 'index'
    end
  end

  def show
    @subscription = policy_scope(Subscription).find(params[:id])
  end

  private

  def subscription_params
    params.require(:subscription).permit(:group_shareablecode)
  end
end
