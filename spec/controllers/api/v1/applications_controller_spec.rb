require 'spec_helper'

describe Api::V1::ApplicationsController do
  
  before do
    @opportunity = FactoryGirl.create(:opportunity)
  end
  
  describe "GET 'index'" do
    before do
      get 'index', opportunity_id: @opportunity.id
    end
  
    it { should respond_with(:success) }
  end
  
  describe "GET 'show'" do
    before do
      @application = FactoryGirl.create(:application)
      get 'show', opportunity_id: @application.opportunity.id, id: @application.id
    end
  
    it { should respond_with(:success) }
  end
  
  describe "POST 'create'" do
    before do
      @person = FactoryGirl.create(:person)
      post 'create', opportunity_id: @opportunity.id, application: { state: 'pending', person_id: @person.id, opportunity_id: @opportunity.id }
    end
      
    it { should respond_with(:success) }
  end
  
  describe "PUT 'update'" do
    before do
      @application = FactoryGirl.create(:application)
      put 'update', opportunity_id: @application.opportunity.id, id: @application.id, application: { state: "approved" }
    end
      
    it { should respond_with(:success) }
  end
  
  describe "PATCH 'update'" do
    before do
      @application = FactoryGirl.create(:application)
      patch 'update', opportunity_id: @application.opportunity.id, id: @application.id, application: { state: "approved" }
    end
      
    it { should respond_with(:success) }
  end
  
  describe "DELETE 'destroy'" do
    before do
      @application = FactoryGirl.create(:application)
      delete 'destroy', opportunity_id: @application.opportunity.id, id: @application.id
    end
      
    it { should respond_with(:success) }
  end
end