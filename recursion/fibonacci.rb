def fibs(n, count = 0, arr = [])
  while n > 0
    if count == 0
      arr << 0
    elsif count == 1
      arr << 1
    else
      arr << arr[count - 1] + arr[count - 2]
    end
    n -= 1
    count += 1
  end
  arr
end

def fibs_rec(number, result = [])
  result = [0, 1] if result.empty?
  if number > 2
    result << (result[-1] + result[-2])
    fibs_rec(number - 1, result)
  end
  result
end

puts fibs_rec(10)
