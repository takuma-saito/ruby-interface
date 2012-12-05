
require_relative("interface")

class A
  include Interface
  disable_autoload
  interface :a, :b, :c
end

class B < A
  def initialize
    @a  = ""
  end

  def a
    puts "a"
  end

  def b
    puts "b"
  end

  def c
    puts "c"
  end
end

class C < A
  def a
    puts "a"
  end
end

# インターフェイスを確認
A.interface_assert

#b = B.new
