# DIO-modelagem-e-commerce
Modelagem de Projeto de E-Commerce
## Definições
1. Escopo
   - Venda de produtos
2. Entidades
   - Produto
     - Os produtos serão vendidos em uma única plataforma online. Contudo, estes podem ter vendedores distintos (terceiros).
     - Cada produto possui um fornecedor
     - Um ou mais produtos podem compor um pedido
   - Cliente
     - O cliente pode se cadastrar no site com seu CPF ou CNPJ
     - O endereço do cliente irá determinar o valor do frete
     - Um cliente pode comprar mais de um pedido. Este tem um período de carência para devolução do produto.
   - Fornecedor
   - Estoque
   - Pedido
     - Os pedidos são criados por clientes e possuem informações de compra, endereço e status da entrega.
     - Um produto ou mais compoem o pedido.
     - O pedido pode ser cancelado.
