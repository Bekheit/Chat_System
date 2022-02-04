class Message < ApplicationRecord
    
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks
    has_one :chat

    settings  analysis: {
      tokenizer: {
          shingles_tokenizer: { # if you have full matching then we'll need higher priority
              type: 'whitespace'
        },
            edge_ngram_tokenizer: {
                type: "edgeNGram", # we needed beginnings of the words
                min_gram: "2",
                max_gram: "20",
                token_chars: ["letter","digit"],
                filter:   ["lowercase"]
            }
        },
        analyzer: {
            shingle_analyzer: {
                type:      'custom',
                tokenizer: 'shingles_tokenizer',
                filter:    ['shingle', 'lowercase', 'asciifolding']
            },
              edge_ngram_analyzer: {
                tokenizer: "edge_ngram_tokenizer",
                filter: ["lowercase"]
            }
        }
      } do
          mapping do
            indexes :content, type: 'text', analyzer: "standard"
          end
        end

      def self.search(message)
        definition = {
          # getting just an id.
          # Remove line if want to get all model  from Elasstic
          # _source: false,
          # query: {
          #   bool:{
          #     must: {
          #       multi_match: {
          #         query: "*#{message}*",
          #         fields: ["content"],
          #         analyzer: "standard"
          #       }
          #     }
          #   }
          # }

          query: {
            wildcard: {
              content: {
                value: "*#{message}*",
                boost: 1.0,
                rewrite: "constant_score"
              }
            }
          }
        }
        
        Message.__elasticsearch__.search(definition)
      end
end
