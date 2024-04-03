# -*- coding: utf-8 -*-
"""
Spyder Editor

This is a temporary script file.
"""
###hddm version__ = 0.6.0

import pandas as pd
import matplotlib.pyplot as plt
import hddm
import seaborn as sns
import matplotlib.pyplot as plt

data = hddm.load_csv('H:\\HDDM\\C3_data_hddm\\c3_phase3_new.csv')
#data2 = hddm.load_csv('E:\\HDDM\\demo_hddm.csv')


m = hddm.HDDM(data, depends_on={'v': 'stim','a':'stim'})#####
m.find_starting_values()
m.sample(10000, burn=1000)

stats = m.gen_stats()


models = []
for i in range(3):
    m1 = hddm.HDDM(data, depends_on={'v': 'stim','a':'stim'})
    m1.find_starting_values()
    m1.sample(10000, burn=1000)
    models.append(m1)

Gelman_Rubin_statistic_results = hddm.analyze.gelman_rubin(models)
df = pd.DataFrame([Gelman_Rubin_statistic_results])



###Bayesian inference test
print("P(1 > 2) = ", (v_1.trace() > v_2.trace()).mean())

####################trace
#visaul check for trace：  no drifts or large jumps in the trace. The autocorrelation is also very low
m.plot_posteriors(['a', 't', 'v', 'a_std','v_std','t_std'])
m.plot_posteriors(['a_subj'])
m.plot_posteriors(['v_subj'])
m.plot_posteriors(['t_subj'])



################plot PPC of compatible and incompatibe conditiions
compatiable_conditions, incompatiable_conditions = m.nodes_db.node[['v(1)', 'v(2)']]
hddm.analyze.plot_posterior_nodes([compatiable_conditions, incompatiable_conditions])
plt.xlabel('drift-rate')
plt.ylabel('Posterior probability')
plt.title('Posterior of drift-rate group means')
plt.savefig('hddm_phase3.pdf')





#####Posterior Predictive Checks
ppc_data = hddm.utils.post_pred_gen(m,append_data=True)


sns.distplot(ppc_data.rt_sampled,label='simulated data',hist=False,kde=True,kde_kws = {'shade':True,'linewidth':3},hist_kws={'edgecolor':'black'})
sns.distplot(ppc_data.rt,label='observed data',hist=False,kde=True,kde_kws = {'shade':True,'linewidth':3},hist_kws={'edgecolor':'black'})
plt.savefig('hddm_phase3_simulated_observed.pdf')


ppc_compare = hddm.utils.post_pred_stats(data, ppc_data)






















