def substrings(str, arr)
  results = Hash.new
  arr.each do |word|
    count = str.downcase.scan(/#{word.downcase}/).size
    if count > 0
      results[word] = count
    end
  end
  puts results
end

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]

substrings("Howdy partner, sit down! How's it going?", dictionary)