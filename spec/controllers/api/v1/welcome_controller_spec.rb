require 'spec_helper'

describe Api::V1::WelcomeController do
  describe "GET 'index'" do
    before do
      get 'index'
    end
  
    it { should respond_with(:success) }
  end
end