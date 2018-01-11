require 'omniauth/strategies/oauth2'

module OmniAuth
  module Strategies

    class Donorsearch < OmniAuth::Strategies::OAuth2
      class NoDonorSearchData < StandardError;
      end

      option :name, 'donorsearch'

      option :client_options, {
          :site => "https://id.donorsearch.org",
          :authorize_url => "/oauth/authorize"
      }

      option :redirect_url, nil

      uid {raw_info["id"]}

      info do
        {
            :nickname => raw_info['nickname'],
            :email => raw_info['email'],
            :first_name => raw_info['first_name'],
            :last_name => raw_info['last_name'],
            :avatar => raw_info['avatar'],
            :bdate => raw_info['bdate'],
            :gender => raw_info['gender']
        }
      end

      extra do
        {
            'raw_info' => raw_info
        }
      end

      def raw_info
        result = access_token.get('/api/v1/me.json').parsed

        raise NoRawData, result unless result.is_a?(Hash)
        result
      end

      def callback_url
        options.redirect_url || (full_host + script_name + callback_path)
      end
    end
  end
end
