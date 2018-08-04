% Francisco Thiago de Oliveira Beviláqua

% Limpando variáveis e janela de comandos
clc; clear all;

% Vetor de restrições da matriz
A = [1 2 2 1 0 0; 
     2 1 2 0 1 0; 
     2 2 1 0 0 1];

% Vetor solução
b = [20 20 20]';

% Vetor custo
c = [-10 -12 -12 0 0 0]';

% Dimensões da Matriz
m = size(A, 1); % Linhas
n = size(A, 2); % Colunas


% Irá armazenar a permutação dos índices a 
    % partir do número de colunas.
aux = randperm(n); 

% Irá armezar vetor de índices da vetor_indeces_base de 
    % acordo com a quantidade de linhas e do aux.
base = aux (1: m);

% Irá criar um vetor x preenchido com zeros com o 
    % tamanho da quantidade de colunas.
x = zeros(n, 1);

% Irá criar uma matriz de acordo com valores da matriz 
    % de restrição nas colunas com índices da vetor_indeces_base.
B = A(:, base);
  
% Vetor x solução apenas com indices da vetor_indeces_base e os demais 
    % assumindo o valor 0.  
x(base) = inv(B) * b;

% Método para buscar primeiro ponto factível para aplicar 
    % o método simplex.
while (~isempty(find(x < 0))) 
  aux = randperm(n); 
  base = aux (1: m);
  x = zeros(n, 1);
  B = A(:, base);
  x(base) = inv(B) * b;
end

while(1)
  % Calcular vetor de custo reduzido para o novo valor de x.
  custo_reduzido = c' - c(base)' * inv(B) * A;
  
  %   Atribuindo 0 ao vetor de custos_reduzidos no indice da base
  % para reduzir chances de erro.
  custo_reduzido(base) = 0;

  % Armazena índices onde valores são menores que zero.
  candidados_a_j = find(custo_reduzido < 0);

  % Verfica se no vetor custo reduzido não contém algum
      % algum valor menor que 0.  
  if(isempty(candidados_a_j) == 1)
    disp("Solução com custo tendendo ao Infinito. Nao existe solucao otima");
    break; % Para o Algoritmo, porque foi encontrado valor ótimo.
  else
    j = candidados_a_j(1); % Pega o primeiro valor negativo para 
                                  % ser otimizado.
  end
  
  % Cria vetor direcao e atribui zeros.
  d = zeros(n, 1);
  
  % Adiciona 1 no vetor direcao na posicao j.
  d(j) = 1;
  
  %   Modifica vetor direcao nos indices da base para buscar um 
  % novo vertice do poliedro.
  d(base) = -inv(B) * A(:, j);

  % Verifca se o vetor u está vazio. Logo que se estiver vazio é 
      % sinal que não existe direção para continuar andando sem 
          % romper a restrição u >= 0.
  cadidatos_theta = find(d(base) < 0);
  if (isempty(cadidatos_theta) == 1)
    disp("Solucao Otima encontrada.");
    break;
  end 
  
  index_base_candidatos = base(cadidatos_theta);
  [theta, indice_do_theta] = min(-x(index_base_candidatos)
                                    ./d(index_base_candidatos));
                                    
  l = cadidatos_theta(indice_do_theta);
  
  % Calcula novo vetor x.
  x = x + theta * d;
  
  % Atualiza o indice da base na posicao adicionando j na posicao l da base.
  base(l) = j;
  
  % Atualiza a Base com os novos valores.
  B = A(:, base);
end

x_otimo = x 
custo_otimo = c' * x