def merge_sort(array)
  if array.size <= 1
    array
  else
    half = array.size / 2
    left = merge_sort(array[0...half])
    right = merge_sort(array[half..])
    merge(left, right)
  end
end

def merge(left, right)
  result = []
  i = 0
  j = 0

  while i < left.size && j < right.size
    if left[i] <= right[j]
      result << left[i]
      i += 1
    else
      result << right[j]
      j += 1
    end
  end
  result + left[i..] + right[j..]
end

puts merge_sort([5, 4, 9, 5, 8])
