# Levenshtein distance methods.
#
# NOTE: To use `Levenshtein`, you must explicitly import it with `require "levenshtein"`
module Levenshtein
  # Computes the [levenshtein distance](http://en.wikipedia.org/wiki/Levenshtein_distance) of two strings.
  #
  # ```
  # require "levenshtein"
  #
  # Levenshtein.distance("algorithm", "altruistic") # => 6
  # Levenshtein.distance("hello", "hallo")          # => 1
  # Levenshtein.distance("こんにちは", "こんちは")           # => 1
  # Levenshtein.distance("hey", "hey")              # => 0
  # ```
  def self.distance(string1 : String, string2 : String) : Int32
    return 0 if string1 == string2

    s_size = string1.size
    t_size = string2.size

    return t_size if s_size == 0
    return s_size if t_size == 0

    # This is to allocate less memory
    if t_size > s_size
      string1, string2 = string2, string1
      t_size, s_size = s_size, t_size
    end

    costs = Slice(Int32).new(t_size + 1) { |i| i }
    last_cost = 0

    if string1.single_byte_optimizable? && string2.single_byte_optimizable?
      s = string1.to_unsafe
      t = string2.to_unsafe

      s_size.times do |i|
        last_cost = i + 1

        t_size.times do |j|
          sub_cost = s[i] == t[j] ? 0 : 1
          cost = Math.min(Math.min(last_cost + 1, costs[j + 1] + 1), costs[j] + sub_cost)
          costs[j] = last_cost
          last_cost = cost
        end
        costs[t_size] = last_cost
      end

      last_cost
    else
      reader = Char::Reader.new(string1)

      # Use an array instead of a reader to decode the second string only once
      chars = string2.chars

      reader.each_with_index do |char1, i|
        last_cost = i + 1

        chars.each_with_index do |char2, j|
          sub_cost = char1 == char2 ? 0 : 1
          cost = Math.min(Math.min(last_cost + 1, costs[j + 1] + 1), costs[j] + sub_cost)
          costs[j] = last_cost
          last_cost = cost
        end
        costs[t_size] = last_cost
      end

      last_cost
    end
  end

  # Finds the closest string to a given string amongst many strings.
  #
  # ```
  # require "levenshtein"
  #
  # finder = Levenshtein::Finder.new "hallo"
  # finder.test "hay"
  # finder.test "hall"
  # finder.test "hallo world"
  #
  # finder.best_match # => "hall"
  # ```
  class Finder
    # :nodoc:
    record Entry,
      value : String,
      distance : Int32

    @tolerance : Int32

    # Creates a new `Finder` to find the closest match for the given *target* string.
    #
    # The *tolerance* argument sets the maximum permitted Levenshtein distance.
    # If *tolerance* is not provided, it defaults to roughly 20% of the target's length
    # (specifically `(target.size / 5.0).ceil.to_i`).
    def initialize(@target : String, tolerance : Int? = nil)
      @tolerance = tolerance || (target.size / 5.0).ceil.to_i
    end

    # Tests a string against the target to see if it is a closer match than any previously tested strings.
    #
    # Evaluates the Levenshtein distance between the *name* and the target string.
    # If the distance is less than or equal to the defined tolerance, and it is the
    # smallest distance seen so far, this entry is recorded as the best match.
    #
    # The optional *value* argument allows you to store a different string as the
    # best match while testing against *name*. If *value* is omitted, it defaults to *name*.
    #
    # ```
    # require "levenshtein"
    #
    # finder = Levenshtein::Finder.new("hello", tolerance: 2)
    # finder.test("hallo")
    # finder.test("hulk", "The Incredible Hulk")
    #
    # finder.best_match # => "hallo"
    # ```
    def test(name : String, value : String = name)
      distance = Levenshtein.distance(@target, name)
      if distance <= @tolerance
        if best_entry = @best_entry
          if distance < best_entry.distance
            @best_entry = Entry.new(value, distance)
          end
        else
          @best_entry = Entry.new(value, distance)
        end
      end
    end

    # Returns the best matching string found so far, or `nil` if no strings were
    # tested or if none met the tolerance threshold.
    def best_match : String?
      @best_entry.try &.value
    end

    def self.find(name, tolerance = nil, &)
      sn = new name, tolerance
      yield sn
      sn.best_match
    end

    def self.find(name, all_names, tolerance = nil) : String?
      find(name, tolerance) do |similar|
        all_names.each do |a_name|
          similar.test(a_name)
        end
      end
    end
  end

  # Finds the best match for *name* among strings added within the given block.
  # *tolerance* can be used to set maximum Levenshtein distance allowed.
  #
  # ```
  # require "levenshtein"
  #
  # best_match = Levenshtein.find("hello") do |l|
  #   l.test "hulk"
  #   l.test "holk"
  #   l.test "halka"
  #   l.test "ello"
  # end
  # best_match # => "ello"
  # ```
  def self.find(name, tolerance = nil, &) : String?
    Finder.find(name, tolerance) do |sn|
      yield sn
    end
  end

  # Finds the best match for *name* among strings provided in *all_names*.
  # *tolerance* can be used to set maximum Levenshtein distance allowed.
  #
  # ```
  # require "levenshtein"
  #
  # Levenshtein.find("hello", ["hullo", "hel", "hall", "hell"], 2) # => "hullo"
  # Levenshtein.find("hello", ["hurlo", "hel", "hall"], 1)         # => nil
  # ```
  def self.find(name, all_names, tolerance = nil) : String?
    Finder.find(name, all_names, tolerance)
  end
end
