require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  attr_reader :count

  include Enumerable

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    @store[key.hash % num_buckets].include?(key)
  end

  def set(key, val)
    if include?(key)
      @store[key.hash % num_buckets].update(key, val)
    else
      resize! if count + 1 == num_buckets
      @store[key.hash % num_buckets].append(key, val)
      @count += 1
    end
  end

  def get(key)
    if include?(key)
      @store[key.hash % num_buckets].get(key)
    else
      puts "Key doesn't exist."
    end
  end

  def delete(key)
    if include?(key)
      @store[key.hash % num_buckets].remove(key)
      @count -= 1
    else
      puts "Key doesn't exist."
    end
  end

  def each
    @store.each do |list|
      list.each { |link| yield(link.key, link.val) }
    end
  end

  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    holder = Array.new(num_buckets * 2){LinkedList.new}
    each do |key, value|
      holder[key.hash % (num_buckets * 2)].append(key, value)
    end
    @store = holder
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
  end
end











#
