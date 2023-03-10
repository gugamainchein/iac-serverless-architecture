# IaC Serverless Architecture

Automatizar infraestruturas é um desafio gigante, principalmente quando falamos de arquiteturas AWS Serverless. Neste cenário, cada detalhe passa a ser importante, em decorrência da importância dos detalhes nas configurações dos recursos serverless.

Pensando nos desafios das configurações sendo realizadas de forma manual, como o alto tempo de configuração e altas chances de erro, construímos esse repositório para que você possa automatizar suas infraestruturas AWS Serverless e preocupar-se somente com seu código.

## Arquitetura do projeto - Frontend

Os principais recursos que irão nos apoiar na configuração de nossa aplicação são:

- S3:

  - Armazenamento dos arquivos estáticos do frontend.

- WAF:

  - Firewall da aplicação, controlando as requisições e formatações delas no Cloudfront.

- Codecommit:

  - Controle de versionamento e features do projeto.

- Codebuild:

  - Ferramenta utilizada para download dos pacotes da aplicação, além de execução dos comandos de testes e build.

- Codepipeline:

  - Recurso AWS responsável por automatizar o processo de build e deploy, por meio do gerenciamento via esteira.

Veja a arquitetura abaixo para esclarecer as conexões entre os recursos:

![Arquitetura AWS][architecture_front]

## Arquitetura do projeto - Backend

Os principais recursos que irão nos apoiar na configuração de nossa aplicação são:

- S3:

  - Armazenamento dos logs da pipeline e cache do Serverless Framework.

- DynamoDB:

  - Banco de dados NoSQL, utilizado para armazenamento dos dados da API.

- Lambda:

  - Serviço responsável pela execução dos códigos das funções.

- API Gateway:

  - Camada que fornecerá o endpoint e irá gerenciar todo o roteamento das requisições para as funções Lambda e o User Pool do Cognito.

- WAF:

  - Firewall da aplicação, controlando as requisições e formatações delas do API Gateway.

- Cognito:

  - Serviço responsável por fornecer a camada de federação de usuários da aplicação.

- Codecommit:

  - Controle de versionamento e features do projeto.

- Codebuild:

  - Ferramenta utilizada para download dos pacotes da aplicação, além de execução dos comandos de testes e build.

- Codepipeline:

  - Recurso AWS responsável por automatizar o processo de build e deploy, por meio do gerenciamento via esteira.

- Secrets Manager:

  - Serviço AWS que é responsável por armazenar as chaves sensíveis da aplicação.

Veja a arquitetura abaixo para esclarecer as conexões entre os recursos:

![Arquitetura AWS][architecture_back]

## Custo envolvido - Frontend

Como você deve saber, os recursos AWS cobram por utilização e é importante trazermos essa visão de custo envolvido na arquitetura apresentada, pois esse tema pode tornar-se um fator de tomada de decisão da viabilidade técnica e de negócio da aplicação.

- Norte Virgínia: $ 6.00 / mês

O calculo foi feito pelo infracost, você pode encontrar [clicando aqui][infracost_calc_front]

## Custo envolvido - Backend

Como você deve saber, os recursos AWS cobram por utilização e é importante trazermos essa visão de custo envolvido na arquitetura apresentada, pois esse tema pode tornar-se um fator de tomada de decisão da viabilidade técnica e de negócio da aplicação.

- Norte Virgínia: $ 7.80 / mês

O calculo foi feito pelo infracost, você pode encontrar [clicando aqui][infracost_calc_back]

## Instalação

Dado todo cenário de recursos e custos envolvidos, para essa aplicação, estamos utilizando o Terraform. Portanto, é necessário que você possua o [Terraform][terraform] instalado. Podendo executar o comando abaixo para instalar.

```sh
sudo sh scripts/install.sh
```

Após a instalação do Terraform e a conta AWS preparada para utilização, basta executar os comandos abaixo para iniciar o projeto.

Clonando o repositório e entrando na pasta:

```sh
git clone https://github.com/gugamainchein/iac-serverless-architecture
cd iac-serverless-architecture
```

Executando o projeto:

```sh
sudo sh scripts/apply.sh
```

<!-- ## Variáveis de ambiente -->

<!-- Após as realizações dos passos acima e a inicialização do projeto com sucesso, você está pronto para integrá-lo com os recursos de sua conta AWS, por meio das variáveis de ambiente abaixo:

- API_NAME: Nome do seu projeto back-end;

- STAGE: Ambiente que está trabalhando, como por exemplo "dev", "qa" e "prod";

- API_URL: Endpoint da API, de acordo com o ambiente. Caso esteja rodando localmente, a URL tende a ser http://localhost:3000;

- AUTH_HEADER: JWT de sua preferência para validação na autorização. -->

<!-- ## Sobre o projeto -->

<!-- O back-end deste repositório, tem como propósito a realização do CRU (Create, Read e Update) de clientes no banco de dados. Pensando nisso, abordaremos nos tópicos abaixo como o projeto está estruturado.

- Arquivo principal:

  - O arquivo `serverless.ts` contém todas as instruções / configurações que o [Serverless Framework]_serverless-framework] necessita para executar a aplicação localmente e em outros ambientes.

- Roteamento:

  - Dentro do diretório `/src/routes` encontram-se todos os arquivos de rotas, relacionados com os arquivos e funções responsáveis, da aplicação.

- Banco de dados:

  - No projeto, estamos utilizando o banco de dados NoSQL da AWS, no caso o DynamoDB. Por ser um recurso desta cloud, para realização da conexão e execução de comandos, utilizamos o [SDK][aws_sdk];
  - Todas as interaçõs com o DynamoDB serão encontradas em `/src/model`.

- Arquivos compartilhados:

  - Como uma prática muito comum de Clean Code, buscamos reaproveitar o máximo de código possível e de forma inteligente. Para alcançar esse propósito, todo compartilhamento de funções e objetos serão encontrados em `/src/shared`, separados de acordo com suas categorias.

- Funções:
  - Todas as funções, responsáveis pela execução das regras de negócio, encontram-se em `/src/functions`. -->

## Histórico de mudanças

- 0.1.0
  - Primeira versão da aplicação

## Sobre os criadores

- Gustavo Mainchein - [@gugamainchein](https://www.instagram.com/gugamainchein) – gustavomainchein@outlook.com
- Raul Soares - [@r4ulrs](https://www.instagram.com/r4ulrs/) - raulsoares@outlook.com

## Faça sua contribuição

1. Realize o fork do projeto (<https://github.com/gugamainchein/iac-serverless-architecture/fork>)
2. Crie a nova feature em uma branch (`git checkout -b feature/bucket_acl`)
3. Faça o commit das suas mudanças (`git commit -am 'Just changing bucket acl'`)
4. Realize o push para a branch (`git push origin feature/bucket_acl`)
5. Crie um novo pull request

<!-- Start Functions -->

[architecture_front]: ./docs/architecture/github-front-end-arch-tf-v1.png
[architecture_back]: ./docs/architecture/github-back-end-arch-tf-v1.png
[email]: mailto:dev@dosystems.com.br?subject=Gostaria%20de%20solicitar%20um%20orçamento.
[npm_image]: https://img.shields.io/npm/v/datadog-metrics.svg?style=flat-square
[infracost_calc_front]: ./docs/infracost/calc_front.txt
[infracost_calc_back]: ./docs/infracost/calc_back.txt
[npm_url]: https://docs.npmjs.com/cli/v8
[terraform]: https://www.terraform.io/
[serverless_framework]: https://www.serverless.com/framework/docs
[aws_sdk]: https://aws.amazon.com/sdk-for-javascript/

<!-- End Functions -->
