[GlobalParams]
  lumping = false
  is_first_order = false
  Ce = 5.
[]

[Mesh]
  type = GeneratedMesh
  dim = 1
  xmin = -5.
  xmax = +5.
  nx = 5000
[]

[Functions]
  [./ic_func]
    axis = 0
    type = PiecewiseLinear
    x = '-5.  0.   0.00001 5.'
    y = ' 3.  3.   1.      1.'
  [../]
[]

[UserObjects]
  [./hydro]
    type = HydrostaticPressure
    gravity = 1.0
  [../]

  [./jump]
    type = JumpInterface
    entropy_flux_x = F_aux
    var_name_jump = jump_aux
  [../]
[]

[Variables]
  [./h]
    family = LAGRANGE
    order = FIRST
    [./InitialCondition]
      type = FunctionIC
      function = ic_func
    [../]
  [../]

  [./hu]
    family = LAGRANGE
    order = FIRST  
    [./InitialCondition]
      type = ConstantIC
      value = 0.
    [../]
  [../]
[]

[Kernels]
  [./TimeMass]
    type = TimeDerivative
    variable = h
  [../]

  [./Mass]
    type = WaterHeightEqu
    variable = h
    hu = hu
  [../]

  [./ArtDiffMass]
    type = ArtificialDissipativeFlux
    variable = h
    equ_name = continuity
  [../]

  [./TimeMmom]
    type = TimeDerivative
    variable = hu
  [../]

  [./Momentum]
    type = MomentumEqu
    variable = hu
    h = h
    hu = hu
    gravity = 1.0
    component = 0
    eos = hydro
  [../]
  
  [./ArtDiffMom]
    type = ArtificialDissipativeFlux
    variable = hu
    equ_name = x_mom
  [../]
[]

[AuxVariables]
  [./u_aux]
    family = LAGRANGE
    order = FIRST
  [../]

  [./entropy_aux]
    family = LAGRANGE
    order = FIRST
  [../]

  [./F_aux]
    family = LAGRANGE
    order = FIRST
  [../]

  [./jump_aux]
    family = MONOMIAL
    order = CONSTANT
  [../]

  [./kappa_aux]
    family = MONOMIAL
    order = CONSTANT
  [../]

  [./kappa_max_aux]
    family = MONOMIAL
    order = CONSTANT
  [../]
  
  [./residual_aux]
    family = MONOMIAL
    order = CONSTANT
  [../]
[]

[AuxKernels]
  [./u_ak]
    type = Xvelocity
    variable = u_aux
    h = h
    hu = hu
  [../]

  [./entropy_ak]
    type = EnergySw
    variable = entropy_aux
    h = h
    hu = hu
  [../]

  [./F_ak]
    type = EnergyFluxSw
    variable = F_aux
    momentum = hu
    h = h
    hu = hu
  [../]

  [./kappa_ak]
    type = MaterialRealAux
    variable = kappa_aux
    property = kappa
  [../]

  [./kappa_max_ak]
    type = MaterialRealAux
    variable = kappa_max_aux
    property = kappa_max
  [../]
 
  [./residual_ak]
    type = MaterialRealAux
    variable = residual_aux
    property = residual
  [../]
[]

[Materials]
  [./EntropyViscosityCoeff]
    type = EntropyViscosityCoefficient
    block = 0
    h = h
    hu = hu
    entropy = entropy_aux
    F = F_aux
    jump = jump_aux
    eos = hydro
  [../]
[]

[BCs]
  [./left_h]
    type = DirichletBC
    variable = h
    boundary = left
    value = 3.
  [../]

  [./right_h]
    type = DirichletBC
    variable = h
    boundary = right
    value = 1.0
  [../]

  [./left_hu]
    type = DirichletBC
    variable = hu
    boundary = left
    value = 0.
  [../]

  [./right_hu]
    type = DirichletBC
    variable = hu
    boundary = right
    value = 0.
  [../]
[]

[Postprocessors]
  [./dt]
    type = TimeStepCFL
    h = h
    hu = hu
    eos = hydro
    cfl = 0.5
    outputs = none
  [../]
[]

[Preconditioning]
  [./FDP]
    type = FDP
    full = true
    solve_type = 'PJFNK'
    petsc_options_iname = '-mat_fd_coloring_err  -mat_fd_type  -mat_mffd_type'
    petsc_options_value = '1.e-9       ds             ds'
    line_search = 'default'
  [../]
[]

[Executioner]
  type = Transient
  scheme = bdf2
  
  [./TimeStepper]
  type = PostprocessorDT
  postprocessor = dt
  dt = 1.e-3
#    type = FunctionDT
#    time_t = '0 50'
#    time_dt= '1e-1 1e-1'
  [../]

  nl_rel_tol = 1e-12
  nl_abs_tol = 1e-6
  nl_max_its = 10

  [./Quadrature]
    type = GAUSS
    order = SECOND
  [../]
  end_time = 2.
#  num_steps = 10

[]

[Outputs]
  output_initial = true
  exodus = true
  interval = 100
  print_linear_residuals = false
  print_perf_log = true
[]