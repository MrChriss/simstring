# simstring
A Ruby implementation of the SimString approximate string matching algorithm.


### References:
- SimString website: http://www.chokkan.org/software/simstring/
- SimString reference implementation (C++): https://github.com/chokkan/simstring
- SimString paper: http://www.aclweb.org/anthology/C10-1096


### Install
```
gem install simstring_pure
```


### Usage
In IRB (some lines elided):
```
irb(main):003:0> require 'simstring_pure'

irb(main):004:0> ngram_builder = SimString::NGramBuilder.new(3)

irb(main):005:0> db = SimString::Database.new(ngram_builder)
irb(main):006:0> db.add("foo")
irb(main):007:0> db.add("bar")
irb(main):008:0> db.add("food")
irb(main):009:0> db.add("floor")

irb(main):010:0> matcher = SimString::StringMatcher.new(db, SimString::CosineMeasure.new)

irb(main):011:0> matcher.search("fooo", 0.6)
=> ["foo"]
irb(main):012:0> matcher.search("fooo", 0.5)
=> ["foo", "food"]
irb(main):021:0> matcher.search("fooor", 0.5)
=> ["foo", "floor"]
irb(main):022:0> matcher.search("for", 0.5)
=> ["floor"]
irb(main):023:0> matcher.search("for", 0.3)
=> ["foo", "food", "floor"]

irb(main):011:0> matcher.ranked_search("fooo", 0.6)
=> [#<struct SimString::Match value="foo", score=0.9128709291752769>]
irb(main):017:0> matcher.ranked_search("fooo", 0.5)
=> [#<struct SimString::Match value="foo", score=0.9128709291752769>, #<struct SimString::Match value="food", score=0.5>]
irb(main):020:0> matcher.ranked_search("fooor", 0.5)
=> [#<struct SimString::Match value="floor", score=0.5714285714285714>, #<struct SimString::Match value="foo", score=0.50709255283711>]
irb(main):021:0> matcher.ranked_search("for", 0.5)
=> [#<struct SimString::Match value="floor", score=0.50709255283711>]
irb(main):022:0> matcher.ranked_search("for", 0.3)
=> [#<struct SimString::Match value="floor", score=0.50709255283711>, #<struct SimString::Match value="foo", score=0.4>, #<struct SimString::Match value="food", score=0.3651483716701107>]
```


### Supported String Similarity Measures
- Cosine
- Dice
- Exact
- Jaccard
- Overlap


### Performance:

On a 2.7GHz Core i5 MacBook Pro (Retina, 13-inch, Early 2015), here are some sample timings:

```
davidellis:~/Projects/ruby/simstring (master) $ simstring wordlists/companynames.txt "Inyel Corp" 0.4
["PHH Corp",
 "Viad Corp",
 "Aegion Corp",
 "B2Gold Corp",
 "InfoSonics Corp",
 "GSV Capital Corp",
 "Intel Corporation"]
1.614527 seconds to build database
0.130983 seconds to search

davidellis:~/Projects/ruby/simstring (master) $ simstring wordlists/companynames.txt "Intel Corp" 0.6
["Intel Corporation"]
1.628863 seconds to build database
0.060129 seconds to search

davidellis:~/Projects/ruby/simstring (master) $ simstring wordlists/unabridged_dictionary.txt "zygoat" 0.7
[]
35.177757 seconds to build database
0.206831 seconds to search

davidellis:~/Projects/ruby/simstring (master) $ simstring wordlists/unabridged_dictionary.txt "zygoat" 0.5
["goat", "zygon", "zygoma", "zygose", "zygote", "zygous", "zygodont"]
34.808823 seconds to build database
0.840492 seconds to search
```


### Word Lists
- wordlists/companyNames.txt is a list of 5797 company names
- wordlists/unabridged_dictionary.txt is a list of 235544 words from an unabridged dictionary


### Run Tests:
```
rake
```
OR
```
rake test
```
