#include "Reacted.h"
#include <math.h>

template<>
InputParameters validParams<Reacted>()
{
  InputParameters params = validParams<AuxKernel>();
  //params.addParam<Real>("x", "Scalar value used for determining if reaction has occured");
  params.addRequiredCoupledVar("coupled", "Coupled variable");
  return params;
}

Reacted::Reacted(const InputParameters & parameters) :
    AuxKernel(parameters),

    //_x(getParam<Real>("x")),
    _coupled(coupledValue("coupled"))
{}

Real
Reacted::computeValue()
{
;
  Real k = 1190.0;
  Real dx;

    /*if(_coupled[_qp] < 2400 && _x == 0.0 && _coupled[_qp] >= 1200){
      _x = 0.0;
      dx = k*(1.0-_x);
      return (_coupled[_qp]) + dx;
    }
    else if(_coupled[_qp] < 1200 && _x == 0){
      _x = 0.0;
      return (_coupled[_qp]);
    }
    else {
      _x = 1.0;
      dx = k*(1.0-_x);
      return (_coupled[_qp]) + dx;
    }*/

    if(_coupled[_qp] < 2400 && _x == 0.0 && _coupled[_qp] >= 1200){
      _x = 0.0;
      dx = k*(1.0 - _x);
    }
    else if (_coupled[_qp] < 1200 && _x == 0.0){
      _x = 0.0;
      dx = 0.0;
    }
    else{
      _x = 1.0;
      dx = k*(1.0 - _x);
    }

    return dx;

  //dx = k*(1.0-_x);
  //std::cout<<_x<<std::endl;
  //return (_coupled[_qp]) + dx;
}
