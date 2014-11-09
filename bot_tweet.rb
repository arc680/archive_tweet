# encoding: utf-8

class BotTweet
    @@tweet = ""
    def create_simple_tweet(cnt = 5)
        tweet = "( っ'ω'c)"
        keys = ["！", "？"]
        cnt.times do
            tweet = tweet + keys[rand(keys.length)]
        end

        return tweet
    end

    def create_nya_tweet(cnt = 5)
        tweet = "( っ'ω'c)"
        cnt.times do
            tweet = tweet + "にゃ"
        end

        if rand(2) == 1
            tweet = tweet + "ー"
        end

        return tweet
    end
    
    def create_poyo_tweet(cnt = 5)
        tweet = "( っ'ω'c)"
        cnt.times do
            tweet = tweet + "ぽよ"
        end

        if rand(2) == 1
            tweet = tweet + "ー"
        end

        return tweet
    end

    def create_tweet_from_template()
        tweets = Array.new
        open("./template") do |f|
            f.each do |line|
                tweets.push(line)
            end
        end

        return tweets[rand(tweets.size)]
    end

    def create_tweet()
        cnt = rand(5) + 1
        pattern = rand(4)
        if pattern == 0
            @@tweet = create_simple_tweet(cnt)
        elsif pattern == 1
            @@tweet = create_nya_tweet(cnt)
        elsif pattern == 2
            @@tweet = create_poyo_tweet(cnt)
        else 
            @@tweet = create_tweet_from_template() 
        end
    end

    def get_tweet()
        return @@tweet
    end
end

