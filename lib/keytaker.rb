require "keytaker/version"
require "thor"

module Keytaker
  class CLI < Thor
    desc "take", "Take a key"
    def take
    end

    desc "set [key name]", "Set a value"
    def set(name)
    end
  end
end
