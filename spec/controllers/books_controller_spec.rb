require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  let(:valid_attributes) {
    { title: 'Sample Book', author: 'John Doe', description: 'Lorem ipsum dolor sit amet.' }
  }

  describe "GET #index" do
    it "returns a success response" do
      book = Book.create! valid_attributes
      get :index, params: {}
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      book = Book.create! valid_attributes
      get :show, params: { id: book.to_param }
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Book" do
        expect {
          post :create, params: { book: valid_attributes }
        }.to change(Book, :count).by(1)
      end

      it "renders a JSON response with the new book" do
        post :create, params: { book: valid_attributes }
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(/^application\/json(; charset=utf-8)?$/)
      end
    end
  end

  describe "PUT #update" do
    let(:new_attributes) {
      { title: 'Updated Title' }
    }

    context "with valid params" do
      it "updates the requested book" do
        book = Book.create! valid_attributes
        put :update, params: { id: book.to_param, book: new_attributes }
        book.reload
        expect(book.title).to eq('Updated Title')
      end

      it "renders a JSON response with the book" do
        book = Book.create! valid_attributes
        put :update, params: { id: book.to_param, book: valid_attributes }
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(/^application\/json(; charset=utf-8)?$/)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested book" do
      book = Book.create! valid_attributes
      expect {
        delete :destroy, params: { id: book.to_param }
      }.to change(Book, :count).by(-1)
    end
  end

end
