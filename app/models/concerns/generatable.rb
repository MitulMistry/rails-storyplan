module Generatable
  extend ActiveSupport::Concern

  private
  #converts name into snakecase and adds a random number at the end, loops to make sure it's truly unique
  def generate_username_for_oauth(name)
    loop do
      username = name.parameterize.underscore + "_" + SecureRandom.hex(5)
      break username unless User.exists?(username: username)
    end
  end
end
