[Mesh]
  type = GeneratedMesh
  dim = 2
  nx = 100
  ny = 10
  xmax = 0.0258 # Length of test chamber
  ymax = 0.0108 # Test chamber radius
[]

[Variables]
  [./temp]
    order = FIRST
    family = LAGRANGE
    initial_condition = 300 # Start at room temperature
  [../]
[]

#Does not affect the solution at all, but integral output postprocessor is affected
[Functions]
  [./Combust]
    type = ParsedFunction
    value = 1190.0*alpha*(1/(t+.1))
    vars = alpha
    vals = 1.0
  [../]
[]

[Kernels]
  #[./combust]
  #  type = combust
  #  variable = temp
  #  function = Combust
  #[../]
  [./heat_conduction]
    type = heatconduction
    variable = temp
  [../]
  [./heat_conduction_time_derivative]
    type = heatconductiontimederivative
    variable = temp
  [../]
  [./heatconvection]
    type = heatconvection
    variable = temp
    velocity = '3200 0 0'
  [../]
  #[./diffusion]
  #  type = Diffusion
  #  variable = temp
  #[../]
  #[./reaction]
  #  type = Reaction
  #  variable = temp
  #[../]
  #[./userforcingfunction]
  #  type = UserForcingFunction
  #  variable = temp
  #  function = Combust
  #[../]
[]

[BCs]
  #[./input_temperature]
  #  type = DirichletBC
  #  variable = temp
  #  boundary = left
  #  value = 2390
  #[../]
  [./inlet_temperature]
    type = ConvectiveFluxFunction
    variable = temp
    T_infinity = 2300
    coefficient = 20 # W/m^2*K
    function = Combust
    boundary = left
  [../]
  [./outlet_temperature]
    type = ConvectiveFluxFunction
    variable = temp
    T_infinity = 300
    coefficient = 20 # W/m^2*K
    boundary = right
  [../]
  #[./output_temperature]
  #  type = NeumannBC
  #  variable = temp
  #  boundary = right
  #  function = Combust
  #[../]
[]

[Materials]
  [./steel]
    type = GenericConstantMaterial
    prop_names = 'thermal_conductivity specific_heat density'
    prop_values = '38.00 680 4360' # W/m*K, J/kg-K, kg/m^3 @ 296K
  [../]
[]

[Problem]
  type = FEProblem
  coord_type = RZ
  rz_coord_axis = X
[]

[Executioner]
  type = Transient
  num_steps = 100
  nl_abs_tol = 1e-6
  solve_type = PJFNK
  petsc_options_iname = '-pc_type -pc_hypre_type'
  petsc_options_value = 'hypre boomeramg'
[]

[Postprocessors]
  [./dofs]
    type = NumDOFs
  [../]
  [./integral]
    type = ElementL2Error
    variable = temp
    function = Combust
  [../]
[]

[Outputs]
  exodus = true
[]
