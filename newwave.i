[Mesh]
  type = GeneratedMesh
  dim = 2
  nx = 100
  ny = 10
  xmax = 0.0258
  ymax = 0.0108
[]

[Variables]
  [./inlet_temperature]
    order = FIRST
    family = LAGRANGE
    intial_condition = 2300
  [../]
  [./outlet_temperature]
    order = FIRST
    family = LAGRANGE
    initial_condition = 300
  [../]
[]

[Kernels]
  [./heat_conduction_in]
    type = heatconduction
    variable = inlet_temperature
  [../]
  [./heat_conduction_out]
    type = heatconduction
    variable = outlet_temperature
  [../]
  [./heat_conduction_time_derivative_in]
    type = heatconductiontimederivative
    variable = inlet_temperature
  [../]
  [./heat_conduction_time_derivative_out]
    type = heatconductiontimederivative
    variable = outlet_temperature
  [../]
  [./heat_convection_in]
    type = heatconvection
    variable = inlet_temperature
    velocity = '.0032 0 0'
  [../]
  [./heat_convection_out]
    type = heatconvection
    variable = outlet_temperature
    velocity = '.0032 0 0'
  [../]
[]

[BCs]
  [./temperature_in]
    type = ConvectiveFluxFunction
    variable = inlet_temperature
    T_infinity = 300
    coefficient = 10
    boundary = left
  [../]
  [./temperature_out]
    type = ConvectiveFluxFunction
    variable = outlet_temperature
    T_infinity = 300
    coefficient = 10
    boundary = right
  [../]
[]

[Materials]
  [./thermite]
    type = GenericConstantMaterial
    prop_names = 'thermal_conductivity specific_heat density'
    prop_values = '38.00 680.0 4360.0' # W/m*K, J/kg-K, kg/m^3 @296K
  [../]
[]

#[Problem]
#type = FEProblem
#coord_type = RZ
#rz_coord_axis = X
#[]

[Executioner]
  type = Transient
  num_steps = 50
  nl_abs_tol = 1e-6
  solve_type = PJFNK
  petsc_options_iname = '-pc_type -pc_hypre_type'
  petsc_options_value = 'hypre boomeramg'
[]

[Postprocessors]
  [./dofs]
    type = NumDOFs
  [../]
[]

[Outputs]
  exodus = true
[]
