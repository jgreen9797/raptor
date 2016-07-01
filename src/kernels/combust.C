#include "combust.h"
#include "heatconduction.h"
#include "Function.h"

template<>
InputParameters validParams<combust>()
{
  InputParameters params = validParams<Kernel>();
  params.addRequiredParam<FunctionName>("function", "The forcing function");
  return params;
}

combust::combust(const InputParameters & parameters) :
    Kernel(parameters),
    _thermal_conductivity(getMaterialProperty<Real>("thermal_conductivity")),
    _specific_heat(getMaterialProperty<Real>("specific_heat")),
    _density(getMaterialProperty<Real>("density")),
    _func(getFunction("function"))
{
}

Real
combust::f()
{
  return _func.value(_t, _q_point[_qp]);
}

Real
combust::computeQpResidual()
{
  if (_u[_qp] >= 1100)
    return -_test[_i][_qp] * f();
  else
    return 0.0;
}
