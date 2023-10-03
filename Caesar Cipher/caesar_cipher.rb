def caesar_cipher(str,shift_factor)
    cipher = str.bytes.map do |byte|
        shift = byte + shift_factor
        
        if byte.chr.match(/[a-z]/)
            shift = ((shift - 'a'.ord) % 26) + 'a'.ord
        elsif byte.chr.match(/[A-Z]/)
            shift = ((shift - 'A'.ord) % 26) + 'A'.ord
        end

        byte = shift.chr
    end
    cipher.join("")
end



