#ifndef ENTROPYVISCOSITYCOEFFICIENT_H
#define ENTROPYVISCOSITYCOEFFICIENT_H

#include "Material.h"
#include "EquationOfState.h"

class EntropyViscosityCoefficient;

template<>
InputParameters validParams<EntropyViscosityCoefficient>();

/**
 * Computes dissipative fluxes for entropy viscosity method
 */
class EntropyViscosityCoefficient : public Material
{
public:
  EntropyViscosityCoefficient(const InputParameters & parameters);
  virtual ~EntropyViscosityCoefficient();

protected:
  virtual void computeQpProperties();

  // Parameters
  bool _is_first_order;
  Real _Ce;
  Real _g;

  // Coupled variables
  VariableValue & _h;
  VariableValue & _hu;
  VariableValue & _hv;

  // Coupled aux variables: entropy
  VariableValue & _E;
  VariableValue & _E_old;
  VariableValue & _E_older;

  // Coupled aux variables: entropy flux
  VariableGradient & _F_grad;
  VariableGradient & _G_grad;

  // Jumps
  VariableValue & _jump;

  // Coupled aux variables: topology
  VariableValue & _b;

  // Equation of state
  const EquationOfState & _eos;

  // material to compute
  MaterialProperty<Real> & _kappa;
  MaterialProperty<Real> & _kappa_max;
  MaterialProperty<Real> & _residual;
};

#endif /* ENTROPYVISCOSITYCOEFFICIENT_H */
