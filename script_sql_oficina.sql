create database oficina;

use oficina;

-- criar tabela cliente
create table cliente(
	idCliente int auto_increment primary key,
    Nome varchar(255) not null,
    CPF char(11) not null,
    Telefone varchar(11) not null,
    Endereco varchar(255) not null,
    constraint unique_CPF unique (CPF)
);

-- criar tabela veiculo
create table veiculo(
	idVeiculo int auto_increment primary key,
    Identificacao_veiculo varchar(45)not null,
    idCliente int,
    constraint fk_veiculo_cliente foreign key (idCliente) references cliente(idCliente)
);

-- criar tabela Equipe Mecanicos
create table equipeMecanicos(
	idEquipeMecanicos int auto_increment primary key,
    servico varchar(45) not null
);

-- criar tabela mecanico
create table mecanico(
	idMecanicos int auto_increment primary key,
    CodigoMecanico int not null,
    Nome varchar(45)not null,
    Endereco varchar(45)not null,
    Especialidade varchar(45),
    EquipeMecanico int,
    constraint fk_mecanico_equipe foreign key (EquipeMecanico) references equipeMecanicos(idEquipeMecanicos)
);

-- criar tabela valor das peças
create table valorPecas(
	idValorPecas int auto_increment primary key,
    valorPecas varchar(255) not null
);

-- criar tabela mao de obra
create table maoObra(
	idMaoObra int auto_increment primary key,
    ValorMaoObra varchar(255)
);

-- criar tabela conserto e revisao
create table consertoRevisao(
	equipeMecanicos int,
    idVeiculo int,
    os int not null,
    idMaoObra int,
    idValorPecas int,
    dataOs varchar(45) not null,
    valorOs varchar(45)not null,
    statusOs varchar(45)not null,
    diasExecucao varchar(45)not null,
    constraint fk_conserto_equipe foreign key (equipeMecanicos) references equipeMecanicos(idEquipeMecanicos),
    constraint fk_conserto_veiculo foreign key (idVeiculo) references veiculo(idVeiculo),
    constraint fk_conserto_mao foreign key (idMaoObra) references maoObra(idMaoObra),
    constraint fk_conserto_pecas foreign key (idValorPecas) references valorPecas(idValorPecas)
);

-- criar tabela autorizar ou negar
create table autorizarNegar(
	idAutorizarNegar int auto_increment primary key,
    autorizacao varchar(45),
    negacao varchar(45),
    dataResposta date not null,
    idCliente int,
    idVeiculo int,
    idEquipeMecanicos int,
    constraint fk_autorizarnegar_cliente foreign key (idCliente) references cliente(idCliente),
    constraint fk_autorizarnegar_veiculo foreign key (idVeiculo) references veiculo(idVeiculo),
    constraint fk_autorizarnegar_equipe foreign key (idEquipeMecanicos) references equipeMecanicos(idEquipeMecanicos)
);

-- criar tabela servico autorizado
create table autorizado(
	idAutorizado int auto_increment primary key,
    dataconclusao varchar(45) not null,
    osautorizada int not null,
    dataosautorizada varchar(45) not null,
    statusosautorizada varchar(45) not null,
    idEquipeMecanicos int,
    idAutorizarNegar int,
    idCliente int,
    idVeiculo int,
    constraint fk_autorizado_equipe foreign key (idEquipeMecanicos) references equipeMecanicos(idEquipeMecanicos),
    constraint fk_autorizado_id foreign key (idAutorizarNegar) references autorizarNegar(idAutorizarNegar),
    constraint fk_autorizado_cliente foreign key (idCliente) references cliente(idCliente),
    constraint fk_autorizado_veiculo foreign key (idVeiculo) references veiculo(idVeiculo)
);

-- inserção de dados
insert into cliente(Nome, CPF, Telefone, Endereco) values
	('cliente1','00000000001','00000000001','Rua 1'),
    ('cliente2','00000000002','00000000002','Rua 2'),
    ('cliente3','00000000003','00000000003','Rua 3');

insert into veiculo(Identificacao_veiculo, idCliente) values
	('0123456789','1'),
    ('1234567890','2'),
    ('2345678901','3');

insert into equipeMecanicos(servico) values
	('servico1'),
    ('servico2'),
    ('servico3');

insert into mecanico(CodigoMecanico, Nome, Endereco, Especialidade, EquipeMecanico) values
	('11111','mecanico1','Rua a','especialidade1','1'),
    ('22222','mecanico2','Rua b','especialidade2','2'),
    ('33333','mecanico3','Rua c','especialidade3','3');

insert into valorPecas(valorPecas) values
	('100,00');

insert into maoObra(ValorMaoObra) values
	('150,00');

insert into consertoRevisao (os, dataOs, valorOs, statusOs, diasExecucao) values
	('999',20220101,'250,00','Em andamento','5 dias');

insert into autorizarNegar(autorizacao, negacao, dataResposta) values
	('sim',null,'20220102'),
    (null,'sim','20220103');

insert into autorizado(dataconclusao, osautorizada, dataosautorizada, statusosautorizada) values
	('20220104','0147','20220105','Concluida');

-- queries
select * from cliente;
select count(*) from cliente;

select * from cliente c,veiculo v where c.idCliente=v.idCliente;

select Nome,Telefone,idVeiculo from cliente c,veiculo v where c.idCliente=v.idCliente group by idVeiculo;
