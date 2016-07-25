#include "Products.h"

template<>
InputParameters validParams<Products>()
{
  InputParameters params = validParams<Material>();

  params.addCoupledVar("coupled", "Status of the reaction");
  params.addCoupledVar("temperature", "Temperature at current point");

  return params;
}

Products::Products(const InputParameters & parameters) :
  Material(parameters),
  _diffusion_coefficient(declareProperty<Real>("diffusion_coefficient")),
  _specific_heat(declareProperty<Real>("specific_heat")),
  _density(declareProperty<Real>("density")),
  _coupled_status(coupledValue("coupled")),
  _temp(coupledValue("temperature"))
{}

void
Products::computeQpProperties()
{
  if (_coupled_status[_qp] < 1.0)
  {
    _diffusion_coefficient[_qp] = 4.8;
    _specific_heat[_qp] = 750;
    _density[_qp] = 3500;
  }
  else
  {
    _diffusion_coefficient[_qp] = _temp[_qp] / 100.0;
    //_diffusion_coefficient[_qp] = 20;
    _specific_heat[_qp] = 880;
    _density[_qp] = 4500;
  }
}
