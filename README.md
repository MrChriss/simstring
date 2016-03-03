# simstring
A Ruby implementation of the SimString approximate string matching algorithm.

### References:
- SimString website: http://www.chokkan.org/software/simstring/
- SimString reference implementation (C++): https://github.com/chokkan/simstring
- SimString paper: http://www.aclweb.org/anthology/C10-1096

### Performance:

On a 2.7GHz Core i5 MacBook Pro (Retina, 13-inch, Early 2015), here are some sample timings:

```
davidellis:~/Projects/ruby/simstring (master) $ ruby simstring.rb wordlists/companynames.txt "Inyel Corp" 0.4
["PHH Corp",
 "Viad Corp",
 "Aegion Corp",
 "B2Gold Corp",
 "InfoSonics Corp",
 "GSV Capital Corp",
 "Intel Corporation"]
1.614527 seconds to build database
0.130983 seconds to search

davidellis:~/Projects/ruby/simstring (master) $ ruby simstring.rb wordlists/companynames.txt "Intel Corp" 0.6
["Intel Corporation"]
1.628863 seconds to build database
0.060129 seconds to search

davidellis:~/Projects/ruby/simstring (master) $ ruby simstring.rb wordlists/unabridged_dictionary.txt "zygoat" 0.7
[]
35.177757 seconds to build database
0.206831 seconds to search

davidellis:~/Projects/ruby/simstring (master) $ ruby simstring.rb wordlists/unabridged_dictionary.txt "zygoat" 0.5
["goat", "zygon", "zygoma", "zygose", "zygote", "zygous", "zygodont"]
34.808823 seconds to build database
0.840492 seconds to search
```

### Word Lists
- wordlists/companyNames.txt is a list of 5797 company names
- wordlists/unabridged_dictionary.txt is a list of 235544 words from an unabridged dictionary
