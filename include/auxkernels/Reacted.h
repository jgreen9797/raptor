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

  Real _ignition_temp;
  
  Real _kr;
  
  const VariableValue & _temp;
  
};

#endif //REACTED_H
