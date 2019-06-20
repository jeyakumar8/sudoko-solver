module GameHelper
  def modify(array_hash)
    array = Array.new(9){Array.new(9)}
    is_value = true

    for i in 0..8
      for j in 0..8

        if array_hash[i.to_s][j.to_s] != "" && (array_hash[i.to_s][j.to_s].to_i <= 0 || array_hash[i.to_s][j.to_s].to_i > 9)
          is_value = false
          break
        else
          array[i][j] = array_hash[i.to_s][j.to_s].to_i
        end
      end
    end

    return array, is_value
  end

  def sudoko(array_hash)
    array_value, is_value = modify(array_hash)
    if !is_value || !is_valid_sudoko_board(array_value)
      return [], false
    end
    return array_value, true
  end

  def is_valid_sudoko_board(array_value)
    p "insode is valid sudko"
    check_horizontal(array_value) &&
      check_vertical(array_value) &&
      check_diagonal(array_value)
  end

  def check_horizontal(array_value)
    for i in 0..8
      check_hash = get_new_check_hash
      for j in 0..8
        next if array_value[i][j] == 0
        check_hash[array_value[i][j].to_s] += 1
      end
      return false if not_valid?(check_hash)
    end
  end

  def check_vertical(array_value)
    for i in 0..8
      check_hash = get_new_check_hash
      for j in 0..8
        next if array_value[j][i] == 0
        check_hash[array_value[j][i].to_s] += 1
      end
      return false if not_valid?(check_hash)
    end
  end

  def check_diagonal(array_value)
    check_hash = get_new_check_hash
    # p check_hash
    for i in 0..8
      j = i
      next if array_value[i][j] == 0
      check_hash[array_value[i][j].to_s] += 1
    end
    return false if not_valid?(check_hash)
    check_hash = get_new_check_hash
    p "inside next diagonal"
    # p array_value
    for i in 0..8
      i = i
      j = 8 - i
      next if array_value[i][j] == 0
      check_hash[array_value[i][j].to_s] += 1
    end
    # p check_hash
    return false if not_valid?(check_hash)
    true
  end

  def not_valid?(check_hash)
    for i in 1..9
      return true if check_hash[i.to_s] > 1
    end
    false
  end

  def get_new_check_hash
    check_hash = {}
    for i in 1..9
      check_hash[i.to_s] = 0
    end
    check_hash
  end

  # def solve_sudoko(array_value)
  #   for i in 0..8
  #     for j in 0..8
  #       if array_value == 0
  #         get
  #       end
  #     end
  #   end
  #   return array_value, true
  # end


  def solve_array(array)
    check_array = Array.new(9){Array.new(9){Array.new(9){0}}}
    # p array
    for i in 0..8
      for j in 0..8
        if array[i][j] == 0
          p "for each variable\n\n\n\n\n\n\n\n #{i}, #{j}"
          p "before_modify #{check_array[i][j]} 1"
          modify_check_array(array, check_array, i, j)
          p check_array[i][j]
          if count_value(check_array[i][j]) == 1
            p check_array[i][j]
            p "for ij #{i}, #{j}"
            array[i][j] = get_value(check_array[i][j])
          end
        end
      end
    end
  end

  def count_value(array_value)
    count = 0
    for i in 0..8
      if array_value[i] == 0
        count +=1
        if count > 1
          break
        end
      end
    end
    return count
  end

  def get_value(array_value)
    for i in 0..8
      if array_value[i] == 0
        return i + 1
      end
    end
    return 0
  end

  def modify_check_array(array, check_array, i, j)
    check_diagonal = false
    if i == j
      check_diagonal = true
    end

    if check_diagonal
      for k in 0..8
        if array[k][k] != 0
          check_array[i][j][array[k][k]-1] = 1
        end
        if array[k][8 - k] != 0
          check_array[i][j][array[k][8 - k]-1] = 1
        end
      end
    end
    p "before_modify #{check_array[i][j]} 2"
    check_vertical_and_horizontal(array, check_array, i, j)
    check_3_3_matrix(array,check_array, i, j)
    
  end

  def check_3_3_matrix(array, check_array, i, j)
    ori_i = (i/3) * 3
    ori_j = (j/3) * 3
    # p array
    for k in 0..2
      for l in 0..2
        if array[ori_i+k][ori_j+l]!=0
          check_array[i][j][array[ori_i + k][ori_j + l]-1] = 1
        end
      end
    end
    p "before_modify #{check_array[i][j]} 6"
  end

  def check_vertical_and_horizontal(array, check_array, i, j)
    p "before_modify #{check_array[i][j]} 3"
    for k in 0..8
      if array[i][k] !=0
        check_array[i][j][array[i][k]-1] = 1
      end
      if array[k][j] !=0
         check_array[i][j][array[k][j]-1] = 1
      end
    end
     p "before_modify #{check_array[i][j]} 4"
  end
end
