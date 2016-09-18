# Gems
require 'bundler/setup'
require 'discordrb'
require 'yaml'
require 'rufus-scheduler'

# The main bot module.
module Powerbot
  # Load non-Discordrb modules
  Dir['lib/modules/*.rb'].each { |mod| load mod }

  # Bot configuration
  CONFIG = Config.new

  # Event scheduler
  SCHEDULER = Rufus::Scheduler.new

  # Create the bot.
  # The bot is created as a constant, so that you
  # can access the cache anywhere.
  BOT = Discordrb::Commands::CommandBot.new(application_id: CONFIG.app_id,
                                            token: CONFIG.token,
                                            prefix: CONFIG.prefix)

  # Discord commands
  module DiscordCommands; end
  Dir['lib/modules/commands/*.rb'].each { |mod| load mod }
  DiscordCommands.constants.each do |mod|
    BOT.include! DiscordCommands.const_get mod
  end

  # Discord events
  module DiscordEvents; end
  Dir['lib/modules/events/*.rb'].each { |mod| load mod }
  DiscordEvents.constants.each do |mod|
    BOT.include! DiscordEvents.const_get mod
  end

  # Run the bot
  BOT.run
end
