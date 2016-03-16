class User < ActiveRecord::Base
  require 'stripe'
  Stripe.api_key = "sk_test_F6hkpzgbNpwqPLOAIH22UOZy"
  before_save :encrypt_password
  before_create :set_user_type
  before_create :set_stripe_id
  validates :email, presence: true
  validates :email, uniqueness: true
  attr_accessor :card_number, :exp_month, :exp_year, :cvc
  has_many :charges

  #after_save :clear_password
  def balance #This should really be implemented
    0
  end
  def name
    self.firstName + " " + self.lastName
  end
  def payout_balance #This should unfortunately be implemented
    0
  end
  def payout_total
    0
  end
  def payment_total
    0
  end
  def encrypt_password
    if password.present?
      self.salt = BCrypt::Engine.generate_salt
      self.password_enc= BCrypt::Engine.hash_secret(password, salt)
    end
    self.password = nil
  end
  #def add_card
  def set_stripe_id
    customer = Stripe::Customer.create()
    self.stripe_id = customer.id
  end
  def set_user_type
    if self.userTypeId.nil?
      self.userTypeId = UserType.find_by_description("New User").id
    end
  end
  def add_card(number,month,year,cvc)
    token = Stripe::Token.create(
      :card => {
      :number => number,
      :exp_month => month,
      :exp_year => year,
      :cvc => cvc
      }
    )
    customer = Stripe::Customer.retrieve(self.stripe_id)
    customer.sources.create(source: token) 
  end
  def remove_card(card_id)
    Stripe::Customer.retrieve(self.stripe_id).sources.retrieve(card_id).delete()
  end
  def cards
    Stripe::Customer.retrieve(self.stripe_id).sources.all(object: :card).data
  end
  def set_default_card(card_id)
    customer = Stripe::Customer.retrieve(self.stripe_id)
    customer.default_source = card_id
    customer.save
  end
  def charge(amount)
    amount_cents = (amount*100).to_i
    response = Stripe::Charge.create(
      amount: amount_cents,
      currency: :usd,
      customer: self.stripe_id
    )
    Rails.logger.debug(response)
    self.charges.create({amount: amount, refunded: false, last_four: response.source.last4})
  end
  def clear_password
    self.password = nil
  end
  def is_admin?
    return self.userTypeId == UserType.find_by_description("Admin").id
  end
  def is_client?
    return self.userTypeId == UserType.find_by_description("Client").id
  end
  def is_affiliate?
    return self.userTypeId == UserType.find_by_description("Affiliate").id
  end
  def is_sales_rep?
    return self.userTypeId == UserType.find_by_description("Sales Rep").id
  end
  def is_new_user?
    return self.userTypeId == UserType.find_by_description("New User").id
  end
  def self.authenticate(username_or_email="", login_password="")
    if is_email(username_or_email)
      user = User.find_by_email(username_or_email)
    else
      user = User.find_by_username(username_or_email)
    end
    if user && user.match_password(login_password)
      return user
    else
      return false
    end
  end   
  def match_password(login_password="")
    password_enc == BCrypt::Engine.hash_secret(login_password, salt)
  end
  def self.is_email(email)
    (email =~ /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i)
  end
end
