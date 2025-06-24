insert into cliente (nome, tipo_pessoa, senha, login) values 
		('Jose da Silva', 'fisica', '123456', 'jose.silva@gmail.com'),
		('Transportadora Rapidex', 'juridica', '654321', 'rapidex@gmail.com')
;

insert into cliente_fisica (id_cliente, email, celular, cpf) values
		(1, 'jose.silva@gmail.com', '1122223344', '012345678901')
;

insert into cliente_juridica (id_cliente, telefone, nome_contato, email_contato, cnpj) values
		(2, '1122223344', 'Joao Gilberto dos Santos', 'joao.gsantos@gmail.com', '111222333000155')
;

