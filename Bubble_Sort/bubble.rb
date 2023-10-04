def bubble_sort(arr)
    for i in 0..(arr.length-1)
        for i in 0..(arr.length-1)
            if arr[i+1] != nil
                if arr[i] > arr[i+1]
                    aux = arr[i+1]
                    arr[i+1] = arr[i]
                    arr[i] = aux
                end
            end
        end
    end
    arr        
end

puts bubble_sort([15,4,6,7,9,84,2,1])
puts bubble_sort([100,4,15,6,57,96,81,20])
