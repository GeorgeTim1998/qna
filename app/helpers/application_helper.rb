module ApplicationHelper
  def voting_links(resource)
    if current_user&.author_of?(resource)
      concat content_tag :p, resource.rating, class: 'rating'
    elsif current_user&.voted_for?(resource)
      cancel(resource)
    else
      voting(resource)
    end
  end

  private

  def cancel(resource)
    concat link_to '+', polymorphic_path([:change_rating, resource], point: +1),
                   method: :patch, remote: true, data: { type: :json }, class: 'voting-link hidden'

    concat content_tag :p, resource.rating, class: 'rating'

    concat link_to '-', polymorphic_path([:change_rating, resource], point: -1),
                   method: :patch, remote: true, data: { type: :json }, class: 'voting-link hidden'

    concat link_to 'cancel', polymorphic_path([:cancel, resource]),
                   method: :delete, remote: true, data: { type: :json }, class: 'cancel-link'
  end

  def voting(resource)
    # byebug
    concat link_to '+', polymorphic_path([:change_rating, resource], point: +1),
                   method: :patch, remote: true, data: { type: :json }, class: 'voting-link'

    concat content_tag :p, resource.rating, class: 'rating'

    concat link_to '-', polymorphic_path([:change_rating, resource], point: -1),
                   method: :patch, remote: true, data: { type: :json }, class: 'voting-link'

    concat link_to 'cancel', polymorphic_path([:cancel, resource]),
                   method: :delete, remote: true, data: { type: :json }, class: 'cancel-link hidden'
  end
end
