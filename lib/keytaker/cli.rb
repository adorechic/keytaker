require "thor"
require 'readline'

module Keytaker
  class CLI < Thor
    default_command :take

    desc "take", "Take a key"
    def take
      Keytaker::Item.select&.copy
    end

    desc "set [key name]", "Set a value"
    def set(key)
      value = Readline.readline("value: ")
      item = Keytaker::Item.find(key)

      if item
        item.update(value: value)
      else
        Keytaker::Item.create(key: key, value: value)
      end
    end

    desc "delete [key name]", "Delete a value"
    def delete
      Keytaker::Item.select&.delete
    end
  end
end
