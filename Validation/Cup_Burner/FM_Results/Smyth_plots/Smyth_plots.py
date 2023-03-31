import numpy as np
import matplotlib.pyplot as plt
import pandas as pd

#----------------------------------------------------

Smyth_fds = pd.read_csv('Smyth_fds.csv')
Smyth_exp = pd.read_csv('Smyth_exp.csv')

fig, ax = plt.subplots()
ax.plot(Smyth_exp.loc[:,'X'],Smyth_exp.loc[:,'S T 7'],'ro',mfc='none',label='Exp 7')
ax.plot(Smyth_fds.loc[:,'X'],Smyth_fds.loc[:,'FDS T 7'],'r-',label='FDS 7')
ax.plot(Smyth_exp.loc[:,'X'],Smyth_exp.loc[:,'S T 9'],'go',mfc='none',label='Exp 9')
ax.plot(Smyth_fds.loc[:,'X'],Smyth_fds.loc[:,'FDS T 9'],'g-',label='FDS 9')
ax.plot(Smyth_exp.loc[:,'X'],Smyth_exp.loc[:,'S T 11'],'bo',mfc='none',label='Exp 11')
ax.plot(Smyth_fds.loc[:,'X'],Smyth_fds.loc[:,'FDS T 11'],'b-',label='FDS 11')
handles1, labels1 = ax.get_legend_handles_labels()
plt.legend(handles1, labels1, fontsize=8.5)
ax.set_xlabel('x (m)')
ax.set_ylabel('T ($\degree$C)')

plt.savefig("Smyth_T.pdf")
plt.close()

fig, ax = plt.subplots()
ax.plot(Smyth_exp.loc[:,'X'],Smyth_exp.loc[:,'S CH4 7'],'ro',mfc='none',label='Exp CH_4$  7')
ax.plot(Smyth_fds.loc[:,'X'],Smyth_fds.loc[:,'FDS CH4 7'],'r-',label='FDS CH_4$  7')
ax.plot(Smyth_exp.loc[:,'X'],Smyth_exp.loc[:,'S CH4 9'],'go',mfc='none',label='Exp CH_4$  9')
ax.plot(Smyth_fds.loc[:,'X'],Smyth_fds.loc[:,'FDS CH4 9'],'g-',label='FDS CH_4$  9')
ax.plot(Smyth_exp.loc[:,'X'],Smyth_exp.loc[:,'S CH4 11'],'bo',mfc='none',label='Exp CH_4$  11')
ax.plot(Smyth_fds.loc[:,'X'],Smyth_fds.loc[:,'FDS CH4 11'],'b-',label='FDS CH_4$ 11')

ax.plot(Smyth_exp.loc[:,'X'],Smyth_exp.loc[:,'S O2 7'],'co',mfc='none',label='Exp O$_2$  7')
ax.plot(Smyth_fds.loc[:,'X'],Smyth_fds.loc[:,'FDS O2 7'],'c-',label='FDS O$_2$  7')
ax.plot(Smyth_exp.loc[:,'X'],Smyth_exp.loc[:,'S O2 9'],'mo',mfc='none',label='Exp O$_2$  9')
ax.plot(Smyth_fds.loc[:,'X'],Smyth_fds.loc[:,'FDS O2 9'],'m-',label='FDS O$_2$  9')
ax.plot(Smyth_exp.loc[:,'X'],Smyth_exp.loc[:,'S O2 11'],'ko',mfc='none',label='Exp O$_2$  11')
ax.plot(Smyth_fds.loc[:,'X'],Smyth_fds.loc[:,'FDS O2 11'],'k-',label='FDS O$_2$ 11')


handles1, labels1 = ax.get_legend_handles_labels()
plt.legend(handles1, labels1, fontsize=8.5)
ax.set_xlabel('x (m)')
ax.set_ylabel('Gas Concentration (mol/mol)')

plt.savefig("Smyth_F+O.pdf")
plt.close()

fig, ax = plt.subplots()
ax.plot(Smyth_exp.loc[:,'X'],Smyth_exp.loc[:,'S CO 7'],'ro',mfc='none',label='Exp 7')
ax.plot(Smyth_fds.loc[:,'X'],Smyth_fds.loc[:,'FDS CO 7'],'r-',label='FDS 7')
ax.plot(Smyth_exp.loc[:,'X'],Smyth_exp.loc[:,'S CO 9'],'go',mfc='none',label='Exp 9')
ax.plot(Smyth_fds.loc[:,'X'],Smyth_fds.loc[:,'FDS CO 9'],'g-',label='FDS 9')
ax.plot(Smyth_exp.loc[:,'X'],Smyth_exp.loc[:,'S CO 11'],'bo',mfc='none',label='Exp 11')
ax.plot(Smyth_fds.loc[:,'X'],Smyth_fds.loc[:,'FDS CO 11'],'b-',label='FDS 11')
handles1, labels1 = ax.get_legend_handles_labels()
plt.legend(handles1, labels1, fontsize=8.5)
ax.set_xlabel('x (m)')
ax.set_ylabel('CO (mol/mol)')

plt.savefig("Smyth_CO.pdf")
plt.close()

fig, ax = plt.subplots()
ax.plot(Smyth_exp.loc[:,'X'],Smyth_exp.loc[:,'S CO2 7'],'ro',mfc='none',label='Exp 7')
ax.plot(Smyth_fds.loc[:,'X'],Smyth_fds.loc[:,'FDS CO2 7'],'r-',label='FDS 7')
ax.plot(Smyth_exp.loc[:,'X'],Smyth_exp.loc[:,'S CO2 9'],'go',mfc='none',label='Exp 9')
ax.plot(Smyth_fds.loc[:,'X'],Smyth_fds.loc[:,'FDS CO2 9'],'g-',label='FDS 9')
ax.plot(Smyth_exp.loc[:,'X'],Smyth_exp.loc[:,'S CO2 11'],'bo',mfc='none',label='Exp 11')
ax.plot(Smyth_fds.loc[:,'X'],Smyth_fds.loc[:,'FDS CO2 11'],'b-',label='FDS 11')
handles1, labels1 = ax.get_legend_handles_labels()
plt.legend(handles1, labels1, fontsize=8.5)
ax.set_xlabel('x (m)')
ax.set_ylabel('CO$_2$ (mol/mol)')

plt.savefig("Smyth_CO2.pdf")
plt.close()

fig, ax = plt.subplots()
ax.plot(Smyth_exp.loc[:,'X'],Smyth_exp.loc[:,'S H2 9'],'ro',mfc='none',label='Exp H$_2$')
ax.plot(Smyth_fds.loc[:,'X'],Smyth_fds.loc[:,'FDS H2 9'],'r-',label='FDS H$_2$')
ax.plot(Smyth_exp.loc[:,'X'],Smyth_exp.loc[:,'S H 9']*10,'go',mfc='none',label='Exp H x10')
ax.plot(Smyth_fds.loc[:,'X'],Smyth_fds.loc[:,'FDS H 9']*10,'g-',label='FDS H x10')
ax.plot(Smyth_exp.loc[:,'X'],Smyth_exp.loc[:,'S CH3 9'],'bo',mfc='none',label='Exp CH3')
ax.plot(Smyth_fds.loc[:,'X'],Smyth_fds.loc[:,'FDS CH3 9'],'b-',label='FDS CH3')
ax.plot(Smyth_exp.loc[:,'X'],Smyth_exp.loc[:,'S O 9']*10,'co',mfc='none',label='Exp O x10')
ax.plot(Smyth_fds.loc[:,'X'],Smyth_fds.loc[:,'FDS O 9']*10,'c-',label='FDS O x10')
handles1, labels1 = ax.get_legend_handles_labels()
plt.legend(handles1, labels1, fontsize=8.5)
ax.set_xlabel('x (m)')
ax.set_ylabel('9 mm Gas Concentration (mol/mol)')

plt.savefig("Smyth_FR.pdf")
plt.close()