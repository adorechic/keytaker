require "keytaker/version"
require "thor"
require "keychain"
require "peco_selector"

module Keytaker
  SERVICE_NAME = 'ruby-keytaker'

  class CLI < Thor
    desc "take", "Take a key"
    def take
      accounts = Keychain.generic_passwords.where(service: SERVICE_NAME).all.map(&:account)
      unless accounts.empty?
        key, _ = *PecoSelector.select_from(accounts)
        item = Keychain.generic_passwords.where(service: SERVICE_NAME, account: key).first
        IO.popen('pbcopy', 'w') do |f|
          f << item.password
        end
      end
    end

    desc "set [key name]", "Set a value"
    def set(key)
      value = Readline.readline("value: ")
      item = Keychain.generic_passwords.where(service: SERVICE_NAME, account: key).first

      if item
        item.password = value
        item.save!
      else
        Keychain.generic_passwords.create(service: SERVICE_NAME, account: key, password: value)
      end
    end

    desc "delete [key name]", "Delete a value"
    def delete
      accounts = Keychain.generic_passwords.where(service: SERVICE_NAME).all.map(&:account)
      unless accounts.empty?
        key, _ = *PecoSelector.select_from(accounts)
        item = Keychain.generic_passwords.where(service: SERVICE_NAME, account: key).first
        item.delete
      end
    end
  end
end
