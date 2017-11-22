require 'omniauth/strategies/oauth2'

module OmniAuth
  module Strategies
    class PaypalRest < OmniAuth::Strategies::OAuth2
      option :name, "paypal_rest"

      option :client_options, {
          :site          => 'https://www.paypal.com',
          :authorize_url => '/signin/authorize',
          :token_url     => '/v1/oauth2/token'
      }

      uid{ raw_info['user_id'] }

      info do
        {
            :email => raw_info['email'],
        }
      end

      extra do
        {
            'raw_info' => raw_info
        }
      end

      def raw_info
        @raw_info ||= access_token.get('/v1/identity/openidconnect/userinfo').parsed
      end
    end
  end
end