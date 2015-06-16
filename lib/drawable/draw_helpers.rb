module DrawHelpers
  def to_unit_vector(x_comp, y_comp)
    length = Math.sqrt((x_comp.abs2 + y_comp.abs2).to_f)
    unit_x_comp = (x_comp.to_f / length)
    unit_y_comp = (y_comp.to_f / length)
    [unit_x_comp, unit_y_comp]
  end
end
