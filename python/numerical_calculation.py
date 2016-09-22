#!/usr/bin/python
#filename       :numerical_calculation.py
#author         :Yuchi Miao
#created time   :2016/4/18 19:44:10
#last modified  :2016/9/22 11:28:18
#python_version	:2.7.6
#version        :1.0
#description    :use the numerical integration method(Runge_Kutta Method) to 
#                solve the first order differential equation of continuous 
#                system
#notes          :need to set the value in numerical extrapolate manually
#===========================================================================

import math
import numpy as np
import scipy.interpolate as itp
import matplotlib.pyplot as plt

v0 = 500
x0 = 674
y0 = 329
alpha0_ang = 1.5
theta0_ang = 26
Is = 2156
g = 9.801
P = 2.2
p0 = 5880
#t0 = 3

#======Machine Parameter======
vt = 420
yt0 = 14200
Dt0 = 32000
xt0 = math.sqrt(Dt0 ** 2 - (yt0 - y0) ** 2) + x0;

#=======Drag Coefficient======
alpha_tab1 = np.linspace(2, 10, 5, endpoint=True)
ma_tab1 = np.array([1.5, 2.1, 2.7, 3.3, 4.0])
cx_tab = np.array([[0.0430, 0.0511, 0.0651, 0.0847, 0.1120],
                   [0.0360, 0.0436, 0.0558, 0.0736, 0.0973],
                   [0.0308, 0.0372, 0.0481, 0.0641, 0.0849],
                   [0.0265, 0.0323, 0.0419, 0.0560, 0.0746],
                   [0.0222, 0.0272, 0.0356, 0.0478, 0.0644]])

#======Lift Coefficient======
alpha_tab2 = np.array([1, 2, 4, 6, 8, 10])
ma_tab2 = np.linspace(1.5, 4.0, 6, endpoint=True)
cy_tab = np.array([[0.0302, 0.0304, 0.0306, 0.0309, 0.0311, 0.0313],
                   [0.0279, 0.0280, 0.0284, 0.0286, 0.0288, 0.0290],
                   [0.0261, 0.0264, 0.0267, 0.0269, 0.0272, 0.0274],
                   [0.0247, 0.0248, 0.0251, 0.0254, 0.0257, 0.0259],
                   [0.0226, 0.0227, 0.0231, 0.0233, 0.0236, 0.0238],
                   [0.0209, 0.0210, 0.0213, 0.0216, 0.0219, 0.0221]])

#======Atmospheric Model(US1976)===
high_tab = np.linspace(0, 26000, 27, endpoint=True)
rho_tab = np.loadtxt("rho.txt")
speed_tab = np.loadtxt("speed.txt")

u = np.zeros(666666, np.float)
v = np.zeros(666666, np.float)
x = np.zeros(666666, np.float)
y = np.zeros(666666, np.float)
yy = np.zeros(666666, np.float)
t = np.zeros(666666, np.float)
alpha_ang = np.zeros(666666, np.float)
alpha_rad = np.zeros(666666, np.float)
theta_ang = np.zeros(666666, np.float)
theta_rad = np.zeros(666666, np.float)
cx = np.zeros(666666, np.float)
cy = np.zeros(666666, np.float)
Dr = np.zeros(666666, np.float)
xt = np.zeros(666666, np.float)
i = 1
u[i] = 0
xt[i] = xt0
x[i] = x0
y[i] = y0
yy[i] = yt0
t[i] = 0 
v[i] = v0
Dr[i] = Dt0
cotq0 = xt0 / yt0

c = itp.interp1d(high_tab, speed_tab)(y[i])
ma = v[i] / c 
alpha_ang[i] = alpha0_ang
alpha_rad[i] = alpha_ang[i] / 180.0 * math.pi
theta_ang[i] = theta0_ang
theta_rad[i] = theta_ang[i] / 180.0 * math.pi

def speed_func(u, v, p, cx, Is, p0, P, theta_rad):
    return (Is * 1.0 / (1 - u) - p * (v ** 2) * cx
            * Is * 1.0 / (2 * P * p0 * (1 - u))
            - Is * math.sin(theta_rad) / P)

def high_func(Is, v, theta_rad, P, g):
    return Is * v * math.sin(theta_rad) / (P * g)

def dis_func(Is, v, theta_rad, P, g):
    return Is * v * math.cos(theta_rad) / (P * g)
	
def numerator_func(Is, P, g, v, theta_rad, y, kv1, kv2, kv3, kv4):
    return (Is * 1.0 / (P * g) + (v * high_func(Is, v, theta_rad, P, g)
            - y * (kv1 + 2 * kv2 + 2 * kv3 + kv4) / 6.0) / ((v ** 2)
            * math.sin(theta_rad)))

def arc_func(u, theta_rad, Is, cotq0, v, vt, y, P, g, yt0, kv1, kv2, kv3, kv4):
    return ((vt * 1.0 / yt0) * numerator_func(Is, P, g, v, theta_rad, y
             , kv1, kv2, kv3, kv4)) / (1 + (cotq0 - (u * Is * vt) / (P
             * g * yt0)) * (1.0 / math.tan(theta_rad)))

def alpha_func(v, Is, theta_rad, P, p, cya, p0, u, kvv1, kvv2, kvv3, kvv4):
    return ((v * (kvv1 + 2 * kvv2 + 2 * kvv3 + kvv4) / 6.0 + Is 
             * math.cos(theta_rad) / P) / ((p * (v ** 2) * cya * Is)
             / (2 * P * p0 * (1 - u)) + Is / (1 - u)))

h = 1e-4  #set the step size
EPS = 1e-10
while(y[i] < yt0):
    p = itp.interp1d(high_tab, rho_tab)(y[i])
    c = itp.interp1d(high_tab, speed_tab)(y[i])
    if(alpha_ang[i] + EPS < alpha_tab1[0] or ma + EPS < ma_tab1[0]):
        cx[i] = 0.04
    else:
        cx[i] = (itp.interp2d(alpha_tab1, ma_tab1, cx_tab, kind="linear")
                (alpha_ang[i], ma))
    cy[i] = (180.0 / math.pi * itp.interp2d(alpha_tab2, ma_tab2, cy_tab
             , kind="linear")
            (alpha_ang[i], ma))
    ma = v[i] / c 

    kv1 = speed_func(u[i], v[i], p, cx[i], Is, p0, P, theta_rad[i])
    kv2 = speed_func(u[i] + h / 2.0, v[i] + h / 2.0 * kv1, p, cx[i]
                     , Is, p0, P, theta_rad[i])
    kv3 = speed_func(u[i] + h / 2.0, v[i] + h / 2.0 * kv2, p, cx[i]
                     , Is, p0, P, theta_rad[i])
    kv4 = speed_func(u[i] + h, v[i] + h * kv3, p, cx[i], Is, p0, P
                     , theta_rad[i])

    v[i+1] = v[i] + h / 6.0 * (kv1 + 2 * kv2 + 2 * kv3 + kv4)
    y[i+1] = y[i] + high_func(Is, v[i], theta_rad[i], P, g) * h
    x[i+1] = x[i] + dis_func(Is, v[i], theta_rad[i], P, g) * h

    kvv1 = arc_func(u[i], theta_rad[i], Is, cotq0, v[i], vt, y[i]
                    , P, g, yt0, kv1, kv2, kv3, kv4)
    kvv2 = arc_func(u[i] + h / 2.0, theta_rad[i] + h / 2.0 * kvv1
                    , Is, cotq0, v[i], vt, y[i], P, g, yt0, kv1
                    , kv2, kv3, kv4)
    kvv3 = arc_func(u[i] + h / 2.0, theta_rad[i] + h / 2.0 * kvv2
                    , Is, cotq0, v[i], vt, y[i], P, g, yt0, kv1
                    , kv2, kv3, kv4)
    kvv4 = arc_func(u[i] + h, theta_rad[i] + h * kvv3, Is, cotq0
                    , v[i], vt, y[i], P, g, yt0, kv1, kv2, kv3
                    , kv4)

    theta_rad[i+1] = theta_rad[i] + h / 6.0 * (kvv1 + 2 * kvv2 
                     + 2 * kvv3 + kvv4)
    theta_ang[i+1] = theta_rad[i+1] * 180.0 / math.pi
    alpha_rad[i] = alpha_func(v[i], Is, theta_rad[i], P, p, cy[i]
                              , p0, u[i], kvv1, kvv2, kvv3, kvv4)	
    alpha_ang[i+1] = alpha_rad[i] * 180.0 / math.pi
    cotq = cotq0 - u[i] * Is * vt / (P * g * yt0)
    xt[i+1] = cotq * yt0
    Dr[i+1] = math.sqrt((xt[i+1] - x[i+1]) ** 2 + (yt0 - y[i+1]) ** 2)
    u[i+1] = u[i] + h
    yy[i+1] = yt0
    t[i+1] = yt0 / vt * (cotq0 - cotq)
    i = i + 1
print(i)
print(u[i])
print(alpha_ang[i])
print("\n")
print(Dr[i])
print(y[i]-yt0)
print(xt[i]-x[i])
print(v[i])
print("\n")
print(Dr[i-1])
print(y[i-1]-yt0)
print(xt[i-1]-x[i-1])
print(v[i-1])

#plt.figure(1)
##plt.plot(x, y, "r")
#yy[0] = 15000
#plt.plot(x, y, "r")
#plt.plot(xt, yy, "b")
#plt.show()

