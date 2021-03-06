module Powerbot
  module Database
    class FeedPost < Sequel::Model
      many_to_one :feed

      def message
        feed.channel.message message_id
      end

      def author
        BOT.user author_id
      end

      def tagline
        "🛰️ #{feed.role.mention} **| #{title}**"
      end

      def update_post
        if message_id
          message.edit "#{tagline} `updated: #{::Time.now.utc}`", parse_content
        else
          feed.role.mentionable = true
          m = feed.channel.send_embed tagline, parse_content
          feed.role.mentionable = false

          update message_id: m.id
        end
      end

      def parse_content
        data = content.split '|'

        fields = data[1..-1].map do |f|
          Discordrb::Webhooks::EmbedField.new(
            name: "\u200b",
            value: f
          )
        end

        Discordrb::Webhooks::Embed.new(
          description: data.first,
          fields: fields,
          color: feed.role.color.combined,
          footer: {
            text: "#{author.distinct} [use 'pal.unsub #{feed.name}' to unsub] | ##{id}",
            icon_url: author.avatar_url
          },
          timestamp: Time.now
        )
      end
    end
  end
end
