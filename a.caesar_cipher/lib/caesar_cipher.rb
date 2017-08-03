def caesar_cipher(str, shift)
  new_shift = shift%26
  
  arr = str.chars.to_a
  arr_new = []
  
  arr.each do |letter|
    letter = letter.ord
    new_letter = letter + new_shift
    
    if letter.between?(65, 90)
        new_letter = 64 + new_letter - 90 if new_letter > 90
    elsif letter.between?(97, 122)
        new_letter = 96 + new_letter - 122 if new_letter > 122
    else
      new_letter = letter
    end
    
    arr_new.push(new_letter.chr)
  end
  arr_new.join
end
