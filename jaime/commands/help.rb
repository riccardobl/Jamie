module Jaime
    module Commands
        class Help < SlackRubyBot::Commands::Base
            command 'help' do |client, data, _match|
                if (_match["expression"] != nil) then
                    Jaime::Util::replyByWhisper(client, data, getHelp(_match["expression"]), true);
                else
                    Jaime::Util::replyByWhisper(client, data, Jaime::HELP, true);
                end
            end
    
            def self.getHelp(topic)
                if topic == 'vault' then
                    return "Vault help building is currenlty in Progress..."
                else
                    return "Topic `#{topic}` not found."
                end
            end
        end
        class SDK < SlackRubyBot::Commands::Base
            command 'sdk' do |client, data, _match|
                if (_match["expression"] == "download stats") then
                    stats = Jaime::Util::getJSONAPI("https://api.github.com/repos/jmonkeyengine/sdk/releases/latest");
                    str = "<@#{data.user}>: `#{stats['tag_name']}`\n```";
                    stats["assets"].each do |s|
                        str = "#{str}\n#{s['name']} => #{s['download_count']}"
                    end
                    str = "#{str}\n```";

                    client.say(channel: data.channel, text: str);
                else
                    client.say(channel: data.channel, text: "<@#{data.user}>: Watcha sayin' he? I dunno wat ye want!");
                end
            end
        end
        class Default < SlackRubyBot::Commands::Base
            match(/^(?<bot>\w*)$/) do |client, data, _match|
                client.say(channel: data.channel, text: Jaime::ABOUT)
            end
            match (/:glitch_crab:/) do |client, data, _match|
                client.say(channel: data.channel, text: "Glitch Crabs taking over!! :glitch_crab: :glitch_crab: :glitch_crab:")
            end
            match (/googl(e|ing) "(.*)"/) do |client, data, _match|
                client.say(channel: data.channel, text: "http://www.google.com/search?q=" + URI.escape(_match[2].gsub(/\s/, '+')));
            end
#match(/^(?<bot>\S*)[\s]*(?<expression>.*)$/) do |client, data, _match|
#               client.say(channel: data.channel, text: "Sorry <@#{data.user}>, I don't understand that command!")
#           end
        end
    end
end