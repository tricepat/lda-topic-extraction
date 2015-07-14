# Latent Dirichlet Allocation 
This implementation demonstrates how Latent Dirichlet Allocation (LDA) can be used to identify topics in instances of text. 

Latent Dirichlet Allocation is a generative topic model that explains similarities in a set of observations by revealing underlying topics that contribute to each observation. Each topic is a multinomial distribution of words in a dictionary of specified size and vocabulary. The model assumes that each observation is composed of a distribution of the topics.

# How can it benefit Homepolish?

A new Homepolish user is matched with a designer based on a user-input body of text that describes project needs and the intended space. To facilitate more efficient matching, LDA can be run on these project descriptions to identify underlying "topics" such as "Bohemian," "small space," "feminine," and "budget." The automation of this process helps the Queen Bees identify the right designer.

# Implementation

In the absence of access to the Homepolish dataset, I used Yelp restaurant reviews from the greater Phoenix, AZ metropolitan area from a publicly released JSON dataset. Each element contains the following fields: "votes," "user_id," "review_id," "stars," "date," "text," "type," and "business_id." The implementation extracts the "text" field, just as an implementation on a Homepolish dataset would extract the "description" field of the new  project request process.

In this implementation, the vocabulary is composed of words in the reviews. Each review represents a document and each document has a specific distribution of topics. Each word in a document is then a result of this distribution. The LDA model is used over the Yelp restaurant reviews to identify topics and topic distributions.

Running "extract_topics.rb" with 1) a non-zero positive integer that specifies the number of topics to identify, 2) the filename of the input data, and 3) the filename of the topics output creates an LDA model based on the input data (which should be in the data directory) and outputs a file containing the top x words (specified by a constant in the script) in each numbered topic cluster. Based on these words, we can map each topic number to a label such as "Rustic," so that when the model is used on new text (testing data) the topic can be identified. Please keep in mind that the LDA model does take some time to build.

# Results
"topics.txt" contains the results of running the algorithm on eight topics with a dataset "reviews_training.json," which has 12,023 entries. Below are the contents, with my tentative labels for each topic.

Topic 0 (Asian)
	chicken, sushi, rice, thai, lunch

Topic 1 (Service)
	service, order, minutes, table, ordered

Topic 2 (American)
	burger, fries, burgers, bbq, sauce

Topic 3 (Mexican)
	breakfast, mexican, tacos, salsa, chips

Topic 4 (Italian)
	pizza, sauce, crust, fresh, italian

Topic 5 (Wine)
	wine, service, menu, dinner, ordered

Topic 6 (Happy hour)
	bar, happy, hour, beer, service

Topic 7 (Lunch)
	sandwich, salad, chicken, cheese, lunch

These particular results demonstrate that the restaurant reviews are heavily based on cuisine. Additionally, it reveals what customers care about at different restaurant types and occasions. For example, the fact that "wine" and "service" are two top words of the same topic suggests that customers put greater emphasis on service at a restaurant serving wine than at, for example, a restaurant serving burgers. 

We can even take this one step further by noticing that "service" also appears in the topic I've labeled "Happy hour," which suggests that customers generally care more about service at restaurants that serve alcohol.


