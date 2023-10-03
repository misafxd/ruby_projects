dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]

def substrings(text, dictionary)
    coincidence = {}
    low_text = text.downcase
    dictionary.each do |word|
        if low_text.scan(word).length > 0
            coincidence[word] = low_text.scan(word).length
        end
    end
    coincidence
end


puts substrings("below", dictionary)
puts substrings("Howdy partner, sit down! How's it going?", dictionary)
