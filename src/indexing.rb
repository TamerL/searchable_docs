DAYS_ABRV = ['Mon','Tue','Wed','Thu','Fri','Sat','Sun']
DAYS = ['Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday']

def convert_to_string_from(week_days_numbers)
  data = week_days_numbers.split(',')
  output = convert_to_numbers(data)
  grouped_numbers = group_numbers(output)
  result = convert_to_range(grouped_numbers)
  result.join(", ")
end

def convert_to_numbers(array)
  case array.first
  when *Array("1".."7")
    array.map {|data_element| data_element.to_i}
  when *DAYS_ABRV
    array.map {|data_element| DAYS_ABRV.index(data_element)+1}
  when *DAYS
    array.map {|data_element| DAYS.index(data_element)+1}
  end
end

def group_numbers(array)
  result = []
  array.each do |day_num|
    last_result = result.pop || []
    if last_result.length == 0 || day_num == last_result.last + 1
      last_result << day_num
      result << last_result
    else
      result << last_result
      result << [day_num]
    end
  end
  result
end

def convert_to_range(array)
  iterator = 0
  result = []
  array.each do |nested_arr|
    case nested_arr.length
    when 1
      result << get_week_name(nested_arr.last)
    when 2
      result << get_week_name(nested_arr.first)
      result << get_week_name(nested_arr.last)
    else
      result << get_week_name(nested_arr.first) + "-" + get_week_name(nested_arr.last)
    end
  end
  result
end

def get_week_name(index)
  DAYS_ABRV[index-1]
end
