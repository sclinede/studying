
require "#{File.dirname(__FILE__)}/node.rb"
require "#{File.dirname(__FILE__)}/helpers.rb"

class Btree

  def initialize(degree = 2)
    
    @degree = degree
    @root = Node.new(@degree)
    @root.leaf = true;

  end

  def search(key)

    @root.search(key)

  end

  def insert(key, val=nil)

    if @root.is_full?

      new_root = Node.new(@degree)
      new_root.split(@root)
      #new_root.insert(key, val, @root);    
      @root = new_root

    end

    @root.insert(key, val, @root)

  end

  def print
    Node.clear_print
    by_lvl_hash = @root.print
    by_lvl_hash.sort.each { |arr| arr.each { |str| puts str } }
    nil
  end

end
