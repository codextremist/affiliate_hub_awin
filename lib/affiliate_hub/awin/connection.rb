module AffiliateHub
  module Awin
    class Connection < AffiliateHub::Connection

      def_endpoint :programmes,         "programmes",       class: :Base
      def_endpoint :programmedetails,   "programmedetails", class: :Base
      def_endpoint :transactions,       "transactions",     class: :Base

      def initialize(settings)
        @settings = settings
      end

    end
  end
end
