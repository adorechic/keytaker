require "keychain"
require "peco_selector"

module Keytaker
  class Item
    SERVICE_NAME = 'ruby-keytaker'

    class << self
      def find(key)
        item = Keychain.generic_passwords.where(service: SERVICE_NAME, account: key).first
        item ? new(item) : nil
      end

      def select
        accounts = Keychain.generic_passwords.where(service: SERVICE_NAME).all.map(&:account)
        if accounts.empty?
          nil
        else
          key, _ = *PecoSelector.select_from(accounts)
          Keytaker::Item.find(key)
        end
      end

      def create(key:, value:)
        Keychain.generic_passwords.create(service: SERVICE_NAME, account: key, password: value)
      end
    end

    def initialize(item)
      @item = item
    end

    def copy
      IO.popen('pbcopy', 'w') do |f|
        f << @item.password
      end
    end

    def update(value:)
      @item.password = value
      @item.save!
    end

    def delete
      @item.delete
    end
  end
end
