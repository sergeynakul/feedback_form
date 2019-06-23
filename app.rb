# frozen_string_literal: true

require 'dotenv/load'
require 'sinatra'
require 'mail'
require 'net/http'
require 'uri'
require 'json'

Mail.defaults do
  delivery_method :smtp, address: 'smtp.gmail.com',
                         port: 587,
                         domain: '127.0.0.1',
                         user_name: 'ror.test.e@gmail.com',
                         password: ENV['PASSWORD'],
                         authentication: 'plain',
                         enable_starttls_auto: true
end

get '/' do
  erb :index
end

post '/' do
  url = URI.parse('https://www.google.com/recaptcha/api/siteverify')
  req = Net::HTTP::Post.new(url.request_uri)
  req.set_form_data('secret' => ENV['SECRET_KEY'], 'response' => params[:recaptcha_response])
  http = Net::HTTP.new(url.host, url.port)
  http.use_ssl = (url.scheme == 'https')
  response = http.request(req)
  response_hash = JSON.parse(response.body)

  if response_hash['score'] >= 0.5
    message = "Name: #{params[:name]}.\nEmail: #{params[:email]}.\nMessage: #{params[:message]}"
    Mail.deliver do
      to      'ror.test.e@gmail.com'
      from    'ror.test.e@gmail.com'
      subject 'Feedback'
      body    message
    end
  end

  redirect to('/')
end
