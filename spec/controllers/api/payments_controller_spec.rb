describe Api::PaymentsController do
  context "#index" do
    it "returns all payments" do
      2.times { create(:payment) }

      get :index

      expect(response.status).to eq(200)
      expect(JSON.parse(response.body).size).to eq(2)
    end
  end

  context "#create" do
    context "valid data" do
      it "creates a new payment" do
        payment = attributes_for(:payment)
        payment[:client_id] = 1

        post :create, payment: payment
        json = JSON.parse(response.body)

        expect(response.status).to eq(201)
        expect(json["amount_in_cents"]).to eq(payment[:amount_in_cents])
      end
    end

    context "invalid data" do
      it "returns 422 code with errors" do
        post :create, payment: { amount_in_cents: "" }

        json = JSON.parse(response.body)
        expect(json).to have_key("errors")
        expect(response.status).to eq(422)
      end
    end
  end

  context "#show" do
    context "valid data" do
      it "returns the payment" do
        payment = create(:payment)

        get :show, id: payment.id

        json = JSON.parse(response.body)
        expect(response.status).to eq(200)
        expect(json["amount_in_cents"]).to eq(payment.amount_in_cents)
      end
    end

    context "record not found" do
      it "returns 404 code with errors" do
        get :show, id: 222

        json = JSON.parse(response.body)
        expect(json).to have_key("errors")
        expect(response.status).to eq(404)
      end
    end
  end

  context "#update" do
    before(:each) do
      @payment = create(:payment)
    end

    context "valid data" do
      it "updates the payment" do
        put :update, id: @payment.id, payment: { amount_in_cents: 666 }

        expect(response.status).to eq(200)
        expect(Payment.first.amount_in_cents).to eq(666)
      end
    end

    context "invalid data" do
      it "returns 422 code with errors" do
        put :update, id: @payment.id, payment: { amount_in_cents: "" }

        json = JSON.parse(response.body)
        expect(json).to have_key("errors")
        expect(response.status).to eq(422)
      end

      context "record not found" do
        it "returns 404 code with errors" do
          put :update, id: 222, payment: { amount_in_cents: 666 }

          json = JSON.parse(response.body)
          expect(json).to have_key("errors")
          expect(response.status).to eq(404)
        end
      end
    end
  end

  context "#delete" do
    context "valid data" do
      it "removes the payment" do
        payment = create(:payment)

        delete :destroy, id: payment.id

        expect(response.status).to eq(200)
        expect(Payment.all.size).to eq(0)
      end
    end

    context "invalid data" do
      it "returns a 404 status code" do
        delete :destroy, id: 222

        json = JSON.parse(response.body)
        expect(json).to have_key("errors")
        expect(response.status).to eq(404)
      end
    end
  end
end