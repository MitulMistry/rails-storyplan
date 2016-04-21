module Orderable
  extend ActiveSupport::Concern

  def ordered_stories
    self.stories.order(created_at: :desc)
  end
end
