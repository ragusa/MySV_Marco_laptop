#ifndef MYSVAPP_H
#define MYSVAPP_H

#include "MooseApp.h"

class MysvApp;

template<>
InputParameters validParams<MysvApp>();

class MysvApp : public MooseApp
{
public:
  MysvApp(InputParameters parameters);
  virtual ~MysvApp();

  static void registerApps();
  static void registerObjects(Factory & factory);
  static void associateSyntax(Syntax & syntax, ActionFactory & action_factory);
};

#endif /* MYSVAPP_H */
