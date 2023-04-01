# Adiabatic, constant volume batch reactor.

import cantera           as ct
import numpy             as np
import matplotlib.pyplot as plt
import pandas as pd
from   scipy import integrate

#----------------------------------------------------

fds1000_data = pd.read_csv('../fds_batch/CH4/CH4_skeleton_ST_1000a_devc.csv',skiprows=1)
fds800_data = pd.read_csv('../fds_batch/CH4/CH4_skeleton_ST_800a_devc.csv',skiprows=1)

T0 = 1273.15
P0  = 101325.0
X0 = "CH4:1,O2:2,N2:7.652174"
tend = 0.1
steps = 1000

gas = ct.Solution("smooke_1.yaml")
gas.TPX = T0,P0,X0

r = ct.Reactor(gas)
sim=ct.ReactorNet([r])

gas()

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

#---------- plot results

fig, ax = plt.subplots()
ax.plot(times,T,'bo',markevery=20,mfc='none',label='Ct')
ax.plot(fds1000_data.loc[:,'Time'],fds1000_data.loc[:,'T']+273.15,'b-',label='FDS')
handles1, labels1 = ax.get_legend_handles_labels()
plt.legend(handles1, labels1, fontsize=8.5)
fig.suptitle('1000 $\degree$C, No Sodium')
ax.set_xlabel('Time (s)')
ax.set_ylabel('T (K)')

plt.savefig("plots/1000Ta.pdf")
plt.close()

fig, ax = plt.subplots()
ax.plot(times,P,'bo',markevery=20,mfc='none',label='Ct')
ax.plot(fds1000_data.loc[:,'Time'],fds1000_data.loc[:,'P']+101325.,'b-',label='FDS')
handles1, labels1 = ax.get_legend_handles_labels()
plt.legend(handles1, labels1, fontsize=8.5)
fig.suptitle('1000 $\degree$C, No Sodium')
ax.set_xlabel('Time (s)')
ax.set_ylabel('P (Pa)')
plt.savefig("plots/1000Pa.pdf")
plt.close()

fig, ax = plt.subplots()
ax.plot(times,X[:,gas.species_index("CO2")],'ro',markevery=20,mfc='none',label='Ct CO2')
ax.plot(fds1000_data.loc[:,'Time'],fds1000_data.loc[:,'CO2'],'r-',label='FDS CO2')
ax.plot(times,X[:,gas.species_index("CO")],'go',markevery=20,mfc='none',label='Ct CO')
ax.plot(fds1000_data.loc[:,'Time'],fds1000_data.loc[:,'CO'],'g-',label='FDS CO')
ax.plot(times,X[:,gas.species_index("H2O")],'bo',markevery=20,mfc='none',label='Ct H2O')
ax.plot(fds1000_data.loc[:,'Time'],fds1000_data.loc[:,'H2O'],'b-',label='FDS H2O')
handles1, labels1 = ax.get_legend_handles_labels()
plt.legend(handles1, labels1, fontsize=8.5)
fig.suptitle('1000 $\degree$C, No Sodium')
ax.set_xlabel('Time (s)')
ax.set_ylabel('Mole fraction (mol/mol)')
plt.savefig("plots/1000G1a.pdf")
plt.close()

fig, ax = plt.subplots()
ax.plot(times,X[:,gas.species_index("OH")],'ro',markevery=20,mfc='none',label='Ct OH')
ax.plot(fds1000_data.loc[:,'Time'],fds1000_data.loc[:,'OH'],'r-',label='FDS OH')
ax.plot(times,X[:,gas.species_index("H2")],'go',markevery=20,mfc='none',label='Ct H2')
ax.plot(fds1000_data.loc[:,'Time'],fds1000_data.loc[:,'H2'],'g',label='FDS H2')
ax.plot(times,X[:,gas.species_index("H")],'bo',markevery=20,mfc='none',label='Ct H')
ax.plot(fds1000_data.loc[:,'Time'],fds1000_data.loc[:,'H'],'b-',label='FDS H')
ax.plot(times,X[:,gas.species_index("O")],'mo',markevery=20,mfc='none',label='Ct O')
ax.plot(fds1000_data.loc[:,'Time'],fds1000_data.loc[:,'O'],'m-',label='FDS O')
handles1, labels1 = ax.get_legend_handles_labels()
plt.legend(handles1, labels1, fontsize=8.5)
fig.suptitle('1000 $\degree$C, No Sodium')
ax.set_xlabel('Time (s)')
ax.set_ylabel('Mole fraction (mol/mol)')
plt.savefig("plots/1000G2a.pdf")
plt.close()

T0 = 1073.15
P0  = 101325.0
X0 = "CH4:1,O2:2,N2:7.652174"
tend = 2.
steps = 1000

gas = ct.Solution("smooke_1.yaml")
gas.TPX = T0,P0,X0

r = ct.Reactor(gas)
sim=ct.ReactorNet([r])

gas()

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

#---------- plot results

fig, ax = plt.subplots()
ax.plot(times,T,'bo',markevery=20,mfc='none',label='Ct')
ax.plot(fds800_data.loc[:,'Time'],fds800_data.loc[:,'T']+273.15,'b-',label='FDS')
handles1, labels1 = ax.get_legend_handles_labels()
plt.legend(handles1, labels1, fontsize=8.5)
ax.set_xlabel('Time (s)')
ax.set_ylabel('T (K)')
fig.suptitle('800 $\degree$C, No Sodium')
plt.savefig("plots/800Ta.pdf")
plt.close()

fig, ax = plt.subplots()
ax.plot(times,P,'bo',markevery=20,mfc='none',label='Ct')
ax.plot(fds800_data.loc[:,'Time'],fds800_data.loc[:,'P']+101325.,'b-',label='FDS')
handles1, labels1 = ax.get_legend_handles_labels()
plt.legend(handles1, labels1, fontsize=8.5)
fig.suptitle('800 $\degree$C, No Sodium')
ax.set_xlabel('Time (s)')
ax.set_ylabel('P (Pa)')
plt.savefig("plots/800Pa.pdf")
plt.close()

fig, ax = plt.subplots()
ax.plot(times,X[:,gas.species_index("CO2")],'ro',markevery=20,mfc='none',label='Ct CO2')
ax.plot(fds800_data.loc[:,'Time'],fds800_data.loc[:,'CO2'],'r-',label='FDS CO2')
ax.plot(times,X[:,gas.species_index("CO")],'go',markevery=20,mfc='none',label='Ct CO')
ax.plot(fds800_data.loc[:,'Time'],fds800_data.loc[:,'CO'],'g-',label='FDS CO')
ax.plot(times,X[:,gas.species_index("H2O")],'bo',markevery=20,mfc='none',label='Ct H2O')
ax.plot(fds800_data.loc[:,'Time'],fds800_data.loc[:,'H2O'],'b-',label='FDS H2O')
handles1, labels1 = ax.get_legend_handles_labels()
plt.legend(handles1, labels1, fontsize=8.5)
fig.suptitle('800 $\degree$C, No Sodium')
ax.set_xlabel('Time (s)')
ax.set_ylabel('Mole fraction (mol/mol)')
plt.savefig("plots/800G1a.pdf")
plt.close()

fig, ax = plt.subplots()
ax.plot(times,X[:,gas.species_index("OH")],'ro',markevery=20,mfc='none',label='Ct OH')
ax.plot(fds800_data.loc[:,'Time'],fds800_data.loc[:,'OH'],'r-',label='FDS OH')
ax.plot(times,X[:,gas.species_index("H2")],'go',markevery=20,mfc='none',label='Ct H2')
ax.plot(fds800_data.loc[:,'Time'],fds800_data.loc[:,'H2'],'g',label='FDS H2')
ax.plot(times,X[:,gas.species_index("H")],'bo',markevery=20,mfc='none',label='Ct H')
ax.plot(fds800_data.loc[:,'Time'],fds800_data.loc[:,'H'],'b-',label='FDS H')
ax.plot(times,X[:,gas.species_index("O")],'mo',markevery=20,mfc='none',label='Ct O')
ax.plot(fds800_data.loc[:,'Time'],fds800_data.loc[:,'O'],'m-',label='FDS O')
handles1, labels1 = ax.get_legend_handles_labels()
plt.legend(handles1, labels1, fontsize=8.5)
fig.suptitle('800 $\degree$C, No Sodium')
ax.set_xlabel('Time (s)')
ax.set_ylabel('Mole fraction (mol/mol)')
plt.savefig("plots/800G2a.pdf")
plt.close()