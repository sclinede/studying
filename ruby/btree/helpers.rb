class Helpers

  class << self

    def shift(arr,pos)
      return [] if arr.nil?
		  i = arr.size - 1
		  while i >= pos
			  arr[i+1] = arr[i] 
			  i -= 1
		  end
		  arr
	  end

	  def find_pos(key, keys_arr)
      return 0 if keys_arr.nil?
		  i = keys_arr.size - 1
		  while i >= 0 && key < keys_arr[i]#.first
			  i -= 1
		  end
		  i+1
	  end

  end

end
