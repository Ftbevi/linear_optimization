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

% criar vetor b
b = zeros(1, disciplinas_m);
for i = 1: disciplinas_m
  b(1, i) = 1;
endfor
c(1:50) = [8 8 7 9 2 8 1 2 7 3 10 7 7 9 5 10 8 8 10 3 10 5 5 7 5 6 10 2 7 9 5 8 10 5 2 8 8 9 3 4 5 8 10 5 1 7 1 1 1 6]';

% carregar vetor c
%aux = load('alocacao.txt')
%c = zeros(1, disciplinas_m * professores_n);
%for i = 1: disciplinas_m
%  for j = 1: professores_n
%    c.(aux(i, j);)
%  endfor
%endfor

A;
b;
c;

[x_otimo, custo_otimo] =  [x_otimo, custo_reduzido] = glpk(-c,A,b)
