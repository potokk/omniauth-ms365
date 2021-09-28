# frozen_string_literal: true

require 'omniauth'
require 'omniauth/strategies/oauth2'

module OmniAuth
  module Strategies
    class Ms365 < ::OmniAuth::Strategies::OAuth2
      class NoRawData < StandardError; end

      API_VERSION = '2.0'

      DEFAULT_SCOPE = 'openid email profile offline_access user.read mailboxsettings.read'

      option :name, 'ms365'

      option :client_options,
             site: 'https://login.microsoftonline.com',
             token_url: '/common/oauth2/v2.0/token',
             authorize_url: '/common/oauth2/v2.0/authorize'

      option :authorize_options, %i[scope]

      option :redirect_url, nil

      info { raw_info }

      uid { raw_info['id'] }

      private

      def authorize_params
        super.tap do |params|
          params[:scope] = "#{request.params['scope']} #{DEFAULT_SCOPE}"
        end
      end

      def raw_info
        @raw_info ||= access_token.get(current_user_url).parsed
      end

      def callback_url
        options.redirect_url || (full_host + script_name + callback_path)
      end

      def current_user_url
        'https://graph.microsoft.com/v1.0/me?'\
        '$select=displayName,mail,mailboxSettings,userPrincipalName'
      end
    end
  end
end
