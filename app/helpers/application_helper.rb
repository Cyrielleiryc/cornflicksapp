module ApplicationHelper
  def user_avatar(name, **options)
    Initials.svg(name, **options)
  end
  # user_avatar(current_user.name,
  #   colors: 8,    # number of different colors, default: 12
  #   limit: 1,     # maximal initials length, default: 3
  #   shape: :rect, # background shape, default: :circle
  #   size: 96      # SVG height and width in pixel, default: 32
  # )
end
