# Adiabatic, constant volume batch reactor.

import cantera           as ct
import numpy             as np
import matplotlib.pyplot as plt
import pandas as pd
from   scipy import integrate

#----------------------------------------------------

T0 = 1273.15
P0  = 101325.0
X0 = "CH4:1,O2:2,N2:7.652174"
tend = 0.1
steps = 1000

gas = ct.Solution("smooke_1.yaml")
gas.TPX = T0,P0,X0

r = ct.Reactor(gas)
sim=ct.ReactorNet([r])

sim.rtol = 1e-6
sim.atol = 1e-15

gas()

# results with steps=1000

times = np.linspace(0.0,tend,steps)
T = np.zeros(steps)
P = np.zeros(steps)
length = len(gas.species())
print(length)
print(type(length))
X = np.zeros((steps,len(gas.species())))

t = 0.0
dt = tend/steps
for i in range(steps) :
	t = t + dt
	sim.advance(t)
	X[i,:] =gas.X[:]
	T[i] = gas.T
	P[i] = gas.P

gas()

# results with steps=100000

steps2=100000

gas = ct.Solution("smooke_1.yaml")
gas.TPX = T0,P0,X0

r = ct.Reactor(gas)
sim=ct.ReactorNet([r])

sim.rtol = 1e-6
sim.atol = 1e-15

times2 = np.linspace(0.0,tend,steps2)
T2 = np.zeros(steps2)
P2 = np.zeros(steps2)
length = len(gas.species())
print(length)
print(type(length))
X2 = np.zeros((steps2,len(gas.species())))

t = 0.0
dt = tend/steps2
for i in range(steps2) :
	t = t + dt
	sim.advance(t)
	X2[i,:] =gas.X[:]
	T2[i] = gas.T
	P2[i] = gas.P

gas()

#---------- plot results

fig, ax = plt.subplots()
ax.plot(times,T,'b-',markevery=20,mfc='none',label='Cantera 10$^3$ steps')
ax.plot(times2,T2,'b--',markevery=20,mfc='none',label='Cantera 10$^5$ steps')
handles1, labels1 = ax.get_legend_handles_labels()
plt.legend(handles1, labels1, fontsize=8.5)
fig.suptitle('Batch Reactor: CH4/Air, 1000 $\degree$C, No Sodium')
ax.set_xlabel('Time (s)')
ax.set_ylabel('T (K)')

plt.savefig("plots/1000T_steps.pdf")
plt.close()

fig, ax = plt.subplots()
ax.plot(times,P,'b-',markevery=20,mfc='none',label='Cantera 10$^3$ steps')
ax.plot(times2,P2,'b--',markevery=20,mfc='none',label='Cantera 10$^5$ steps')
handles1, labels1 = ax.get_legend_handles_labels()
plt.legend(handles1, labels1, fontsize=8.5)
fig.suptitle('Batch Reactor: CH4/Air, 1000 $\degree$C, No Sodium')
ax.set_xlabel('Time (s)')
ax.set_ylabel('P (Pa)')
plt.savefig("plots/1000P_steps.pdf")
plt.close()

fig, ax = plt.subplots()
ax.plot(times,X[:,gas.species_index("CO2")],'r-',markevery=20,mfc='none',label='Ct CO2 10$^3$')
ax.plot(times2,X2[:,gas.species_index("CO2")],'r--',markevery=20,mfc='none',label='Ct CO2 10$^5$')
ax.plot(times,X[:,gas.species_index("CO")],'g-',markevery=20,mfc='none',label='Ct CO 10$^3$')
ax.plot(times2,X2[:,gas.species_index("CO")],'g--',markevery=20,mfc='none',label='Ct CO 10$^5$')
ax.plot(times,X[:,gas.species_index("H2O")],'b-',markevery=20,mfc='none',label='Ct H2O 10$^3$')
ax.plot(times2,X2[:,gas.species_index("H2O")],'b--',markevery=20,mfc='none',label='Ct H2O 10$^5$')
handles1, labels1 = ax.get_legend_handles_labels()
plt.legend(handles1, labels1, fontsize=8.5)
fig.suptitle('Batch Reactor: CH4/Air, 1000 $\degree$C, No Sodium')
ax.set_xlabel('Time (s)')
ax.set_ylabel('Mole fraction (mol/mol)')
plt.savefig("plots/1000G1_steps.pdf")
plt.close()

fig, ax = plt.subplots()
ax.plot(times,X[:,gas.species_index("OH")],'r-',markevery=20,mfc='none',label='Ct OH 10$^3$')
ax.plot(times2,X2[:,gas.species_index("OH")],'r--',markevery=20,mfc='none',label='Ct OH 10$^5$')
ax.plot(times,X[:,gas.species_index("H2")],'g-',markevery=20,mfc='none',label='Ct H2 10$^3$')
ax.plot(times2,X2[:,gas.species_index("H2")],'g--',markevery=20,mfc='none',label='Ct H2 10$^5$')
ax.plot(times,X[:,gas.species_index("H")],'b-',markevery=20,mfc='none',label='Ct H 10$^3$')
ax.plot(times2,X2[:,gas.species_index("H")],'b--',markevery=20,mfc='none',label='Ct H 10$^5$')
ax.plot(times,X[:,gas.species_index("O")],'m-',markevery=20,mfc='none',label='Ct O 10$^3$')
ax.plot(times2,X2[:,gas.species_index("O")],'m--',markevery=20,mfc='none',label='Ct O 10$^5$')
handles1, labels1 = ax.get_legend_handles_labels()
plt.legend(handles1, labels1, fontsize=8.5)
fig.suptitle('Batch Reactor: CH4/Air, 1000 $\degree$C, No Sodium')
ax.set_xlabel('Time (s)')
ax.set_ylabel('Mole fraction (mol/mol)')
plt.savefig("plots/1000G2_steps.pdf")
plt.close()

