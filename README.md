# Latent Dirichlet Allocation 
This implementation demonstrates how Latent Dirichlet Allocation (LDA) can be used to identify topics in instances of text. 

Latent Dirichlet Allocation is a generative topic model that explains similarities in a set of observations by revealing underlying topics that contribute to each observation. Each topic is a multinomial distribution of words in a dictionary of specified size and vocabulary. The model assumes that each observation is composed of a distribution of the topics.

# Results
The results below are from running the algorithm on eight topics with a dataset of 12,023 restaurant review entries. I've attached tentative labels for each cluster.

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


