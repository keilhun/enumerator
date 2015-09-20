module Enumerable
  def my_each
    0.upto(self.length-1) do |i|
       yield(self[i])
    end
  end

  def my_each_with_index
    0.upto(self.length-1) do |i|
      yield(self[i], i)
    end
  end

  def my_select
    out = []
     self.my_each do |x|
        if yield(x) == true
          out << x
        end
     end
    return out
  end

  def my_all?
    out = true
     self.my_each do |x|
        out = yield(x)
       return false if out == false
     end
    return out
  end

  def my_any?
    out = false
    self.my_each do |x|
      return true if yield(x) == true
    end
    return out
  end

  def my_none?
    out = true
    self.my_each do |x|
      out1 = yield(x)
      return false if yield(x) == true
    end
    return out
  end

  def my_count(value = nil)
    count = 0
    if block_given?
      my_each {|x| count+=1 if yield(x)}
    elsif value.nil?
      count = length
    else
      self.my_each { |x| count+=1 if x == value}
    end

    return count
  end

  def my_map
    out = []
    my_each { |x| out << yield(x) } if block_given?
    return out
  end

  def my_inject(start_value = nil)
    out_value = start_value.nil? ? first : start_value
    my_each {|x| out_value = yield(out_value, x)}
    return out_value
  end
end

def multiply_els(list)
  list.my_inject(1) { |product, i| product * i }[1,2,3,4,5].my_each {|x| puts x*2}
end

[1,2,3,4,5].my_each_with_index {|value, index| puts "value is #{value}, index is #{index}"}
["this", "is", "a", "string", "test"].my_each_with_index {|value, index| puts "value is #{value}, index is #{index}"}

out = [1,2,3,4,5,6,7,8,9,0].my_select {|val| val.even?}
puts out

 out = %w[an bear cat].my_all? { |word| word.length >= 3 }
puts out

out = %w[an bear cat].my_any? { |word| word.length >= 3 }
puts out

out = %w[an bears cat].my_none? { |word| word.length >= 5 }
puts out

out = %w[an bears cat].my_count ("an")
puts "result from my_count with paramater #{out}"

out = %w[an bears cat].my_count {|word| word.length >= 6}
puts "result from my_count with block #{out}"

out = [3, 5, 8, 6, 3, 4].my_map{|x| x*2}
puts "my_map = #{out.inspect}"

puts "my_inject = #{[3, 5, 8, 6, 3, 4].my_inject{|sum, x| sum * x}}"