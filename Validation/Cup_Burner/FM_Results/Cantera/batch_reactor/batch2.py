# Adiabatic, constant volume batch reactor.

import cantera           as ct
import numpy             as np
import matplotlib.pyplot as plt
from   scipy import integrate
import csv
import time

#----------------------------------------------------

timer_start = time.perf_counter()

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

plt.subplot(3,2,1)
plt.plot(times,T)
plt.xlabel('Time (s)')
plt.ylabel('T (K)')

plt.subplot(3,2,2)
plt.plot(times,P)
plt.xlabel('Time (s)')
plt.ylabel('P (Pa)')

plt.subplot(3,2,3)
plt.plot(times,X[:,gas.species_index("CH4")], label="CH4")
plt.plot(times,X[:,gas.species_index("O2")], label="O2")
plt.plot(times,X[:,gas.species_index("H2O")], label="H2O")
plt.plot(times,X[:,gas.species_index("CO2")], label="CO2")
plt.xlabel('Time (s)')
plt.ylabel('X')
leg = plt.legend(); leg.draw_frame(False)

plt.subplot(3,2,4)
plt.plot(times,X[:,gas.species_index("CH3")], label="CH3")
plt.plot(times,X[:,gas.species_index("CO")], label="CO")
plt.plot(times,X[:,gas.species_index("H2")], label="H2")
plt.xlabel('Time (s)')
plt.ylabel('X')
leg = plt.legend(); leg.draw_frame(False)

plt.subplot(3,2,5)
plt.plot(times,X[:,gas.species_index("OH")], label="OH")
plt.plot(times,X[:,gas.species_index("HO2")], label="HO2")
plt.plot(times,X[:,gas.species_index("H2O2")], label="H2O2")
plt.xlabel('Time (s)')
plt.ylabel('X')
leg = plt.legend(); leg.draw_frame(False)

plt.subplot(3,2,6)
plt.plot(times,X[:,gas.species_index("H")], label="H")
plt.plot(times,X[:,gas.species_index("O")], label="O")
plt.plot(times,X[:,gas.species_index("HCO")], label="HCO")
plt.plot(times,X[:,gas.species_index("CH2O")], label="CH2O")
plt.xlabel('Time (s)')
plt.ylabel('X')
leg = plt.legend(); leg.draw_frame(False)

plt.tight_layout()

plt.show()

#---------- write results to csv file

header = ['Time (s)', 'T (K)', 'P (Pa)']
for i in range(len(gas.species())):
	header.append('X_'+gas.species(i).name)

# open the file in the write mode
f = open('test.csv', 'w')

# create the csv writer
writer = csv.writer(f)

writer.writerow(header)

for i in range(len(times)):
	# write the data
	data = [times[i], T[i], P[i]]
	for j in range(len(X[i])):
		data.append(X[i][j])

	writer.writerow(data)

# close the file
f.close()

print(time.perf_counter()-timer_start)



