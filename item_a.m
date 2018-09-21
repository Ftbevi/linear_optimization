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
b = ones(1, disciplinas_m);

% carregar vetor c
aux = load('alocacao.txt');
c = zeros(1, disciplinas_m * professores_n);
marcador_aux = 0;
for i = 1: disciplinas_m
  for j = 1: professores_n
    marcador_aux+=1;
    c(1,marcador_aux) = (aux(i, j));
  endfor
endfor

% Metodo simplex
%   No metodo e colocado -c para que o problema se torne
% de maximizacao.
[x_otimo, custo_reduzido] = glpk(-c,A,b);

% Mostra x no ponto otimo e custo reduzido.
x_otimo'
custo_reduzido