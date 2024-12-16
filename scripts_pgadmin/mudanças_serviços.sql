-- Tables Section

create table SERVICO (
    nome_servico VARCHAR(50) NOT NULL,
    tipo_servico VARCHAR(50) NOT NULL,
    constraint ID_SERVICO primary key (nome_servico)
);

create table SERVICO_TRANSPORTE (
    acrescimo DECIMAL(10, 2),
    peso DECIMAL(10, 2) CHECK (peso > 0),
    nome_servico VARCHAR(50) NOT NULL,
    constraint ID_SERVICO_TRANSPORTE primary key (nome_servico)
);

create table GUINDASTE (
    base DECIMAL(10, 2),
    altura DECIMAL(10, 2) CHECK (altura > 0),
    bonus DECIMAL(10, 2),
    nome_servico VARCHAR(50) NOT NULL,
    constraint ID_GUINDASTE primary key (nome_servico)
);

create table FUNCIONARIO (
    cpf CHAR(11) NOT NULL,
    rg CHAR(10),
    endereco VARCHAR(100),
    tipo_funcionario VARCHAR(50),
    nome_funcionario VARCHAR(50),
    constraint ID_FUNCIONARIO primary key (cpf)
);

create table EMPREGOFUNCIONARIO (
    cpf_funcionario CHAR(11) NOT NULL,
    nome_empresa VARCHAR(50) NOT NULL,
    horario TIME,
    salario DECIMAL(10, 2) CHECK (salario >= 0),
    constraint ID_EMPREGOFUNCIONARIO primary key (cpf_funcionario, nome_empresa)
);

create table EMPRESA (
    nome_empresa VARCHAR(50) NOT NULL,
    endereco VARCHAR(100),
    constraint ID_EMPRESA primary key (nome_empresa)
);

create table CLIENTE (
    cod_cliente INT NOT NULL,
    nome_cliente VARCHAR(50),
    endereco VARCHAR(100),
    cpf CHAR(11),
    rg CHAR(10),
    constraint ID_CLIENTE primary key (cod_cliente)
);

create table DETALHESSERVICO (
    qtd_horas INT CHECK (qtd_horas > 0),
    data_efetivacao DATE,
    cpf_funcionario CHAR(11) not null,
    nome_servico VARCHAR(50) not null,
    nome_empresa VARCHAR(50) not null,
    cod_pedido INT not null,
    constraint ID_DETALHESSERVICO primary key (cpf_funcionario, nome_servico, cod_pedido, nome_empresa)
);

create table CIDADE (
    nome_cidade VARCHAR(50) not null,
    nome_estado VARCHAR(50),
    constraint ID_CIDADE primary key (nome_cidade)
);

create table PEDIDO (
    Cod_pedido INT not null,
    Cod_cliente INT not null,
    End_partida VARCHAR(100),
    End_destino VARCHAR(100),
    Data_solicitacao DATE,
    Valor_total DECIMAL(10, 2) CHECK (valor_total >= 0),
    constraint ID_PEDIDO primary key (cod_pedido)
);

create table OFERTASERVICOEM (
    nome_empresa VARCHAR(50) not null,
    nome_cidade VARCHAR(50) not null,
    nome_servico VARCHAR(50) not null,
    preco_hora DECIMAL(10, 2) CHECK (preco_hora >= 0),
    constraint ID_OFERTASERVICOEM primary key (nome_empresa, nome_cidade, nome_servico)
);

create table TELEFONECLIENTE (
    telefone CHAR(15) unique,
    cod_cliente INT not null,
    constraint ID_TELEFONECLIENTE primary key (cod_cliente)
);

create table TELEFONEEMPRESA (
    telefone CHAR(15) unique,
    nome_empresa VARCHAR(50) not null,
    constraint ID_TELEFONEEMPRESA primary key (nome_empresa)
);

create table TELEFONEFUNCIONARIO (
    telefone CHAR(15) unique,
    cpf_funcionario CHAR(11) not null,
    constraint ID_TELEFONEFUNCIONARIO primary key (cpf_funcionario)
);

-- Constraints Section

alter table SERVICO_TRANSPORTE add constraint FK_SERVICO_TRANSP 
    foreign key (nome_servico)
    references SERVICO (nome_servico) on delete cascade on update cascade;

alter table GUINDASTE add constraint FK_SERVICO_GUINDASTE 
    foreign key (nome_servico)
    references SERVICO (nome_servico) on delete set null on update cascade;

alter table EMPREGOFUNCIONARIO add constraint FK_FUNCIONARIO_EMPRESA 
    foreign key (cpf_funcionario)
    references FUNCIONARIO (cpf) on delete cascade on update cascade;

alter table EMPREGOFUNCIONARIO add constraint FK_EMPRESA_FUNC 
    foreign key (nome_empresa)
    references EMPRESA (nome_empresa) on delete cascade on update cascade;

alter table DETALHESSERVICO add constraint FK_DETALHESERVICO_FUNC 
    foreign key (cpf_funcionario)
    references FUNCIONARIO (cpf) on delete set null on update cascade;

alter table DETALHESSERVICO add constraint FK_DETALHESERVICO_SERVICO 
    foreign key (nome_servico)
    references SERVICO (nome_servico) on delete cascade on update cascade;

alter table PEDIDO add constraint FK_PEDIDO_CLIENTE 
    foreign key (cod_cliente)
    references CLIENTE (cod_cliente) on delete cascade on update cascade;

alter table DETALHESSERVICO add constraint FK_DETALHESERVICO_PEDIDO 
    foreign key (cod_pedido)
    references PEDIDO (cod_pedido) on delete cascade on update cascade;

alter table OFERTASERVICOEM add constraint FK_OFERTA_EMPRESA 
    foreign key (nome_empresa)
    references EMPRESA (nome_empresa) on delete cascade on update cascade;

alter table OFERTASERVICOEM add constraint FK_OFERTA_CIDADE 
    foreign key (nome_cidade)
    references CIDADE (nome_cidade) on delete cascade on update cascade;

alter table OFERTASERVICOEM add constraint FK_OFERTA_SERVICO 
    foreign key (nome_servico)
    references SERVICO (nome_servico) on delete cascade on update cascade;

alter table TELEFONECLIENTE add constraint FK_TEL_CLIENTE 
    foreign key (cod_cliente)
    references CLIENTE (cod_cliente) on delete cascade on update cascade;

alter table TELEFONEEMPRESA add constraint FK_TEL_EMPRESA 
    foreign key (nome_empresa)
    references EMPRESA (nome_empresa) on delete cascade on update cascade;

alter table TELEFONEFUNCIONARIO add constraint FK_TEL_FUNCIONARIO 
    foreign key (cpf_funcionario)
    references FUNCIONARIO (cpf) on delete cascade on update cascade;

CREATE OR REPLACE FUNCTION atualizar_preco_pedido()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE Pedido
    SET valor_total = valor_total + (
        SELECT SUM(
            NEW.qtd_horas * OSE.preco_hora + 
            COALESCE(ST.acrescimo, 0) + 
            COALESCE(G.bonus, 0)
        )
        FROM OFERTASERVICOEM OSE
        JOIN PEDIDO P ON OSE.cod_pedido = P.cod_pedido
        WHERE OSE.nome_empresa = NEW.nome_empresa
        AND OSE.nome_servico = NEW.nome_servico
        AND OSE.nome_cidade = (SELECT End_partida
                               FROM Pedido P2
                               WHERE P2.cod_pedido = NEW.cod_pedido)
        
        -- LEFT JOIN para incluir acréscimos (serviço transporte)
        LEFT JOIN servico_transporte ST 
            ON OSE.nome_servico = ST.nome_servico
        
        -- LEFT JOIN para incluir bônus (guindaste)
        LEFT JOIN guindaste G 
            ON OSE.nome_servico = G.nome_servico
    )
    WHERE cod_pedido = NEW.cod_pedido;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger que dispara a função após INSERT ou UPDATE na tabela Inclui
CREATE TRIGGER trigger_atualizar_preco_pedido
AFTER INSERT OR UPDATE ON DETALHESSERVICO
FOR EACH ROW
EXECUTE FUNCTION atualizar_preco_pedido();