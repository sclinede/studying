
load '~/Work/study/ruby/btree/btree.rb'
btree = Btree.new
btree.insert(4,"a")
btree.insert(5,"b")
btree.insert(7,"c")
btree.insert(27,"d")
btree.insert(27,"d1")
btree.insert(27,"d12")
btree.insert(27,"d123")
btree.insert(26,"e")
btree.insert(29,"f")
btree.insert(32,"g")
btree.insert(113,"h")
btree.insert(114,"i")
btree.insert(115,"j")
btree.search(27)
