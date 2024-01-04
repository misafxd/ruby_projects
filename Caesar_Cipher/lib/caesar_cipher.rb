def caesar_cipher(str, shift_factor)
    cipher = str.bytes.map do |byte|
        if byte.chr.match(/[a-zA-Z]/)
        shift = byte + shift_factor

        if byte.chr.match(/[a-z]/) #check lowercase
            shift = ((shift - 'a'.ord) % 26) + 'a'.ord
        elsif byte.chr.match(/[A-Z]/) #check uppercase
            shift = ((shift - 'A'.ord) % 26) + 'A'.ord
        end
        #return byte to char
        byte = shift.chr
    end
    byte.chr
    end
    cipher.join("")
end

# puts caesar_cipher("Hello, Wolrd!",4) #output: Lipps, Aspvh!
# puts caesar_cipher("I really want eat pizza", 8) #output: Q zmittg eivb mib xqhhi
# puts caesar_cipher("I am negative",-5) #output: D vh izbvodqz
