module TranslatorManager
  module SystemHelper
    def internet_connection?
      require 'resolv'

      begin
        # the first domain name ever. Will probably not be removed ever.
        Resolv::DNS.new.getaddress('symbolics.com')
        true
      rescue Resolv::ResolvError => e
        false
      end
    end
    module_function :internet_connection?
  end
end
