require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if @map.include?(key)
      cache_link = @map.get(key)
      update_link!(cache_link)
      return cache_link.val
    else
      calc!(key)
      eject! if count > @max
      @store.last.val
    end
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    result = @prc.call(key)
    @store.append(key, result)
    @map.set(key, @store.last)
  end

  def update_link!(link)
    # suggested helper method; move a link to the end of the list
    link.remove
    @store.lru_append(link)
  end

  def eject!
    ##Unlink in the map
    first_key = @store.first.key
    @map.delete(first_key)
    ##Remove from the store
    @store.first.remove
  end
end
