class User < ApplicationRecord
  has_secure_password

  def self.users_by_name(word)
      where("users.name LIKE ?",word)
  end
end
