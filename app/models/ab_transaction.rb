class AB_Transaction
  include Mongoid::Document
  include Mongoid::Timestamps

  field :date, type: DateTime
  field :qtd_initiated, type: Integer
  field :qtd_open, type: Integer
  field :qtd_available, type: Integer
  field :qtd_in_analysis, type: Integer
  field :qtd_paid, type: Integer
  field :qtd_total, type: Integer
  field :qtd_cancelled, type: Integer
  field :qtd_in_dispute, type: Integer
  field :qtd_refunded, type: Integer
end