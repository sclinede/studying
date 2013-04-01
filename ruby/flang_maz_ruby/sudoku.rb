
module Sudoku

	class Puzzle

		ASCII = ".123456789"
		BIN = "00\001\002\003\004\005\006\007\010\011"

		def initialize(lines)
			
			if lines.respond_to? :join
				s = lines.join
			else
				s = lines.dup
			end

			s.gsub!(/\s/,"")

			raise Invalid, "Пазл имеет неверный размер" unless s.size == 81

			if i = s.index(/[^123456789\.]/)
				raise Invalid, "Недопустимый символ #{s[i,1]}, в пазле "
			end

			s.tr!(ASCII, BIN)
			@grid = s.unpack('c*')


			raise Invalid, "в исходном пазле имеются дубликаты" if has_duplicates?

		end # of initialize

		def to_s
			(0..8).collect { |r| @grid[r*9,9].pack('c9') }.join("n").tr(BIN,ASCII)
		end # of to_s

		def dup
			copy = super
			@grid = @grid.dup
			copy
		end # of dup

		def [](row, col)
			@grid[row*9 + col]
		end # of []

		def []=(row, col, newvalue)
			unless (0..9).include? newvalue
				raise Invalid, "Недопустимое значение ячейки"
			end
			@grid[row*9 + col] = newvalue
		end # of []=
		
		BoxOfIndex = [
			0,0,0,1,1,1,2,2,2,0,0,0,1,1,1,2,2,2,0,0,0,1,1,1,2,2,2,
			3,3,3,4,4,4,5,5,5,3,3,3,4,4,4,5,5,5,3,3,3,4,4,4,5,5,5,
			6,6,6,7,7,7,8,8,8,6,6,6,7,7,7,8,8,8,6,6,6,7,7,7,8,8,8
		].freeze

		def each_unknown
			0.upto 8 do |row|
				0.upto 8 do |col|
					index = row*9 + col
					next if @grid[index] != 0
					box = BoxOfIndex[index]
					yield row, col, box
				end				
			end
		end # of each_unknown

		def has_duplicates?
			0.upto(8){ |row| return true if rowdigits(row).uniq! }
			0.upto(8){ |col| return true if coldigits(col).uniq! }
			0.upto(8){ |box| return true if boxdigits(box).uniq! }
			false
		end # of has_duplicates?

		AllDigits = [1, 2, 3, 4, 5, 6, 7, 8, 9].freeze

		def possible(row, col, box)
			AllDigits - (rowdigits(row) + coldigits(col) + boxdigits(box))
		end # of possible

		private

		def rowdigits(row)
			@grid[row*9,9] - [0]
		end # of rowdigits

		def coldigits(col)
			result = []
			col.step(80, 9) { |i|
				v = @grid[i]
				result << v if (v != 0)
			}
			result
		end # of coldigits

		BoxToIndex = [0, 3, 6, 27, 30, 33, 54, 57, 60].freeze

		def boxdigits(box)
			i = BoxToIndex[box]

			[
				@grid[i], @grid[i+1], @grid[i+2],
				@grid[i+9], @grid[i+10], @grid[i+11],
				@grid[i+18], @grid[i+19], @grid[i+20]
			] - [0]
		end # of boxdigits

	end # of class Puzzle

	class Invalid < StandardError
	end

	class Impossible < StandardError
	end

	class << self

		def scan(puzzle)
			unchanged = false
			
			until unchanged

				unchanged = true

				rmin, cmin, pmin = nil

				min = 10

				puzzle.each_unknown do |row,col,box|
					p = puzzle.posible(row, col, box)

					case p.size
					when 0
						raise Impossible
					when 1
						puzzle[row,col] = p[0]
					else
						if unchanged && p.size < min
							min = p.size
							rmin, cmin, pmin = row, col, p
						end		
					end # of case

				end # of each_unknown do

			end # of until unchanged
			
			return rmin, cmin, pmin

		end # of scan
		
		def solve(puzzle)
	
			puzzle = puzzle.dup

			r,c,p = scan(puzzle)

			return puzzle if r == nil

			p.each do |guess|

				begin
					return solve(puzzle)
				rescue Impossible
					next
				end # of begin rescue Impossible

			end # of p.each

			raise Impossible

		end # of solve

	end # of static methods

end # of module