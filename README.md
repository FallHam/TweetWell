#Summary:
TweetWell is an app that uses two different APIs, to gauge the sentiment of users regarding a specific search term that you can provide. This information returns a list of 10 recent tweets in JSON format based off the interaction of the two APIs.

#How to Use TweetWell:
- Access Twitter's API by using your Twitter login to tap into their application management system.

- When registered, you will be provided with:
  -  a consumer key
  -  a consumer secret key
  -  an access token
  -  an access token secret


- Run "atom .profile" from your terminal and include the keys and tokens provided by Twitter in the file.

- Once this information has been saved, you will be able to run TweetWell.

- Start your local server with the command "rails s" in your terminal.

- From localhoust:3000, update the end of the url address to reflect your search term.

- You can search by a specific hashtag by using "#yourserachterm" or a unique user by "@username".
