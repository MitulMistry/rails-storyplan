module ClassOrderable
  extend ActiveSupport::Concern

  def ordered
    order(created_at: :desc)
  end

  def randomized(count)
    order(Arel.sql("RANDOM()")).first(count)
  end
end
