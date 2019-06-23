# frozen_string_literal: true

require File.expand_path 'spec_helper.rb', __dir__

describe 'My Sinatra Application' do
  it 'should allow accessing the home page' do
    get '/'
    expect(last_response).to be_ok
    expect(last_response.body).to include('Feedback form')
  end
end
