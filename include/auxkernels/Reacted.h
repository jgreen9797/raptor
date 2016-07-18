#ifndef REACTED_H
#define REACTED_H

#include "AuxKernel.h"

class Reacted;

template<>
InputParameters validParams<Reacted>();

class Reacted : public AuxKernel
{
public:

  Reacted(const InputParameters & parameters);

protected:
  virtual Real computeValue();

  Real _x = 0.0;
  const VariableValue & _coupled;
};

#endif //REACTED_H
