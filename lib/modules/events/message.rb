module Powerbot
  module DiscordEvents
    # This event is processed when the bot recieves a message.
    module Message
      extend Discordrb::EventContainer
      message do |event|
#        server_id = event.server.nil? ? 0 : event.server.id
#        server_name = event.server.nil? ? 'pm' : event.server.name
#        attachment = event.message.attachments.first
#        attachment_url = attachment.url unless attachment.nil?
#        begin
#          Database::Message.create(
#            server_id: server_id,
#            server_name: server_name,
#            channel_id: event.channel.id,
#            channel_name: event.channel.name,
#            user_id: event.user.id,
#            user_name: event.user.distinct,
#            message_id: event.message.id,
#            message_content: event.message.content,
#            attachment_url: attachment_url
#          )
#        rescue
#          Discordrb::LOGGER.info 'database busy, waiting..'
#          sleep 1
#          retry
#        end
      end
    end
  end
end
