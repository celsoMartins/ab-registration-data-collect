class TransactionController < ApplicationController
  def index
    @transactions = AB_Transaction.all.desc(:date)
  end
end
