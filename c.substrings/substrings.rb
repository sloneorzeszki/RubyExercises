def substrings(str, arr)
  results = {}
  arr.each do |word|
    count = str.downcase.scan(/#{word.downcase}/).size
    results[word] = count if count > 0
  end
  puts results
end

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]

substrings("Howdy partner, sit down! How's it going?", dictionary)
