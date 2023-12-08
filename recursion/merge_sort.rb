def merge_sort(array)
  return array if array.size <= 1

  half = array.size / 2
  left = merge_sort(array[0...half])
  right = merge_sort(array[half..])

  result = []
  while !left.empty? && !right.empty?
    result << left.shift if left.first <= right.first
    result << right.shift
  end
  result + left + right
end

p merge_sort([5, 4, 9, 5, 7, 6])
