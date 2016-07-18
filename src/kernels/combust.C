#include "combust.h"
#include "Function.h"

template<>
InputParameters validParams<combust>()
{
  InputParameters params = validParams<Kernel>();
  params.addRequiredCoupledVar("coupled", "Coupled variable (reaction status)");
  params.addRequiredParam<FunctionName>("function", "The forcing function");
  return params;
}

combust::combust(const InputParameters & parameters) :
    Kernel(parameters),
    _thermal_conductivity(getMaterialProperty<Real>("thermal_conductivity")),
    _specific_heat(getMaterialProperty<Real>("specific_heat")),
    _density(getMaterialProperty<Real>("density")),
    _coupled_val(coupledValue("coupled")),
    _dcoupled_val_dt(coupledDot("coupled")),
    _func(getFunction("function"))
{}

Real
combust::f()
{
  return _func.value(_t, _q_point[_qp]);
}

Real
combust::computeQpResidual()
{

  if(_dcoupled_val_dt[_qp] > 0.0 && _coupled_val[_qp] <= 1.0)
    
    return -_test[_i][_qp] * f() * _dcoupled_val_dt[_qp];
  else
    return 0.0;
}
