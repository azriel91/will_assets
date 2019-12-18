require 'yaml'

data = YAML.load_file 'us.yaml'

x_diffs = []
# puts data['layout_positions']['us']
data['layout_positions']['us'].each_cons(2) do |mapping_0, mapping_1|
  x_diffs += [mapping_1[1]['position']['x'] - mapping_0[1]['position']['x']]
end

puts "size: #{x_diffs.size}"
puts x_diffs
x_diffs = x_diffs.map { |x| x * 2 }

puts

data['layout_positions']['us'].each_cons(2).each_with_index do |(mapping_0, mapping_1), index|
  mapping_1[1]['position']['x'] = mapping_0[1]['position']['x'] + x_diffs[index] if x_diffs[index] > 0

  p mapping_1[1]['position']['x']
end

# puts YAML.dump data
