module ClassOrderable
  extend ActiveSupport::Concern

  def ordered
    order(created_at: :desc)
  end
end
