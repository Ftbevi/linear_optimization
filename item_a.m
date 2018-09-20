clear all;
clc;

disciplinas_m = 10;
professores_n = 5;
% criar matrix a
A = zeros(disciplinas_m, disciplinas_m * professores_n);
marcador = 0;
for i = 1: disciplinas_m
  for j = 1:professores_n
    A(i, j + marcador) = 1;
  endfor
   marcador += 5;
endfor
A

% criar vetor b
b = zeros(1, disciplinas_m);
for i = 1: disciplinas_m
  b(1, i) = 1;
endfor
b

% carregar vetor c
aux = load('alocacao.txt')
c = zeros(1, disciplinas_m * professores_n);
for i = 1: disciplinas_m * professores_n
  c(1, i)= aux(i);
endfor
c