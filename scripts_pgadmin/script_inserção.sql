-- SCHEMA: public

-- DROP SCHEMA IF EXISTS public ;

CREATE SCHEMA IF NOT EXISTS public
    AUTHORIZATION pg_database_owner;

COMMENT ON SCHEMA public
    IS 'standard public schema';

GRANT USAGE ON SCHEMA public TO PUBLIC;

GRANT ALL ON SCHEMA public TO pg_database_owner;

-- Inserção de Serviços
insert into SERVICO (nome_servico, tipo_servico)
values 
('Transporte', 'Logística'),
('Guindaste', 'Equipamento Pesado'),
('Mudança', 'Serviço de Carga'),
('Carregamento', 'Logística'),
('Descarregamento', 'Logística'),
('Transporte Urgente', 'Logística'),
('Mudança Residencial', 'Serviço de Carga'),
('Mudança Comercial', 'Serviço de Carga'),
('Transporte de Carga Pesada', 'Logística'),
('Embalagem', 'Serviço de Carga');

-- Inserção de Empresas
insert into EMPRESA (nome_empresa, endereco)
values 
('Empresa A', 'Rua A, 100, São Paulo'),
('Empresa B', 'Rua B, 200, Rio de Janeiro'),
('Empresa C', 'Av. Rio Branco, 300, Salvador'),
('Empresa D', 'Rua X, 400, Fortaleza'),
('Empresa E', 'Rua Y, 500, Recife'),
('Empresa F', 'Av. Paulista, 600, São Paulo'),
('Empresa G', 'Rua Z, 700, Belo Horizonte'),
('Empresa H', 'Av. Amazonas, 800, Manaus'),
('Empresa I', 'Rua J, 900, Curitiba'),
('Empresa J', 'Rua L, 1000, Porto Alegre');

-- Inserção de Clientes
insert into CLIENTE (cod_cliente, nome_cliente, endereco, cpf, rg)
values 
(1, 'João Silva', 'Av. Paulista, 1000, SP', '12345678901', '123456789'),
(2, 'Maria Oliveira', 'Rua 7, 200, RJ', '23456789012', '987654321'),
(3, 'Carlos Souza', 'Rua 5, 300, BH', '34567890123', '564738291'),
(4, 'Ana Costa', 'Av. Rio Branco, 1500, RJ', '45678901234', '192837465'),
(5, 'Lucas Pereira', 'Rua 10, 400, SP', '56789012345', '183746192'),
(6, 'Fernanda Lima', 'Rua 15, 500, Recife', '67890123456', '132435465'),
(7, 'Ricardo Santos', 'Av. Brasil, 600, SP', '78901234567', '567890123'),
(8, 'Patrícia Mendes', 'Rua da Paz, 700, Curitiba', '89012345678', '546372819'),
(9, 'Eliane Rocha', 'Rua dos Três, 800, Salvador', '90123456789', '439182657'),
(10, 'Eduardo Silva', 'Rua do Sol, 900, Porto Alegre', '01234567890', '324198765');

-- Inserção de Funcionários
insert into FUNCIONARIO (cpf, rg, endereco, tipo_funcionario, nome_cliente)
values 
('12345678901', '123456789', 'Rua X, 50, SP', 'Operador', 'João Silva'),
('23456789012', '987654321', 'Rua Y, 150, RJ', 'Gerente', 'Maria Oliveira'),
('34567890123', '564738291', 'Rua Z, 200, BH', 'Supervisor', 'Carlos Souza'),
('45678901234', '192837465', 'Rua W, 250, SP', 'Operador', 'Ana Costa'),
('56789012345', '183746192', 'Rua V, 300, SP', 'Motorista', 'Lucas Pereira'),
('67890123456', '132435465', 'Rua U, 350, Recife', 'Gerente', 'Fernanda Lima'),
('78901234567', '567890123', 'Rua T, 400, SP', 'Supervisor', 'Ricardo Santos'),
('89012345678', '546372819', 'Rua S, 450, Curitiba', 'Operador', 'Patrícia Mendes'),
('90123456789', '439182657', 'Rua R, 500, Salvador', 'Motorista', 'Eliane Rocha'),
('01234567890', '324198765', 'Rua Q, 550, Porto Alegre', 'Operador', 'Eduardo Silva');

-- Inserção de Pedidos (Devem vir antes de DETALHESSERVICO)
insert into PEDIDO (Cod_pedido, End_partida, End_destino, Data_solicitacao, Valor_total)
values 
(101, 'Rua A, 100, SP', 'Rua B, 200, RJ', '2024-12-01', 200.00),
(102, 'Rua X, 150, SP', 'Rua Y, 250, RJ', '2024-12-02', 300.00),
(103, 'Rua Z, 200, BH', 'Rua W, 300, SP', '2024-12-03', 150.00),
(104, 'Av. Rio Branco, 250, SP', 'Av. Brasil, 350, RJ', '2024-12-04', 450.00),
(105, 'Rua V, 300, SP', 'Rua U, 400, SP', '2024-12-05', 500.00),
(106, 'Rua W, 350, SP', 'Rua X, 450, SP', '2024-12-06', 250.00),
(107, 'Rua Y, 400, SP', 'Rua Z, 500, SP', '2024-12-07', 600.00),
(108, 'Rua T, 450, SP', 'Rua S, 550, SP', '2024-12-08', 700.00),
(109, 'Rua R, 500, SP', 'Rua Q, 600, SP', '2024-12-09', 350.00),
(110, 'Rua P, 550, SP', 'Rua O, 650, SP', '2024-12-10', 800.00);

-- Inserção de Detalhes de Serviço (Após os pedidos)
insert into DETALHESSERVICO (qtd_horas, data_efetivacao, cpf_funcionario, nome_servico, cod_pedido)
values 
(5, '2024-12-01', '12345678901', 'Transporte', 101),
(3, '2024-12-02', '23456789012', 'Mudança', 102),
(6, '2024-12-03', '34567890123', 'Guindaste', 103),
(4, '2024-12-04', '45678901234', 'Transporte Urgente', 104),
(7, '2024-12-05', '56789012345', 'Carregamento', 105),
(2, '2024-12-06', '67890123456', 'Descarregamento', 106),
(8, '2024-12-07', '78901234567', 'Mudança Comercial', 107),
(9, '2024-12-08', '89012345678', 'Mudança Residencial', 108),
(10, '2024-12-09', '90123456789', 'Transporte', 109),
(5, '2024-12-10', '01234567890', 'Guindaste', 110);

-- Inserção de Cidades 
insert into CIDADE (nome_cidade)
values 
('São Paulo'),
('Rio de Janeiro'),
('Salvador'),
('Fortaleza'),
('Recife'),
('Belo Horizonte'),
('Manaus'),
('Curitiba'),
('Porto Alegre');

-- Inserção de Serviços em OFERTASERVICOEM
insert into OFERTASERVICOEM (nome_empresa, nome_cidade, nome_servico, preco_hora)
values 
('Empresa A', 'São Paulo', 'Transporte', 50.00),
('Empresa B', 'Rio de Janeiro', 'Mudança', 70.00),
('Empresa C', 'Salvador', 'Guindaste', 80.00),
('Empresa D', 'Fortaleza', 'Carregamento', 60.00),
('Empresa E', 'Recife', 'Descarregamento', 65.00),
('Empresa F', 'São Paulo', 'Mudança Residencial', 85.00),
('Empresa G', 'Belo Horizonte', 'Mudança Comercial', 90.00),
('Empresa H', 'Manaus', 'Transporte Urgente', 95.00),
('Empresa I', 'Curitiba', 'Transporte', 100.00),
('Empresa J', 'Porto Alegre', 'Guindaste', 110.00);

-- Inserção de Telefones de Clientes
insert into TELEFONECLIENTE (telefone, cod_cliente)
values 
('11987654321', 1),
('21987654321', 2),
('31987654321', 3),
('41987654321', 4),
('51987654321', 5),
('61987654321', 6),
('71987654321', 7),
('81987654321', 8),
('91987654321', 9),
('11987654322', 10);

-- Inserção de Telefones de Empresas
insert into TELEFONEEMPRESA (telefone, nome_empresa)
values 
('11387654321', 'Empresa A'),
('21387654321', 'Empresa B'),
('31387654321', 'Empresa C'),
('41387654321', 'Empresa D'),
('51387654321', 'Empresa E'),
('61387654321', 'Empresa F'),
('71387654321', 'Empresa G'),
('81387654321', 'Empresa H'),
('91387654321', 'Empresa I'),
('01387654321', 'Empresa J');
