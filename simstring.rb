require 'set'

NGram = Struct.new(:ngram, :index)

class NGramBuilder
  SENTINAL_CHAR = "\u00A0"    # non-breaking space

  attr_accessor :n

  def initialize(n)
    self.n = n
  end

  def ngrams(string)
    prefix_and_suffix_string = SENTINAL_CHAR * (n - 1)
    string = prefix_and_suffix_string + string + prefix_and_suffix_string
    ngram_strings = string.each_char.each_cons(n)
    ngram_strings_to_count_map = ngram_strings.reduce({}) {|memo, ngram_string| memo[ngram_string] = (memo[ngram_string] || 0) + 1; memo }
    numbered_ngrams = ngram_strings_to_count_map.flat_map {|ngram_string, count| (1..count).map {|i| NGram.new(ngram_string, i) } }
    numbered_ngrams.to_set
  end
end

class Measure
  # qsize is an int
  # alpha is a double
  def min_size(qsize, alpha)
    raise "Not implemented."
  end

  # qsize is an int
  # alpha is a double
  def max_size(qsize, alpha)
    raise "Not implemented."
  end

  # qsize is an int
  # rsize is an int
  # alpha is a double
  def min_match(qsize, rsize, alpha)
    raise "Not implemented."
  end
end

class CosineMeasure < Measure
  def min_size(qsize, alpha)
    (alpha * alpha * qsize).ceil.to_i
  end

  def max_size(qsize, alpha)
    (qsize / (alpha * alpha)).floor.to_i
  end

  def min_match(qsize, rsize, alpha)
    (alpha * Math.sqrt(qsize * rsize)).ceil.to_i
  end
end

class Database
  def initialize(ngram_builder)
    @strings = Set.new
    @ngram_builder = ngram_builder
    @ngram_to_string_map = {}
  end

  def add(string)
    if !@strings.include(string)
      ngrams = ngram_builder.ngrams(string)
      ngrams.each do |ngram|
        @ngram_to_string_map[ngram] ||= Set.new
        @ngram_to_string_map[ngram] << ngram
      end
    end
  end
end

class SimString
  def initialize(simstring_db)
    @db = simstring_db
  end
end
