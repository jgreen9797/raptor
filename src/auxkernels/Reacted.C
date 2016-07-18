#include "Reacted.h"
#include <math.h>

template<>
InputParameters validParams<Reacted>()
{
  InputParameters params = validParams<AuxKernel>();
  params.addParam<Real>("ignition_temp", 1100, "ignition temperature");
  params.addParam<Real>("rate_constant", 1, "reaction rate");
  params.addRequiredCoupledVar("temp_var", "name of nonlinear vairbale that holds temperature");
  return params;
}

Reacted::Reacted(const InputParameters & parameters) :
    AuxKernel(parameters),
    _ignition_temp(getParam<Real>("ignition_temp")),
    _kr(getParam<Real>("rate_constant")),
    _temp(coupledValue("temp_var"))
{}

Real
Reacted::computeValue()
{
  Real T = _temp[_qp];
  Real x_old = _u_old[_qp];
  Real dx(0.0);
  
  if ( T < _ignition_temp)
    dx = 0.0;
  else if (T >= _ignition_temp && x_old < 1.0)
    dx = _kr * _dt / (_kr * _dt + 1.0)  * (1.0 - x_old);
  else if (x_old >= 1.0)
    dx = 0.0;
  else
    dx = 0.0;
  
  Real x = x_old + dx;
  
  return x;

  //dx = k*(1.0-_x);
  //std::cout<<_x<<std::endl;
  //return (_coupled[_qp]) + dx;
}
