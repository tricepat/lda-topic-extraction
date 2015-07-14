require 'lda-ruby'
require 'json'

# additional stopwords whose appearances across all topics of the LDA extraction indicate that they are meaningless in the context of this dataset
yelp_stopwords = ["it's", "really", "good", "great", "best", "always", "like", "love", "even", "go", "never", "would", "didn't", "don't", "get", "i've", "could", "also", "got", "us", "i'm", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten", "http", "com", "told", "said", "went", "time", "back", "much", "know", "going", "see", "well", "place", "make", "restaurant", "food", "first", "bad", "way", "ever", "-"]
NUM_TOP_WORDS = 5 # number of top words to output from each topic

# check that there is an integer input argument greater than zero
raise(ArgumentError, "This script takes three arguments: a non-zero positive integer that specifies the number of topics to identify, the filename of the input data, and the filename of the topics output") unless ((ARGV[0] && (ARGV[0].to_i > 0)) && (ARGV[1] && ARGV[2]))
num_topics = ARGV[0].to_i
input_filename = ARGV[1]
output_filename = ARGV[2]

# documents is an array of document text; stopwords is an array of stopwords specific to the data
def get_corpus(documents, stopwords)
  # create an LDA object for training
  corpus = Lda::Corpus.new
  # extract text from each document and preprocess to remove additional stopwords (common stopwords will be removed by the LDA module when building the corpus)
  documents.each do |d|
    text = d.downcase().split(/[\s,!?.]+/) # tokenize downcased words on spaces and the following punctuation: ,!?.
    filtered_review = []
    text.each {|w| filtered_review << w unless stopwords.include? w.strip()}
    corpus.add_document(Lda::TextDocument.new(corpus, filtered_review.join(" ")))
  end
  return corpus
end

def output_topics(filename, lda)
  # output top words in each topic cluster to file
  # reference for formatting topics into output file: http://pygments.org/demo/352449/
  topics_string = ""
    lda.beta.each_with_index do |topic, topic_num|
      indices = (topic.zip((0...lda.vocab.size).to_a).sort { |i, j| i[0] <=> j[0] }.map { |i, j| j }.reverse)[0...NUM_TOP_WORDS]
      topics_string += "Topic #{topic_num}\n"
      topics_string += "\t#{indices.map { |i| lda.vocab[i] }.join(", ")}\n\n"
    end
  File.write(filename, topics_string)
end

def preprocess_input_file(filename)
  documents = Array.new
  File.open(File.join("data", filename), "r") do |f|
    f.each_line do |line|
      document = JSON.parse(line)
      text = document["text"]
      documents.push(text)
    end
  end
  return documents
end

documents = Array.new # array of documents
documents = preprocess_input_file(input_filename)
corpus = get_corpus(documents, yelp_stopwords)

lda = Lda::Lda.new(corpus)
lda.verbose = false
lda.num_topics = num_topics
lda.em("random") # run EM algorithm using random starting points

output_topics(output_filename, lda)

# TODO: test model

