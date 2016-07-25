/****************************************************************/
/* MOOSE - Multiphysics Object Oriented Simulation Environment  */
/*                                                              */
/*          All contents are licensed under LGPL V2.1           */
/*             See LICENSE for full restrictions                */
/****************************************************************/
#ifndef HEATCONDUCTION_H
#define HEATCONDUCTION_H

#include "Diffusion.h"
#include "Material.h"
#include "Reacted.h"

//Forward Declarations
class heatconduction;

template<>
InputParameters validParams<heatconduction>();

/**
 * Note: This class is named HeatConductionKernel instead of HeatConduction
 * to avoid a clash with the HeatConduction namespace.  It is registered
 * as HeatConduction, which means it can be used by that name in the input
 * file.
 */
class heatconduction : public Diffusion
{
public:

  heatconduction(const InputParameters & parameters);

protected:
  virtual Real computeQpResidual();

  virtual Real computeQpJacobian();

private:
  const unsigned _dim;
  const MaterialProperty<Real> & _diffusion_coefficient;
  const MaterialProperty<Real> * const _diffusion_coefficient_dT;
  //const VariableValue & _coupled_val;
};

#endif //HEATCONDUCTION_H
