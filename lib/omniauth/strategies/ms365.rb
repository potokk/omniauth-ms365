# frozen_string_literal: true

require 'omniauth'
require 'omniauth/strategies/oauth2'

module OmniAuth
  module Strategies
    class Ms365 < ::OmniAuth::Strategies::OAuth2
      class NoRawData < StandardError; end

      API_VERSION = '2.0'

      DEFAULT_SCOPE = ''

      option :name, 'ms365'

      option :client_options,
             site: 'https://www.microsoft.com/',
             token_url: 'https://login.microsoftonline.com/common/oauth2/v2.0/token',
             authorize_url: 'https://login.microsoftonline.com/common/oauth2/v2.0/authorize'

      option :authorize_options, %i[scope display]

      option :redirect_url, nil

      private

      def callback_url
        options.redirect_url || (full_host + script_name + callback_path)
      end
    end
  end
end
