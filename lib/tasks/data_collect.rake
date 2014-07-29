namespace :data_collect do

  desc 'Generate AgileBrazil registration report'

  task collect: :environment do

    credential = Credentials.first
    PagSeguro.configure do |config|
      config.token = credential.token
      config.email = credential.email
    end

    report = PagSeguro::Transaction.find_by_date(:starts_at => 30.days.ago, :ends_at => 1.minute.ago)

    transaction_ab = AB_Transaction.new
    transaction_ab.count_statuses report
    transaction_ab.save!

    p 'Report generated'
  end
end
