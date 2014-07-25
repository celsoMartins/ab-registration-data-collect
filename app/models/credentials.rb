class Credentials
  include Mongoid::Document

  field :email, type: String
  field :token, type: String
end