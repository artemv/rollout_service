module RolloutService
  class API < Grape::API
    version 'v1'
    format :json
    prefix :api

    User = Struct.new(:name, :mail)

    helpers do
      def authenticate!
        response = HTTParty.post('https://www.googleapis.com/oauth2/v3/tokeninfo',
                                 body: {id_token: params[:id_token]})

        if response.code != 200
          raise "Bad response from server: #{response.inspect}"
        end
        response_body = JSON.parse(response.body)
        puts "response_body: #{response_body.inspect}"

        if $google_oauth_allowed_domain.present? && response_body['hd'] != $google_oauth_allowed_domain
          raise 'Unauthorized user, this domain is not allowed'
        end

        allowed = (ENV['ALLOWED_EMAILS'] || '').split(',')
        if !allowed.empty? && !allowed.include?(response_body['email'])
          puts "#{response_body['email'].inspect} is not allowed (#{allowed.inspect})"
          raise 'Unauthorized user'
        end

        $current_user = User.new(response_body['name'], response_body['email'])
        raise 'Unauthorized user' if $current_user.name.blank? || $current_user.mail.blank?

      rescue => e
        puts "treating error #{e.inspect} as 401"
        error!('401 Unauthorized', 401)
      end
    end

    mount SystemAPI

    resource(:features) { mount FeatureAPI }

  end
end
