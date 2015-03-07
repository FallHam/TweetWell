#Summary:
TweetWell is an app that uses two different APIs, to gauge the sentiment of users while considering the current weather conditions of their location. This information returns a list of 200 random recent tweets in JSON format based off the interaction of the two APIs.

#How to Use TweetWell:

- Visit https://tweetwell.herokuapp.com/conditions/{StateCode}/{City}

- You must replace {StateCode} with your specific 2 letter state code and {City} with your city name.

- If there are spaces in the city name, use an underscore ("_") between the words.

- When you run the code, you will get information about the weather conditions, the number of tweets interpreted as either positive and negative from a sample of 200 tweets along with an average confidence score for both positive and negative tweets.

- TweetWell is set to consider tweets made from 100 miles of the location you specify.

- Because some tweets are difficult to gauge as being either positive or negative, we have omitted tweets with confidents levels of lower than 65.
