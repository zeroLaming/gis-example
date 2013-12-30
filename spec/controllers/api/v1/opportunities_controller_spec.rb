require 'spec_helper'

describe Api::V1::OpportunitiesController do
  describe "GET 'index'" do
    before do
      get 'index'
    end
  
    it { should respond_with(:success) }
  end
  
  describe "GET 'show'" do
    before do
      @opportunity = FactoryGirl.create(:opportunity)
      get 'show', id: @opportunity.id
    end
  
    it { should respond_with(:success) }
  end
  
  describe "POST 'create'" do
    before do
      post 'create', opportunity: { title: "Testing title", summary: "Testing summary" }
    end
      
    it { should respond_with(:success) }
  end
  
  describe "PUT 'update'" do
    before do
      @opportunity = FactoryGirl.create(:opportunity)
      put 'update', id: @opportunity.id, opportunity: { title: "Updated title", summary: "Updated summary" }
    end
      
    it { should respond_with(:success) }
  end
  
  describe "PATCH 'update'" do
    before do
      @opportunity = FactoryGirl.create(:opportunity)
      patch 'update', id: @opportunity.id, opportunity: { title: "Updated title", summary: "Updated summary" }
    end
      
    it { should respond_with(:success) }
  end
  
  describe "DELETE 'destroy'" do
    before do
      @opportunity = FactoryGirl.create(:opportunity)
      delete 'destroy', id: @opportunity.id
    end
      
    it { should respond_with(:success) }
  end
end