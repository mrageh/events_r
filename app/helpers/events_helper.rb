module EventsHelper
  def format_price(event)
    if event.free?
      content_tag(:strong, "Free")
    else
      number_to_currency(event.price)
    end
  end

  def image_for(event)
    if event.image_blank?
      image_tag  "placeholder.png"
    else
      image_tag event.image_file_name
    end
  end

  def like_and_unlike_button
    if current_user
      current_like = current_user.likes.find_by(event: @event)
      if current_like
        button_to 'Unlike',
          event_like_path(@event, current_like), method: :delete
      else
        button_to 'Like',
          event_likes_path(@event)
      end
    end
  end
end
