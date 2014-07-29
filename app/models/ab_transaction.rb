class AB_Transaction
  include Mongoid::Document
  include Mongoid::Timestamps

  field :date, type: DateTime
  field :qtd_initiated, type: Integer, default: 0
  field :qtd_open, type: Integer, default: 0
  field :qtd_available, type: Integer, default: 0
  field :qtd_in_analysis, type: Integer, default: 0
  field :qtd_paid, type: Integer, default: 0
  field :qtd_total, type: Integer, default: 0
  field :qtd_cancelled, type: Integer, default: 0
  field :qtd_in_dispute, type: Integer, default: 0
  field :qtd_refunded, type: Integer, default: 0

  def count_statuses(report)
    self.date = Time.now
    while report.next_page?
      report.next_page!
      report.transactions.each do |transaction|

        if transaction.gross_amount % 430.00 == 0
          qtd = transaction.gross_amount / 430.00
        elsif transaction.gross_amount % 380.00 == 0
          qtd = transaction.gross_amount / 380.00
        elsif transaction.gross_amount % 550.00 == 0
          qtd = transaction.gross_amount / 550.00
        elsif transaction.gross_amount % 500.00 == 0
          qtd = transaction.gross_amount / 500.00
        end

        self.qtd_paid += qtd if transaction.status.status == :paid
        self.qtd_cancelled += qtd if transaction.status.status == :cancelled
        self.qtd_open += qtd if transaction.status.status == :waiting_payment
        self.qtd_available += qtd if transaction.status.status == :available
        self.qtd_in_analysis += qtd if transaction.status.status == :in_analysis
        self.qtd_initiated += qtd if transaction.status.status == :initiated
        self.qtd_in_dispute += qtd if transaction.status.status == :in_dispute
        self.qtd_refunded += qtd if transaction.status.status == :refunded
        self.qtd_total += qtd

        qtd = 1
      end
    end
  end
end