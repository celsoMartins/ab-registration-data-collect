namespace :data_collect do

  desc 'Generate AgileBrazil registration report'

  task collect: :environment do

    # credential = Credentials.first
    PagSeguro.configure do |config|
      # config.token = credential.token
      # config.email = credential.email

      config.token = 'DC87C64A965F4F008902F721E050F32E'
      config.email = 'alexandra.martins@agilealliance.org'
    end

    report = PagSeguro::Transaction.find_by_date(:starts_at => 30.days.ago, :ends_at => Time.now)

    count_paid = 0; count_total = 0; count_cancelled = 0; count_waiting_payment = 0; count_available = 0; count_in_analysis = 0; qtd = 1
    count_initiated = 0; count_in_dispute = 0; count_refunded = 0;
    while report.next_page?
      report.next_page!
      p report.transactions.count
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

        count_paid += qtd if transaction.status.status == :paid
        count_cancelled += qtd if transaction.status.status == :cancelled
        count_waiting_payment += qtd if transaction.status.status == :waiting_payment
        count_available += qtd if transaction.status.status == :available
        count_in_analysis += qtd if transaction.status.status == :in_analysis
        count_initiated += qtd if transaction.status.status == :initiated
        count_in_dispute += qtd if transaction.status.status == :in_dispute
        count_refunded += qtd if transaction.status.status == :refunded
        count_total += qtd

        qtd = 1
      end
    end

    transaction_ab = AB_Transaction.new
    transaction_ab.date = Time.now
    transaction_ab.qtd_initiated = count_initiated
    transaction_ab.qtd_open = count_waiting_payment
    transaction_ab.qtd_paid = count_paid
    transaction_ab.qtd_available = count_available
    transaction_ab.qtd_in_analysis = count_in_analysis
    transaction_ab.qtd_total = count_total
    transaction_ab.qtd_cancelled = count_cancelled
    transaction_ab.qtd_in_dispute = count_in_dispute
    transaction_ab.qtd_refunded = count_refunded
    transaction_ab.save!

    p 'Report generated'
  end
end
