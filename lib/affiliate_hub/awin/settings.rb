module AffiliateHub
  module Awin
    class Settings
      attr_accessor :api_token, :publisher_id
      attr_writer :base_uri

      def base_uri
        "#{@base_uri}/publishers/#{@publisher_id}"
      end
    end
  end
end
