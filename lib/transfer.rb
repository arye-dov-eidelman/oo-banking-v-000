class Transfer
  attr_accessor :status, :amount
  attr_reader :sender, :receiver

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @status = "pending"
    @amount = amount
  end

  def valid?
    if @sender.valid? && @receiver.valid? && @sender.balance >= @amount
      true
    else
      @status = "rejected"
      false
    end
  end

  def execute_transaction
    valid? ? nil : (return "Transaction rejected. Please check your account balance.")
    return if @status == "complete"
    @sender.balance -= @amount
    @receiver.balance += @amount
    @status = "complete"
  end

  def reverse_transfer
    return if @status != "complete"
    @sender.balance += @amount
    @receiver.balance -= @amount
    @status = "reversed"
  end
end
