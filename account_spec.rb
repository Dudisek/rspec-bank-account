require "rspec"

require_relative "account"

describe Account do

  let(:acct_number) {"1234567890"}
  let(:account) {Account.new(acct_number)} 

  describe "#initialize" do
    context "with valid account number" do
      it "initialize starting balance for 0" do
        expect(account.transactions[0]).to eq 0
      end
    end

    context "with invalid account number" do
      it "Raise Invalid account number error" do
        expect {Account.new("123")}.to raise_error InvalidAccountNumberError 
      end
    end
  end

  describe "#transactions" do
    context "transactions is array" do
      it "should save every transactions" do
        account.deposit!(100)
        expect(account.transactions[1]).to eq 100
        account.withdraw!(40)
        expect(account.transactions[2]).to eq -40
      end
    end

    context "if balance less than transactions" do
      it "should raise overdraft error" do
        expect{account.withdraw!(100)}.to raise_error OverdraftError 
      end
    end
  end

  describe "#balance" do
    context "with new account" do
      it "should have starting balace 0" do
        expect(account.balance).to eq 0
      end
    end

    context "after multiple transactions" do
      it "should return actual balance" do
        account.deposit!(100)
        account.withdraw!(20)
        expect(account.balance).to eq (0+100-20)
      end
    end
  end

  describe "#account_number" do
    it "should return last 4 digits" do
      expect(account.acct_number).to eq "******7890"
    end
  end

  describe "deposit!" do
    context "with valid amount" do
      it "returns correct balance" do
        account.deposit!(100)
        expect(account.balance).to eq 100
      end
    end

    context "with negative amount" do
      it "raises Negative Deposit Error" do
        expect{account.deposit!(-100)}.to raise_error NegativeDepositError
      end
    end
  end

  describe "#withdraw!" do
    context "with valid withdraw amount" do
      it "returns balance" do
        account.deposit!(100)
        account.withdraw!(50)
        expect(account.balance).to eq 50
      end
    end
  end
end