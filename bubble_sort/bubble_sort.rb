#!/usr/bin/env ruby

def bubble_sort(array)
  # Return the array if it's empty or has only one element
  return array if array.length <= 1

  # Flag to track if any swaps were made in a pass
  swapped = true

  # Continue until we make a full pass without any swaps
  while swapped
    # Set swapped to false at the start of each pass
    swapped = false

    # Compare adjacent elements
    (0...array.length - 1).each do |i|
      # If the current element is greater than the next element, swap them
      next unless array[i] > array[i + 1]

      # Perform the swap
      array[i], array[i + 1] = array[i + 1], array[i]
      # Set swapped to true because we made a swap
      swapped = true
    end
  end

  # Return the sorted array
  array
end

p bubble_sort([4, 3, 78, -1, -200, 100, 255, 2, 0, 2])
