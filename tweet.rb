#!/usr/bin/env ruby
# encoding: utf-8

require 'tweetstream'
require 'yaml'
require '~/crow_0096_bot/bot_tweet'

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

tweet_prefix = "( っ'ω'c)"

if ARGV.length == 0
    bot_tweet = BotTweet.new
    bot_tweet.create_tweet
    #tweet = tweet_prefix + bot_tweet.get_tweet
    tweet = bot_tweet.get_tweet
else
    tweet = tweet_prefix + ARGV[0];
end

if tweet.length > 140
    tweet = tweet[0..139]
end

puts tweet
tc.update(tweet);
