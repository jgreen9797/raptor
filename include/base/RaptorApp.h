#ifndef RAPTORAPP_H
#define RAPTORAPP_H

#include "MooseApp.h"

class RaptorApp;

template<>
InputParameters validParams<RaptorApp>();

class RaptorApp : public MooseApp
{
public:
  RaptorApp(InputParameters parameters);
  virtual ~RaptorApp();

  static void registerApps();
  static void registerObjects(Factory & factory);
  static void associateSyntax(Syntax & syntax, ActionFactory & action_factory);
};

#endif /* RAPTORAPP_H */
