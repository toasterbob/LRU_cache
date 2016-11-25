class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
    @next.prev, @prev.next = @prev, @next
    @next = nil
    @prev = nil
  end
end

class LinkedList

include Enumerable

  def initialize
    @head = Link.new
    @tail = Link.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    each { |link| return link.val if link.key == key }
  end

  def include?(key)
    any? { |link| link.key == key }
  end

  def append(key, val)
    new_link = Link.new(key, val)
    new_link.prev = last
    last.next = new_link
    @tail.prev = new_link
    new_link.next = @tail
  end

  def lru_append(link)
    link.prev = last
    last.next = link
    @tail.prev = link
    link.next = @tail
  end

  def update(key, val)
    each do |link|
     if link.key == key
       link.val = val
       break
     end
    end
  end

  def remove(key)
    each do |link|
     if link.key == key
       link.remove
       break
     end
    end
  end

  def each  ##block
    current_link = first
    until current_link == @tail
      yield current_link
      current_link = current_link.next
    end
  end

  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
