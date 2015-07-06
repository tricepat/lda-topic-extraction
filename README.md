# Latent Dirichlet Allocation 
This implementation demonstrates how Latent Dirichlet Allocation (LDA) can be used to identify topics in instances of text. 

Latent Dirichlet Allocation is a generative topic model that explains similarities in a set of observations by revealing underlying topics that contribute to each observation. Each topic is a multinomial distribution of words in a dictionary of specified size and vocabulary. The model assumes that each observation is composed of a distribution of the topics.

# How can it benefit Homepolish?

A new Homepolish user is matched with a designer based on a user-input body of text that describes project needs and the intended space. To facilitate more efficient matching, LDA can be run on these project descriptions to identify underlying "topics" such as "Bohemian," "small space," "feminine," and "budget." The automation of this process helps the Queen Bees identify the right designer.

# Implementation

In the absence of access to the Homepolish dataset, I used Yelp restaurant reviews from the greater Phoenix, AZ metropolitan area from a publicly released JSON dataset. Each element contains the following fields: "votes," "user_id," "review_id," "stars," "date," "text," "type," and "business_id." The implementation extracts the "text" field, just as an implementation on a Homepolish dataset would extract the "description" field of the new  project request process.

In this implementation, the vocabulary is composed of words in the reviews. Each review represents a document and each document has a specific distribution of topics. Each word in a document is then a result of this distribution. The LDA model is used over the Yelp restaurant reviews to identify topics and topic distributions.

Running "extract_subtopics.rb" with an integer input argument specifiying the number of topics to identify with LDA creates an LDA model based on the training data "reviews_training.json." and outputs a file "topics.txt" containing the top words (number specified by a constant in the script) in each numbered topic cluster. Based on these words, we can map each topic number to a label such as "Rustic," so that when the model is used on new text (testing data) the topic can be identified. Please keep in mind that the LDA model does take some time to build (~10 minutes).
