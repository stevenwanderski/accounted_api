describe Payment do
  context "validations" do
    context "payment type inclusion" do
      context "value is in supplied list" do
        it "is valid" do
          p = build(:payment)
          p.payment_type = "revenue"
          expect(p).to be_valid
        end
      end

      context "value is not in supplied list" do
        it "is invalid" do
          p = build(:payment)
          p.payment_type = "foobar"
          expect(p).to be_invalid
        end
      end
    end
  end
end