# frozen_string_literal: true

require 'omniauth/ms365/version'
require 'omniauth'

module OmniAuth
  module Strategies
    class Error < StandardError; end

    autoload :Ms365, 'omniauth/strategies/ms365'
  end
end

OmniAuth.config.add_camelization 'ms365', 'Ms365'
