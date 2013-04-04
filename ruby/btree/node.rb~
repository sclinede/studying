
require "#{File.dirname(__FILE__)}/helpers.rb"

class Node

	attr_accessor :leaf

	@@lvl_count = []
	@@levels = {}

	def initialize(degree = 2)
		raise "degree of btree must be 2 at minimum" if degree < 2	

		@degree = degree
		@leaf = false
		@keys = []
		@values = {}
		@children = []		

	end # of init

=begin
def search(key)

		pos = Helpers.find_pos(key, self._keys)

		if self.is_leaf?
			if self._keys[pos-1] == key
				return self._values[self._keys[pos-1]]	
			else
				return nil
			end # of if _keys[i-1].first == key

		else

			if self._children[pos]
				self._children[pos].search(key)
			else
				nil # ? is it possible
			end # of if _children[i]

		end # of if is_leaf?

	end
=end

	def search(key)

		pos = Helpers.find_pos(key, _keys)

		#if is_leaf?
		if _keys[pos-1] == key
			puts "success"
			return _values[_keys[pos-1]]	
		elsif not is_leaf?
			_children[pos].search(key)
		else
			return nil
		end # of if _keys[i-1].first == key

		#else

		#	if _children[pos]
		#		_children[pos].search(key)
		#	else
		#		puts "strange"
		#		nil # ? is it possible
		#	end # of if _children[i]

		#end # of if is_leaf?

	end

	def insert(key, val=nil, cnode=self)

		cnode_keys = cnode._keys;

		if cnode.is_full?

			split(cnode)
			puts "cnode now is: #{cnode_keys}"
			insert(key, val)
			#newpos = Helpers.find_pos(key, cnode_keys) # ??? why
			#newpos += 1 if cnode_keys[newpos]	< key
		
		else

			newpos = Helpers.find_pos(key, cnode_keys)		
			
			if cnode.is_leaf?	
			
				unless cnode_keys.include?(key)
					cnode_keys = Helpers.shift(cnode_keys, newpos)
					cnode_keys[newpos] = key
				end

				cnode._values[key] = [] unless cnode._values.has_key?(key)
				cnode._values[key] << val

			else

				cnode.insert(key, val, cnode._children[newpos])

			end
		end
	end

	def split(child)

		# wrapped _keys and _children
		keys = self._keys
		children = self._children		

		# check for root split
		self._children[0] = child if _children.empty?

		new_child = Node.new(@degree)

		new_child.leaf = child.leaf

		(@degree - 2).downto(0) { |i|
			new_child._keys[i] = child._keys[i + @degree]
			child._keys.pop

			cur_key = new_child._keys[i]
			new_child._values[cur_key] = child._values[cur_key]
			child._values.delete(cur_key)
		}

		unless new_child.is_leaf?
		
			(@degree-1).downto(0) { |i|
				new_child._children[i] = child._children[i + @degree]
				child._children.pop
			}

		end

		mid = child._keys[@degree-1]
		_values[mid] = child._values[mid]
		child._values.delete(mid)
		child._keys.pop

		newpos = Helpers.find_pos(mid, keys)
		keys = Helpers.shift(keys, newpos)
		keys[newpos] = mid
		children[newpos+1] = new_child				

	end

	def print(lvl=0, block = 0)

		lcnt = Node.lvl_count
		lhash = Node.levels

		lcnt = [] if lvl == 0
		lcnt[lvl] = 0 if lcnt.size <= lvl

		for key in _keys do
			lhash[lvl] = [] unless lhash.has_key?(lvl)
			lhash[lvl] << "l:#{lvl}, b:#{block}, key:#{key}, is_full?:#{is_full?}, is_leaf?:#{is_leaf?}"
		end
				
		for child in _children do
			child.print(lvl+1, lcnt[lvl])
			lcnt[lvl] += 1
		end
		lhash
	end
	
	def self.clear_print

		Node.levels.clear		
		Node.lvl_count.clear

	end

	def self.levels
		@@levels
	end

	def self.lvl_count
		@@lvl_count
	end

	def is_leaf?
		@leaf
	end

	def is_full?
		@keys.size >= 2*@degree - 1
	end

	protected

	def _values 
		@values
	end

	def _values=(val)
		@values = val
	end

	def _keys 
		@keys
	end

	def _keys=(val)
		@keys = val
	end

	def _children
		@children
	end

	def _children=(val)
		@children = val
	end
 
end # of Node class
