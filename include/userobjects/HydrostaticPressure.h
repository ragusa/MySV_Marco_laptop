#ifndef HYDROSTATICPRESSURE_H
#define HYDROSTATICPRESSURE_H

#include "EquationOfState.h"

// Forward Declarations
class HydrostaticPressure;

template<>
InputParameters validParams<HydrostaticPressure>();


/**
 * The HydrostaticPressure object is responsible for
 * computing and returning:
 * p = p(h, hU) where hU = (hu, hv) is the momentum vector
 * and various derivatives.
 *
 * We derive from UserObject so we can have a validParams()
 * function and be registered in the factory.
 */
class HydrostaticPressure : public EquationOfState
{
public:
  // Constructor
  HydrostaticPressure(const std::string & name, InputParameters parameters);

  // Destructor
  virtual ~HydrostaticPressure();

  /**
   * Called when this object needs to compute something.
   */
  virtual void execute() {};

  /**
   * Called before execute() is ever called so that data can be cleared.
   */
  virtual void initialize(){};

  /**
   * Finalize.  This is called _after_ execute() and _after_ threadJoin()!  This is probably where you want to do MPI communication!
   */
  virtual void finalize() {};

  // The interface for derived HydrostaticPressure objects to implement...
  virtual Real pressure(Real h, RealVectorValue hU) const;

  // The derivative of pressure wrt density (h)
  virtual Real dp_dh(Real h=0., RealVectorValue hU=0.) const;

  // The derivative of pressure wrt x-momentum (hu)
  virtual Real dp_dhu(Real h=0., RealVectorValue hU=0.) const;

  // The derivative of pressure wrt x-momentum (hv)
  virtual Real dp_dhv(Real h=0., RealVectorValue hU=0.) const;

  // Sound speed squared
  virtual Real c2(Real h=0., RealVectorValue hU=0.) const;

protected:
  Real _g;


};


#endif // HYDROSTATICPRESSURE_H

