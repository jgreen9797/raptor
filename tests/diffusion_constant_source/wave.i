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
    [./InitialCondition]
      type = BoundingBoxIC
      x1 = 0.0
      y1 = 0.0
      x2 = 0.00258
      y2 = 0.0108
      inside = 1200
      outside = 300
    [../]

#    initial_condition = 300 # Start at room temperature
  [../]
[]

[AuxVariables]
  [./reaction_boolean]
    order = FIRST
    family = LAGRANGE
    [./InitialCondition]
      type = ConstantIC
      value = 300.0
    [../]
  [../]
[]

[Functions]
  [./Combust]
    type = ParsedFunction
    value = 1200.0*alpha
    vars = alpha
    vals =  1.0e6
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
    coupled = reaction_boolean
  [../]
  [./heat_conduction_time_derivative]
    type = heatconductiontimederivative
    variable = temp
  [../]
#   [./heatconvection]
#     type = heatconvection
#     variable = temp
#     velocity = '3200 0 0'
#   [../]
  #[./diffusion]
  #  type = Diffusion
  #  variable = temp
  #[../]
  #[./reaction]
  #  type = Reaction
  #  variable = temp
  #[../]
  [./reaction_heat_source]
   type = combust
   variable = temp
   function = Combust
   coupled = reaction_boolean
  [../]
[]

[AuxKernels]
  active = 'reaction_status'
  [./reaction_status]
    type = Reacted
    variable = reaction_boolean
    #x = 0.0
    coupled = temp
  [../]
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
    T_infinity = 300
    coefficient = 0.10 # W/m^2*K
    boundary = left
  [../]
  [./outlet_temperature]
    type = ConvectiveFluxFunction
    variable = temp
    T_infinity = 300
    coefficient = 0.10 # W/m^2*K
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
    prop_values = '3.800 680 4360' # W/m*K, J/kg-K, kg/m^3 @ 296K
  [../]
[]

# [Problem]
#   type = FEProblem
#   coord_type = RZ
#   rz_coord_axis = X
# []

[Executioner]
  type       = Transient
  solve_type = 'PJFNK'

  petsc_options_iname = '-pc_type -pc_hypre_type -ksp_gmres_restart -snes_ls -pc_hypre_boomeramg_strong_threshold'
  petsc_options_value = 'hypre boomeramg 201 cubic 0.7'


  dtmax = 864000.0
  dtmin = 1.0e-6
  end_time = 100

  [./TimeStepper]
    type = SolutionTimeAdaptiveDT
    dt = 1.0
  [../]

  l_max_its  = 50
  l_tol      = 1e-6
  nl_max_its = 10
  nl_rel_tol = 1e-6
  nl_abs_tol = 1e-12
[]

# [Postprocessors]
#   [./dofs]
#     type = NumDOFs
#   [../]
#   [./integral]
#     type = ElementL2Error
#     variable = temp
#     function = Combust
#   [../]
# []

[Outputs]
  file_base      = out
  interval       = 1
  exodus         = true
  [./Console]
    type = Console
    output_linear = 1
    output_nonlinear = 1
    #linear_residuals    = 1
    #nonlinear_residuals = 1
  [../]
[]
