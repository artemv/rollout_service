module RolloutService
  class API < Grape::API
    version 'v1'
    format :json
    prefix :api

    User = Struct.new(:name, :mail)

    helpers do
      def authenticate!
        tokens = ENV['ALLOWED_TOKENS'].split(',').map {|p| p.split(':')}.to_h
        email = tokens[params[:id_token]]
        unless email
          raise 'Unauthorized user'
        end
        name = email.split('@')[0]

        $current_user = User.new(name, email)

      rescue => e
        error!('401 Unauthorized', 401)
      end
    end

    mount SystemAPI

    resource(:features) { mount FeatureAPI }

  end
end
