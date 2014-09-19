require 'rspec_api_documentation/dsl'

resource 'User' do
  post '/api/users/sign_in' do
    header 'Host', 'my-new-app.moku.io'
    header 'Accept', 'application/vnd.my-new-app.v1+json'
    header 'Client-Version', 'Web/1.1'

    example 'Sign-in' do
      request = do_request(:email => @user.email, :password => 'example')
      response = JSON.parse(request.first[:response_body])

      expect(status).to eq(201)
      expect(response['user']['authentication_token']).to eq(@user.authentication_token)
    end

    example 'Sign-in with wrong password' do
      do_request(:email => @user.email, :password => 'wrong')
      expect(status).to eq(401)
    end
  end


  # get '/api/patients' do           # Any controller action that need authentication!
  #   header 'Host', 'my-new-app.moku.io'
  #   header 'Accept', 'application/vnd.my-new-app.v1+json'
  #   header 'Client-Version', 'Web/1.1'
  #
  #   example 'Ask for a restricted resource without login' do
  #     do_request
  #     expect(status).to eq(401)
  #   end
  # end
  #
  #
  # get '/api/patients' do           # Any controller action that need authentication!
  #   header 'Host', 'my-new-app.moku.io'
  #   header 'Accept', 'application/vnd.my-new-app.v1+json'
  #   header 'Client-Version', 'Web/1.1'
  #   header 'X-API-Email', :email
  #   header 'X-API-Token', :token
  #
  #   let(:email) { @user.email }
  #   let(:token) { 'invalidtoken' }
  #
  #   example 'Ask for a restricted resource using an invalid token' do
  #     do_request
  #     expect(status).to eq(401)
  #   end
  # end


  delete '/api/users/sign_out' do
    header 'Host', 'my-new-app.moku.io'
    header 'Accept', 'application/vnd.my-new-app.v1+json'
    header 'Client-Version', 'Web/1.1'
    header 'X-API-Email', :email
    header 'X-API-Token', :token

    let(:email) { @user.email }
    let(:token) { @user.authentication_token }

    example 'Sign-out' do
      do_request
      expect(status).to eq(204)
    end
  end


  # get '/api/users/password/new' do
  #   header 'Host', 'my-new-app.moku.io'
  #     header 'Accept', 'application/vnd.my-new-app.v1+json'
  #     header 'Client-Version', 'Web/1.1'
  #     header 'X-API-Email', :email
  #     header 'X-API-Token', :token
  #
  #     let(:email) { @user.email }
  #     let(:token) { @user.authentication_token }
  #
  #     example '/api/users/password/new' do
  #       do_request
  #       expect(status).to eq(200)
  #     end
  # end


  # post '/api/users/password' do
  #   header 'Host', 'my-new-app.moku.io'
  #   header 'Accept', 'application/vnd.my-new-app.v1+json'
  #   header 'Client-Version', 'Web/1.1'
  #   header 'X-API-Email', :email
  #   header 'X-API-Token', :token
  #
  #   let(:email) { @user.email }
  #   let(:token) { @user.authentication_token }
  #
  #   example 'api/passwords#create' do
  #     do_request
  #     expect(status).to eq(200)
  #   end
  # end
end
