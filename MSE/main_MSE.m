clear; close all; clc

X = randi([-100 100], 1, 1000);

Y = coarse_graining(X,4);