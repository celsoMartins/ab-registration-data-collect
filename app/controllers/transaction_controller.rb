class TransactionController < ApplicationController
  def index
    @transactions = AB_Transaction.all
  end
end
