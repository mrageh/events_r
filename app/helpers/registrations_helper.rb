module RegistrationsHelper
  def register_link(event)
    if event.sold_out?
      content_tag :p, "Sold out", class: "strong"
    else
     link_to "Register!", new_event_registration_path(event), class: "button ok register" 
    end
  end
end
