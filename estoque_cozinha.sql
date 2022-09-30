-- drop schema estoque_cozinha;

CREATE SCHEMA IF NOT EXISTS estoque_cozinha;
USE estoque_cozinha;

CREATE TABLE IF NOT EXISTS proteinas (
  id_proteinas INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(45) NOT NULL,
  tipo ENUM('Carne Vermelha', 'Ave', 'Frutos do mar', 'Ovinos', 'Outros') NOT NULL,
  observacoes VARCHAR(240) NULL,
  usos VARCHAR(450) NULL,
  PRIMARY KEY (id_proteinas));

CREATE TABLE IF NOT EXISTS compras_proteinas (
  id_compras_proteinas INT NOT NULL primary key,
  fk_proteinas INT NOT NULL,
  caracteristica ENUM('Natural', 'Congelada') NOT NULL DEFAULT 'Natural',
  preco DECIMAL NOT NULL,
  quantidade INT NOT NULL,
  vencimento DATE NOT NULL,
  CONSTRAINT fk_proteinas foreign key (fk_proteinas) references proteinas(id_proteinas));


CREATE TABLE IF NOT EXISTS legumes_hortifruti(
  id_legumes_hortifruti INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(45) NOT NULL,
  tipo ENUM('Legume', 'Hortaliça', 'Tubérculo', 'Frutas') NOT NULL,
  observacoes VARCHAR(240) NOT NULL,
  usos VARCHAR(450) NULL,
  PRIMARY KEY (id_legumes_hortifruti));

CREATE TABLE IF NOT EXISTS compras_legumes_hortifruti(
  id_compras_legumes_hortifruti INT NOT NULL AUTO_INCREMENT,
  fk_legumes_hortifruti INT NOT NULL,
  preco DECIMAL(5,2) NOT NULL,
  quantidade INT NOT NULL,
  vencimento DATE NOT NULL,
  PRIMARY KEY (id_compras_legumes_hortifruti),
  CONSTRAINT fk_legumes_hortifruti foreign key (fk_legumes_hortifruti) references legumes_hortifruti(id_legumes_hortifruti));

CREATE TABLE IF NOT EXISTS processados_nao_pereciveis(
  id_processados_npereciveis INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(45) NOT NULL,
  tipo ENUM("não perecível", "processado") NOT NULL,
  Observacoes VARCHAR(240) NULL,
  usos VARCHAR(450) NULL,
  PRIMARY KEY (id_processados_npereciveis));


CREATE TABLE IF NOT EXISTS compras_processados_npereciveis(
  id_compras_processados_npereciveis INT NOT NULL AUTO_INCREMENT,
  fk_processados_npereciveis INT NOT NULL,
  preco DECIMAL(5,2) NOT NULL,
  quantidade INT NOT NULL,
  vencimento DATE NOT NULL,
  PRIMARY KEY (id_compras_processados_npereciveis),
  CONSTRAINT fk_processados_npereciveis FOREIGN KEY (fk_processados_npereciveis)
 REFERENCES processados_nao_pereciveis(id_processados_npereciveis));


CREATE TABLE IF NOT EXISTS cadastro_bebida (
  id_cadastro_bebida INT NOT NULL auto_increment,
  nome VARCHAR(45) NOT NULL,
  volume VARCHAR(45) NOT NULL,
  sabor VARCHAR(45) NOT NULL,
  caracteristica ENUM('Light', 'Diet', 'Comum', 'Sem ácool', 'Com álcool') NOT NULL DEFAULT 'Comum',
  usos VARCHAR(450) NULL,
  PRIMARY KEY (id_cadastro_bebida));


CREATE TABLE IF NOT EXISTS compras_bebidas (
  id_compras_bebidas INT NOT NULL AUTO_INCREMENT primary key,
  fk_cadastro_bebida INT NOT NULL,
  preco DECIMAL(5,2) NOT NULL,
  quantidade INT NOT NULL DEFAULT 1,
  vencimento DATE NOT NULL,
  CONSTRAINT fk_cadastro_bebida FOREIGN KEY (fk_cadastro_bebida)
    REFERENCES cadastro_bebida (id_cadastro_bebida));

CREATE TABLE IF NOT EXISTS estoque_geral (
  id_estoque_geral INT NOT NULL auto_increment primary key,
  fk_compras_bebidas INT NOT NULL,
  fk_compras_proteinas INT NOT NULL,
  fk_compras_processados_npereciveis INT NOT NULL,
  fk_compras_Legumes_hortifruti INT NOT NULL,
  CONSTRAINT fk_compras_bebidas
    FOREIGN KEY (fk_compras_bebidas)
    REFERENCES compras_bebidas(id_compras_bebidas),
  CONSTRAINT   fk_compras_proteinas
    FOREIGN KEY (fk_compras_proteinas)
    REFERENCES compras_proteinas(id_compras_proteinas),
  CONSTRAINT fk_compras_processados_npereciveis
    FOREIGN KEY (fk_compras_processados_npereciveis)
    REFERENCES compras_processados_npereciveis(id_compras_processados_npereciveis),
  CONSTRAINT fk_compras_Legumes_hortifruti
    FOREIGN KEY (fk_compras_Legumes_hortifruti)
    REFERENCES compras_legumes_hortifruti(id_compras_legumes_hortifruti));
