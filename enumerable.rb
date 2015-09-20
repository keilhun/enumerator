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
     end
    return out
  end

  def my_any?

  end
end

[1,2,3,4,5].my_each {|x| puts x*2}

[1,2,3,4,5].my_each_with_index {|value, index| puts "value is #{value}, index is #{index}"}
["this", "is", "a", "string", "test"].my_each_with_index {|value, index| puts "value is #{value}, index is #{index}"}

out = [1,2,3,4,5,6,7,8,9,0].my_select {|val| val.even?}
print out

 out = %w[ant bear cat].my_all? { |word| word.length >= 3 }
print out