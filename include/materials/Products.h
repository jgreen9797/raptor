#ifndef PRODUCTS_H
#define PRODUCTS_H

#include "Material.h"

class Products;

template<>
InputParameters validParams<Products>();

class Products : public Material
{
public:
  Products(const InputParameters & parameters);

protected:
  virtual void computeQpProperties();

private:
  MaterialProperty<Real> & _diffusion_coefficient; //thermal_conductivity
  MaterialProperty<Real> & _specific_heat; //specific heat
  MaterialProperty<Real> & _density; //density
  const VariableValue & _coupled_status; //dx
  const VariableValue & _temp; //temp

};

#endif //PRODUCTS_H
