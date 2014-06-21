require 'rails_helper'

describe Api::ClientsController do
  context "#index" do
    it "returns all clients" do
      2.times { create(:client) }

      get :index

      expect(response.status).to eq(200)
      expect(JSON.parse(response.body).size).to eq(2)
    end
  end

  context "#create" do
    context "valid data" do
      it "creates a new client" do
        post :create, client: { name: "Frank Zappa" }

        json = JSON.parse(response.body)
        expect(response.status).to eq(201)
        expect(json["name"]).to eq("Frank Zappa")
      end
    end

    context "invalid data" do
      it "returns 422 code with errors" do
        post :create, client: { name: "" }

        json = JSON.parse(response.body)
        expect(json).to have_key("errors")
        expect(response.status).to eq(422)
      end
    end
  end

  context "#update" do
    before(:each) do
      @client = create(:client, name: "Frank Zappa")
    end

    context "valid data" do
      it "updates the client" do
        put :update, id: @client.id, client: { name: "Mothers of Invention" }

        expect(response.status).to eq(200)
        expect(Client.first.name).to eq("Mothers of Invention")
      end
    end

    context "invalid data" do
      it "returns 422 code with errors" do
        put :update, id: @client.id, client: { name: "" }

        json = JSON.parse(response.body)
        expect(json).to have_key("errors")
        expect(response.status).to eq(422)
      end

      context "record not found" do
        it "returns 404 code with errors" do
          put :update, id: 222, client: { name: "Bob Plant" }

          json = JSON.parse(response.body)
          expect(json).to have_key("errors")
          expect(response.status).to eq(404)
        end
      end
    end
  end

  context "#delete" do
    context "valid data" do
      it "removes the client" do
        client = create(:client)

        delete :destroy, id: client.id

        expect(response.status).to eq(200)
        expect(Client.all.size).to eq(0)
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