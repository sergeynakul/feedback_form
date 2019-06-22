require 'sinatra'
require 'mail'
require 'net/http'
require 'uri'
require 'json'

Mail.defaults do
  delivery_method :smtp, { :address              => "smtp.gmail.com",
                           :port                 => 587,
                           :domain               => "127.0.0.1",
                           :user_name            => "ror.test.e@gmail.com",
                           :password             => "ror123456789",
                           :authentication       => "plain",
                           :enable_starttls_auto => true  }
end

get '/' do
  erb :index
end

post '/' do
  url = URI.parse("https://www.google.com/recaptcha/api/siteverify")
  req = Net::HTTP::Post.new(url.request_uri)
  req.set_form_data({"secret" => "6LcWA6oUAAAAAKtr61JfTEcMjuB_aL6Nwv2ELVHv", "response" => params[:recaptcha_response]})
  http = Net::HTTP.new(url.host, url.port)
  http.use_ssl = (url.scheme == "https")
  response = http.request(req)
  response_hash = JSON.parse(response.body)
  p response_hash["score"]

  if response_hash["score"] >= 0.5
    email = params[:email]
    message = params[:message]
    Mail.deliver do
      to      'nakul.sv@gmail.com'
      from    email
      subject 'Feedback'
      body    message
    end
  end

  redirect to('/')
end
