% Francisco Thiago de Oliveira Beviláqua
% Aguiar Felinto Filho

%   Para utilizar a função utilizando o octave basta ir na janela 
% de comando e informar a matriz de restrições A, o indice de solu- 
% ção b e vetor de custo c e chamar a função simplex ou modificar 
% os valores das variaveis a baixo descomentar e no fim do arquivo 
% chamar a função passando as variaveis.

% Vetor de restrições da matriz
% A = [1 2 2 1 0 0; 2 1 2 0 1 0; 2 2 1 0 0 1];  
% Vetor solução
% b = [20 20 20]';
% Vetor custo
% c = [-10 -12 -12 0 0 0]';

function simplex_naive (A, b, c) 
    % Dimensões da Matriz
    m = size(A, 1); % Linhas
    n = size(A, 2); % Colunas

    %   Método para buscar primeiro ponto factível para aplicar 
    % o método simplex.
    do 
        %   Irá armazenar a permutação dos índices a 
        % partir do número de colunas.
        aux = randperm(n);
        %   Irá armezar vetor de índices da base de 
        % acordo com a quantidade de linhas e do vetor 
        % de indices de colunas aux.
        base = aux (1: m);
        %   Irá criar um vetor x preenchido com zeros com o 
        % tamanho da quantidade de colunas.
        x = zeros(n, 1);
        %   Irá criar uma matriz de acordo com valores da 
        % matriz de restriçãom A nas colunas com índices da 
        % base.
        B = A(:, base); 
        %   Vetor solução x apenas com indices da base e os 
        % demais assumindo o valor 0.  
        x(base) = inv(B) * b;
    until(isempty(find(x < 0)))

    while(true)
        %   Calcular vetor de custo reduzido para o 
        % novo valor de x.
        custo_reduzido = c' - c(base)' * inv(B) * A;
        %   Atribuindo 0 ao vetor de custos_reduzidos 
        % no indice da base para reduzir chances de erro.
        custo_reduzido(base) = 0;
        %   Armazena índices onde valores são menores que 
        % zero e são candidatos a j.
        candidados_a_j = find(custo_reduzido < 0);
        %   Verfica se no vetor custo reduzido não contém
        % algum valor menor que 0.  
        if(isempty(candidados_a_j))
            disp("Solução com custo tendendo ao Infinito.");
            disp("Não existe solução ótima");
            %   Para o Algoritmo, porque foi encontrado  
            % valor ótimo.
            break;
        else
            %   Pega o primeiro valor negativo para ser
            % otimizado.
            j = candidados_a_j(1);
        end
        % Cria vetor direcao preenchido por 0.
        d = zeros(n, 1);
        % Adiciona 1 no vetor direcao na posicao j.
        d(j) = 1;
        %   Modifica vetor direcao nos indices da base para 
        % buscar uma nova direcao que indiqueum novo vertice 
        % do poliedro.
        d(base) = -inv(B) * A(:, j);
        % Armazena os indices da base que tem valor negativo.
        cadidatos_theta = find(d(base) < 0);
        if (isempty(cadidatos_theta) == 1)
            disp("Solução Ótima encontrada.");
            break;
        end 
        % Armazena os indices do candidatos a partir da base.
        index_base_candidatos = base(cadidatos_theta);
        % Encontrar o valor do theta e do seu indice.
        [theta, indice_do_theta] = min(-x(index_base_candidatos)
                                        ./d(index_base_candidatos));
        %   Armazena em l o indice do theta a partir do vetor 
        % de candidatos.
        l = cadidatos_theta(indice_do_theta);
        % Calcula novo vetor x.
        x = x + theta * d;
        %   Atualiza o indice da base na posicao adicionando 
        % j na posicao l da base.
        base(l) = j;
        % Atualiza a Base com os novos valores.
        B = A(:, base);
    end
    disp('x Ótimo = '), disp(x');
    disp('Custo Ótimo = '), disp(c' * x);
end

% simplex_naive(A, b, c)