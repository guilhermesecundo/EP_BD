-- Inserindo dados na tabela CIDADE
INSERT INTO CIDADE (nome_cidade, nome_estado) VALUES
('Manaus', 'Amazonas'),
('Fortaleza', 'Ceará'),
('Florianópolis', 'Santa Catarina'),
('Campo Grande', 'Mato Grosso do Sul'),
('Goiânia', 'Goiás');

-- Inserindo dados na tabela EMPRESA
INSERT INTO EMPRESA (nome_empresa, endereco) VALUES
('AmazonCargo', 'Rua Y, 678, Manaus'),
('NordesteFretes', 'Av. Z, 789, Fortaleza'),
('SulTransportes', 'Rua AA, 890, Florianópolis'),
('PantanalLog', 'Av. AB, 901, Campo Grande'),
('GoiasFrete', 'Rua AC, 102, Goiânia');

-- Inserindo dados na tabela CLIENTE
INSERT INTO CLIENTE (cod_cliente, nome_cliente, endereco, cpf, rg) VALUES
(9, 'Pedro Henrique', 'Rua AD, 203, Manaus', '23456789019', 'AM2345678'),
(10, 'Ana Clara', 'Av. AE, 304, Fortaleza', '34567890128', 'CE3456789'),
(11, 'Rita Fonseca', 'Rua AF, 405, Florianópolis', '45678901237', 'SC4567890'),
(12, 'Cláudio Moura', 'Av. AG, 506, Campo Grande', '56789012346', 'MS5678901'),
(13, 'Juliana Rocha', 'Rua AH, 607, Goiânia', '67890123455', 'GO6789012');

-- Inserindo dados na tabela FUNCIONARIO
INSERT INTO FUNCIONARIO (cpf, rg, endereco, tipo_funcionario, nome_funcionario) VALUES
('78901234568', 'AM7890123', 'Rua AI, 708, Manaus', 'Motorista', 'Tiago Freitas'),
('89012345679', 'CE8901234', 'Av. AJ, 809, Fortaleza', 'Operador de Guindaste', 'Camila Monteiro'),
('90123456789', 'SC9012345', 'Rua AK, 910, Florianópolis', 'Assistente', 'Roberta Nunes'),
('01234567890', 'MS0123456', 'Av. AL, 101, Campo Grande', 'Gerente', 'Eduardo Silva'),
('12345098764', 'GO1234509', 'Rua AM, 202, Goiânia', 'Motorista', 'Mariana Castro');

-- Inserindo dados na tabela PEDIDO
INSERT INTO PEDIDO (cod_pedido, cod_cliente, end_partida, end_destino, data_solicitacao, valor_total) VALUES
(109, 9, 'Manaus', 'Fortaleza', '2024-12-17', 2600.00),
(110, 10, 'Fortaleza', 'Florianópolis', '2024-12-18', 2700.00),
(111, 11, 'Florianópolis', 'Campo Grande', '2024-12-19', 2800.00),
(112, 12, 'Campo Grande', 'Goiânia', '2024-12-20', 2900.00),
(113, 13, 'Goiânia', 'Manaus', '2024-12-21', 3000.00);

-- Inserindo dados na tabela SERVICO
INSERT INTO SERVICO (nome_servico, tipo_servico) VALUES
('Mudança Corporativa', 'Logística'),
('Transporte Rodoviário', 'Transporte'),
('Guindaste Pesado', 'Construção'),
('Gerenciamento de Estoque', 'Logística'),
('Entrega Expressa', 'Transporte');

-- Inserindo dados na tabela SERVICO_TRANSPORTE
INSERT INTO SERVICO_TRANSPORTE (acrescimo, peso, nome_servico) VALUES
(250.00, 1000.00, 'Mudança Corporativa'),
(350.00, 1500.00, 'Transporte Rodoviário'),
(120.00, 600.00, 'Entrega Expressa');

-- Inserindo dados na tabela GUINDASTE
INSERT INTO GUINDASTE (base, altura, bonus, nome_servico) VALUES
(18.00, 35.00, 600.00, 'Guindaste Pesado'),
(20.00, 40.00, 700.00, 'Gerenciamento de Estoque');

-- Inserindo dados na tabela DETALHESSERVICO
INSERT INTO DETALHESSERVICO (qtd_horas, data_efetivacao, cpf_funcionario, nome_servico, cod_pedido) VALUES
(6, '2024-12-17', '78901234568', 'Mudança Corporativa', 109),
(8, '2024-12-18', '89012345679', 'Transporte Rodoviário', 110),
(10, '2024-12-19', '90123456789', 'Guindaste Pesado', 111),
(7, '2024-12-20', '01234567890', 'Gerenciamento de Estoque', 112),
(5, '2024-12-21', '12345098764', 'Entrega Expressa', 113);

-- Inserindo dados na tabela OFERTASERVICOEM
INSERT INTO OFERTASERVICOEM (nome_empresa, nome_cidade, nome_servico, preco_hora) VALUES
('AmazonCargo', 'Manaus', 'Mudança Corporativa', 150.00),
('NordesteFretes', 'Fortaleza', 'Transporte Rodoviário', 200.00),
('SulTransportes', 'Florianópolis', 'Guindaste Pesado', 250.00),
('PantanalLog', 'Campo Grande', 'Gerenciamento de Estoque', 180.00),
('GoiasFrete', 'Goiânia', 'Entrega Expressa', 100.00);

-- Inserindo dados na tabela TELEFONECLIENTE
INSERT INTO TELEFONECLIENTE (telefone, cod_cliente) VALUES
('92999999999', 9),
('85999999999', 10),
('48999999999', 11),
('67999999999', 12),
('62999999999', 13);

-- Inserindo na tabela TELEFONEEMPRESA
INSERT INTO TELEFONEEMPRESA (telefone, nome_empresa) VALUES
('92988888888', 'AmazonCargo'),
('85888888888', 'NordesteFretes'),
('48888888888', 'SulTransportes'),
('67888888888', 'PantanalLog'),
('62888888888', 'GoiasFrete');

-- Inserindo na tabela TELEFONEFUNCIONARIO
INSERT INTO TELEFONEFUNCIONARIO (telefone, cpf_funcionario) VALUES
('92977777777', '78901234568'),
('85777777777', '89012345679'),
('48777777777', '90123456789'),
('67777777777', '01234567890'),
('62777777777', '12345098764');
