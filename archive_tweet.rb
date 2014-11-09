#!/usr/bin/env ruby
# encoding: utf-8

require 'tweetstream'
require 'yaml'
require 'date'

begin
    path = File.expand_path(File.dirname(__FILE__))
    SETTINGS = YAML::load(open(path + "/conf/token.conf"))
rescue
    puts "Config file load failed."
    exit
end

TweetStream.configure do |config|
    config.consumer_key = SETTINGS["CONSUMER_KEY"]
    config.consumer_secret = SETTINGS["CONSUMER_SECRET"]
    config.oauth_token = SETTINGS["OAUTH_TOKEN"]
    config.oauth_token_secret = SETTINGS["OAUTH_TOKEN_SECRET"]
    config.auth_method = :oauth
end

tc = Twitter::REST::Client.new do |config|
    config.consumer_key = SETTINGS["CONSUMER_KEY"]
    config.consumer_secret = SETTINGS["CONSUMER_SECRET"]
    config.oauth_token = SETTINGS["OAUTH_TOKEN"]
    config.oauth_token_secret = SETTINGS["OAUTH_TOKEN_SECRET"]
end

client = TweetStream::Client.new
client.userstream do |status|
#    puts status.id
#    puts status.user.screen_name
    #    puts status.user.name
    #    puts status.text
    day = Date.today

    today = day.strftime("%Y%m%d")
    puts today

    name = "#{status.user.screen_name}(#{status.user.name})"
    tweet_url = "https://twitter.com/#{status.user.screen_name}/status/#{status.id}"
    data = "#{name}: #{status.text}\n#{tweet_url}\n\n"
    puts data
    File.open("data_#{today}.txt", 'a') do |file|
        file << data
    end
    #File.write("hoge.txt", data)
end
