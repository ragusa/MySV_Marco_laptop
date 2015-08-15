#ifndef MYSV_MARCO_LAPTOPAPP_H
#define MYSV_MARCO_LAPTOPAPP_H

#include "MooseApp.h"

class MysvMarcoLaptopApp;

template<>
InputParameters validParams<MysvMarcoLaptopApp>();

class MysvMarcoLaptopApp : public MooseApp
{
public:
  MysvMarcoLaptopApp(InputParameters parameters);
  virtual ~MysvMarcoLaptopApp();

  static void registerApps();
  static void registerObjects(Factory & factory);
  static void associateSyntax(Syntax & syntax, ActionFactory & action_factory);
};

#endif /* MYSV_MARCO_LAPTOPAPP_H */
