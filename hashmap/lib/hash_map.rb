# frozen_string_literal: true

# The HashMap class represents a basic implementation of a hash map.
class HashMap
  attr_reader :lenght

  LOAD_FACTOR = 0.75
  INITIAL_SIZE = 16

  def initialize(size = INITIAL_SIZE)
    @size = size
    @buckets = Array.new(size)
    @lenght = 0
  end

  # Converts a string into a hash number using a simple hash method.
  def string_to_number(string)
    hash_code = 0
    prime_number = 31
    string.each_char { |char| hash_code = prime_number * hash_code + char.ord }
    hash_code % @size
  end

  # Calculates a hash number by combining the results of converting
  # the name and surname strings.
  def hash(value)
    string_to_number(value)
  end

  # Calculates the current load factor of the hashmap.
  # Load factor is defined as the ratio of the number of elements to the size
  # of the hashmap.
  def current_load
    @lenght.to_f / @size
  end

  # Doubles the size of the hashmap and rehashes the existing elements.
  # This method is called when the load factor exceeds a predefined threshold.
  def rehash
    @size *= 2
    new_bucket = entries.flat_map { |pair| pair.map { |key, value| [key, value] } }
    @buckets = Array.new(@size)
    @lenght = 0
    new_bucket.each { |pair| set(pair[0], pair[1]) }
  end

  # Takes two arguments, the first is a key and the second is a
  # value that is assigned to this key
  def set(key, value)
    index = hash(key)
    entry = { key => value }
    if !@buckets[index]
      @buckets[index] = entry
    else
      @buckets[index][key] = value
      @buckets.pop
    end

    @lenght += 1
    rehash if current_load > LOAD_FACTOR
  end

  # Takes one argument as a key and returns the value that is
  # assigned to this key
  def get(key)
    @buckets[hash(key)][key] if key?(key)
  end

  # Takes a key as an argument and returns true or false based on whether
  # or not the key is in the hash map.
  def key?(key)
    @buckets[hash(key)] ? @buckets[hash(key)].include?(key) : false
  end

  # If the given key is in the hash map, it should remove the entry with that
  # key and return the deleted entry’s value
  def remove(key)
    if key?(key)
      value = get(key)
      @buckets[hash(key)] = nil
      @lenght -= 1
      return value
    end
    nil
  end

  # removes all entries in the hash map.
  def clear
    @lenght = 0
    @buckets = Array.new(INITIAL_SIZE)
  end

  # returns an array containing all the keys inside the hash map.
  def keys
    entries.map(&:keys).flatten
  end

  # returns an array containing all the values.
  def values
    entries.map(&:values).flatten
  end

  # returns an array that contains each key, value pair
  def entries
    @buckets.compact.flat_map { |hash| hash.map { |key, value| { key => value } } }
  end
end
