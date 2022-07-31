class GistService
  attr_accessor :gist, :error

  def view(link)
    find_gist(link)
    "by #{@gist.owner.login}" if @error.nil?
  end

  private

  def find_gist(link)
    gist_id = URI.parse(link).path.split('/').last
    @gist = Octokit.gist(gist_id)
  rescue Octokit::NotFound
    @error = 'Gist not found'
  end
end
