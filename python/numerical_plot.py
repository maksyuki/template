#!/usr/bin/python
#title          :main.py
#author         :Yuchi Miao
#date           :2016/3/14 23:34:40
#python_version	:2.7.6
#version        :1.0
#description    :Use the numerical integration method to solve the first order 
#                differential equation of continuous system
#notes          :Euler Method, Runge_Kutta Method and Predictor Corrector Method
#==============================================================================

import math
import numpy as np
import matplotlib.pyplot as plt

def get_analytical_solution(t):
    return 1.0 / (2 * math.exp(t) - t - 1)

def org_func(t, y):
    return -y - t * y * y

#======Original======
x = np.linspace(0, 5, 50, endpoint=True)
get_analytical_solution_all = np.vectorize(get_analytical_solution, otypes=[np.float])
y1 = get_analytical_solution_all(x)

h = 0.1     #set the step size

#======Euler Method======
y2 = np.zeros(50, np.float)
yx = -1.0
cnt = 0
for i in x:
    if(cnt == 0):
        y2[cnt] = 1.0
    else:
        y2[cnt] = yx + h * org_func(i, yx)
    yx = y2[cnt]
    cnt = cnt + 1

#======Runge_Kutta Method======
y3 = np.zeros(50, np.float)
k = np.zeros(8, np.float)
cnt = 0
for i in x:
    if(cnt == 0):
        y3[cnt] = 1.0;
    else:
        k[1] = org_func(i, yx)
        k[2] = org_func(i + h / 2.0, yx + h / 2.0 * k[1])
        k[3] = org_func(i + h / 2.0, yx + h / 2.0 * k[2])
        k[4] = org_func(i + h, yx + h * k[3]) 
        y3[cnt] = yx + h / 6.0 * (k[1] + 2 * k[2] + 2 * k[3] + k[4])
    yx = y3[cnt]
    cnt = cnt + 1

#======Predictor Corrector Method======
y4 = np.zeros(50, np.float)
yx = -1.0
yi1 = -1.0
yi2 = -1.0
cnt = 0
for i in x:
    if(cnt == 0):
        y4[cnt] = 1.0
    else:
        yi2 = -1.0
        yi1 = yx + h * org_func(x[cnt-1], yx)
        while(math.fabs (yi2 - yi1) > 1e-5):
            yi2 = yi1
            yi1 = yx + h / 2.0 * (org_func(x[cnt-1], yx) + org_func(i, yi2))
    if(cnt >= 1):
        y4[cnt] = yi2
    yx = y4[cnt]
    cnt = cnt + 1

plt.figure(2)
plt.figure(1)
#plt.xticks(fontsize=66) 
#plt.yticks(fontsize=66)
#======Draw======
plt.plot(x, y1, "r", label="Original")
plt.plot(x, y2, "b", label="Euler Method")
plt.plot(x, y3, "g", label="Runge-Kutta Method")
plt.plot(x, y4, "k", label="Predictor Corrector Method")
plt.xlabel("$t$", fontsize=20)
plt.ylabel("$x(t)$", fontsize=20)
plt.title("Correlation curve(step size = 0.1)")
plt.legend()
#plt.show()
#print (y4)

#======Draw difference curve======
dy2 = np.fabs(y2 - y1)
dy3 = np.fabs(y3 - y1)
dy4 = np.fabs(y4 - y1)
plt.figure(2)
#plt.plot(x, y1, "r", label="Original")
plt.plot(x, dy2, "b", label="Euler Method")
plt.plot(x, dy3, "g", label="Runge-Kutta Method")
plt.plot(x, dy4, "k", label="Predictor Corrector Method")
plt.xlabel("$t$", fontsize=20)
plt.ylabel("$x(t)$", fontsize=20)
plt.title("Absolute difference correlation curve(step size = 0.1)")
plt.legend()
plt.show()

