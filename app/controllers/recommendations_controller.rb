class RecommendationsController < ApplicationController
  def create
    @recommendation = Recommendation.new(recommendation_params)
    authorize @recommendation
    @recommendation.user = current_user
    if @recommendation.save!
      redirect_to group_path(@recommendation.group_id)
    else
      render "#{@recommendation.media_type}/#{@recommendation.media_id}", status: :unprocessable_entity
    end
  end

  private

  def recommendation_params
    params.require(:recommendation).permit(:group_id, :comment, :media_type, :media_id, :title)
  end
end
