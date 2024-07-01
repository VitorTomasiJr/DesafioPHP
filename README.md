O projeto foi desenvolvido em:
 - PHP 8.2.12
 - NodeJS 20.15.0

Para o funcionamento do projeto é necessario possuir:
  - PHP
  - Nodejs
  - PostgreSQL
Após instalar todos as pendencias verificar no arquivo php.ini (encontra-se na raiz da pasta de instalação do php) e habilitar as seguintes extensões: extension=pdo_pgsql extension=pgsql

Para iniciar o servidor em PHP é necessario apenas rodar o comando php -S localhost:8080.

Caso necessário alterar a porta de inicializado do back-end é necessario alterar o caminho em config.js no projeto do front-end

### IMPORTANTE ###
o arquivo sql esta no projeto DesafioPHP - dbdesafio.sql
 - Para configurar a conexão do banco de dados com o back, mexer no arquivo db.php
