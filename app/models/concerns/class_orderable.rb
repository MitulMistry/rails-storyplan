module ClassOrderable
  extend ActiveSupport::Concern

  def ordered
    order(created_at: :desc)
  end

  def randomized(count)
    order("RANDOM()").first(count)
  end
end
