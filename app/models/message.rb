class Message < ApplicationRecord
    
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks
    has_one :chat

    # settings analysis: {
    # ​​    tokenizer: {
    # ​​        shingles_tokenizer: { # if you have full matching then we'll need higher priority
    # ​​            type: 'whitespace'
    # ​​        },
    # ​​        edge_ngram_tokenizer: {
    # ​​            type: "edgeNGram", # we needed beginnings of the words
    # ​​            min_gram: "2",
    # ​​            max_gram: "20",
    # ​​            token_chars: ["letter","digit"],
    # ​​            filter:   ["lowercase"]
    # ​​        }
    # ​​    },
    # ​​    analyzer: {
    # ​​        shingle_analyzer: {
    # ​​            type:      'custom',
    # ​​            tokenizer: 'shingles_tokenizer',
    # ​​            filter:    ['shingle', 'lowercase', 'asciifolding']
    # ​​        },
    # ​​          edge_ngram_analyzer: {
    # ​​            tokenizer: "edge_ngram_tokenizer",
    # ​​            filter: ["lowercase"]
    # ​​        }
    # ​​    }
    # ​​  } do
    # ​​  mapping do
    # ​​    indexes :published,      type: "boolean", index: :not_analyzed
    # ​​
    # ​​    indexes :name, type: 'text', analyzer: "edge_ngram_analyzer", search_analyzer: 'standard', boost: 120, fields: {
    # ​​        'shingle' => { # shingle will have higher priority
    # ​​            type: 'text',
    # ​​            analyzer: 'shingle_analyzer',
    # ​​            search_analyzer: 'standard',  
    # ​​            boost: 240
    # ​​        },
    # ​​        'raw'     => { # use it if you need original value for any reason
    # ​​          type: 'keyword',
    # ​​          index: :not_analyzed
    # ​​        }
    # ​​    }
    # ​​    indexes :descr, type: 'text', analyzer: "edge_ngram_analyzer", search_analyzer: 'standard', boost: 60, fields: {
    # ​​    'shingle' => {
    # ​​      type: 'text',
    # ​​      analyzer: 'shingle_analyzer',
    # ​​      search_analyzer: 'standard',  
    # ​​      boost: 120
    # ​​    }
    # ​​    ....
    # ​​    end
    # ​​  end
    # ​​end
end
