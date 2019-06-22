require 'sinatra'
require 'mail'

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

post '/thankyou' do
  email = params[:email]
  body = params[:body]
  Mail.deliver do
    to      'nakul.sv@gmail.com'
    from    email
    subject 'Feedback'
    body    body
  end

  redirect to('/')
end
