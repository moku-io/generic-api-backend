require 'rspec_api_documentation/dsl'

resource 'User' do
  post '/api/auth' do
    header 'Host', 'my-new-app.moku.io'
    header 'Accept', 'application/vnd.my-new-app.v1+json'
    header 'Client-Version', 'Web/1.1'

    example 'Sign-up' do
      do_request(email: 'new_user@domain.com',
                 password: 'exampleexample',
                 password_confirmation: 'exampleexample',
                 confirm_success_url: 'http://my-new-app.moku.io/')

      expect(status).to eq(200)
      expect(User.find_by uid: 'new_user@domain.com').not_to be_nil
    end
  end


  post '/api/auth/sign_in' do
    header 'Host', 'my-new-app.moku.io'
    header 'Accept', 'application/vnd.my-new-app.v1+json'
    header 'Client-Version', 'Web/1.1'

    example 'Sign-in' do
      request = do_request(email: @user.email, password: 'examplepassword123')

      expect(status).to eq(200)
      expect(request.first[:response_headers]['access-token']).not_to be_blank
    end

    example 'Sign-in with wrong password' do
      do_request(email: @user.email, password: 'wrong')
      expect(status).to eq(401)
    end
  end


  # get '/api/patients', :authorized => true do           # Any controller action that need authentication!
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
  # get '/api/patients', :authorized => true do           # Any controller action that need authentication!
  #   header 'Host', 'my-new-app.moku.io'
  #   header 'Accept', 'application/vnd.my-new-app.v1+json'
  #   header 'Client-Version', 'Web/1.1'
  #
  #   let(:email) { @user.email }
  #   let(:token) { 'invalidtoken' }
  #
  #   example 'Ask for a restricted resource using an invalid token' do
  #     header 'access-token', 'invalid'
  #     do_request
  #     expect(status).to eq(401)
  #   end
  # end


  delete '/api/auth/sign_out', :authorized => true  do
    header 'Host', 'my-new-app.moku.io'
    header 'Accept', 'application/vnd.my-new-app.v1+json'
    header 'Client-Version', 'Web/1.1'

    example 'Sign-out' do
      do_request
      expect(status).to eq(200)
    end
  end
end
