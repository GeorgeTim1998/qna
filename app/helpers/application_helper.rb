module ApplicationHelper
  def voting_links(resource)
    if can? :change_rating, resource
      voting(resource)
    elsif can? :cancel, resource
      cancel(resource)
    else
      rating(resource)
    end
  end

  private

  def cancel(resource)
    concat link_to '+', polymorphic_path([:change_rating, resource], point: +1),
                   method: :patch, remote: true, data: { type: :json }, class: 'voting-link hidden'

    rating(resource)

    concat link_to '-', polymorphic_path([:change_rating, resource], point: -1),
                   method: :patch, remote: true, data: { type: :json }, class: 'voting-link hidden'

    concat link_to 'cancel', polymorphic_path([:cancel, resource]),
                   method: :delete, remote: true, data: { type: :json }, class: 'cancel-link'
  end

  def voting(resource)
    concat link_to '+', polymorphic_path([:change_rating, resource], point: +1),
                   method: :patch, remote: true, data: { type: :json }, class: 'voting-link'

    rating(resource)

    concat link_to '-', polymorphic_path([:change_rating, resource], point: -1),
                   method: :patch, remote: true, data: { type: :json }, class: 'voting-link'

    concat link_to 'cancel', polymorphic_path([:cancel, resource]),
                   method: :delete, remote: true, data: { type: :json }, class: 'cancel-link hidden'
  end

  def rating(resource)
    concat content_tag :p, resource.rating, class: 'rating'
  end
end
