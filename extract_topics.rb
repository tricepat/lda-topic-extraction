require 'lda-ruby'
require 'json'

# additional stopwords whose appearances across all topics of the LDA extraction indicate that they are meaningless in the context of this dataset
additional_stopwords = ["it's", "really", "good", "great", "best", "always", "like", "love", "even", "go", "never", "would", "didn't", "don't", "get", "i've", "could", "also", "got", "us", "i'm", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten", "http", "com", "told", "said", "went", "time", "back", "much", "know", "going", "see", "well", "place", "make", "restaurant", "food", "first", "bad", "way", "ever", "-"]
NUM_TOP_WORDS = 5

# check that there is an integer input argument greater than zero
raise(ArgumentError, "This script takes a single integer greater than zero as an argument that specifies the number of topics to identify with LDA") unless (ARGV[0] && (ARGV[0].to_i > 0))
num_topics = ARGV[0].to_i

# create an LDA object for training
corpus = Lda::Corpus.new

# extract text from each review in JSON and preprocess to remove additional stopwords (common stopwords will be removed by the LDA module when building the corpus)
reviews = "" # contains all preprocessed review text
File.open("data/reviews_training.json", "r") do |f|
  f.each_line do |line|
    review = JSON.parse(line)
    text = review["text"].downcase().split(/[\s,!?.]+/) # tokenize downcased words on spaces and the following punctuation: ,!?.
    filtered_review = []
    text.each {|w| filtered_review << w unless additional_stopwords.include? w.strip()}
    corpus.add_document(Lda::TextDocument.new(corpus, filtered_review.join(" ")))
  end
end

lda = Lda::Lda.new(corpus)
lda.verbose = false
lda.num_topics = num_topics
lda.em("random") # run EM algorithm using random starting points

# output top words in each topic cluster to file
# reference for formatting topics into output file: http://pygments.org/demo/352449/
topics_string = ""
  lda.beta.each_with_index do |topic, topic_num|
    indices = (topic.zip((0...lda.vocab.size).to_a).sort { |i, j| i[0] <=> j[0] }.map { |i, j| j }.reverse)[0...NUM_TOP_WORDS]
    topics_string += "Topic #{topic_num}\n"
    topics_string += "\t#{indices.map { |i| lda.vocab[i] }.join(", ")}\n\n"
  end
File.write('topics.txt', topics_string)


