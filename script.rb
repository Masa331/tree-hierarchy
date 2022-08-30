require 'pry'

# Structure of data: [type, id, parent_id]
data = [
  ['Shoes', '1', nil],
  ['Pants', '2', nil],
  ['Shirts', '3', nil],

  ['Black', '4', '1'],
  ['White', '5', '1'],

  ['Black', '6', '2'],
  ['White', '7', '2'],
  ['Pink', '8', '2'],

  ['Red', '9', '3'],
  ['Green', '10', '3'],

  ['With dots', '11', '9'],
  ['With stripes', '12', '9'],
  ['Without dots', '11', '9'],

  ['With stripes', '13', '10'],
]

expected_result = [
  ['Shoes', '1', [
    ['Black', '4', []],
    ['White', '5', []]
  ]],

  ['Pants', '2', [
    ['Black', '6', []],
    ['Pink', '8', []],
    ['White', '7', []]
  ]],

  ['Shirts', '3', [
    ['Green', '10', [
      ['With stripes', '13', []]
    ]],
    ['Red', '9', [
      ['With dots', '11', []],
      ['With stripes', '12', []],
      ['Without dots', '11', []]
    ]]
  ]],
]

def test(result, expected_result)
  result == expected_result
end

def try1(data)
  parents = data.select do |dato|
    dato[2].nil?
  end

  parents.map do |parent|
    [parent[0], parent[1], children(data, parent[1])]
  end
end

def children(data, key)
  childs = data.select { _1[2] == key }

  childs.map do |parent|
    [parent[0], parent[1], children(data, parent[1])]
  end.sort_by { _1[0] }
end

binding.pry

puts test(data, expected_result)
