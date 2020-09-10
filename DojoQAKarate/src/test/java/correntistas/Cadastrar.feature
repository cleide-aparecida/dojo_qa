@REGRESSION
Feature: Cadastrar Correntista
  "Funcionalidade responsável pela criação de um novo correntista,
  uma vez os dados validados o sistema deve inserir o registro no banco de
  dados com os valores recebidos."

  Background:
    * url BASE_URL
    * def payload = read('classpath:requests/CadastrarCorrentista.json')

  @CADASTRO
  @SMOKE
  Scenario: Validar que o correntista é cadastrado com sucesso
    Given path '/holders'
    And request payload
    When method POST
    Then assert responseStatus == 201

  Scenario Outline: Validar campos obrigatórios <nomeCampo>
    * remove payload.<nomeCampoPath>
    Given path '/holders'
    And request payload
    When method POST
    Then assert responseStatus == 400
    And match response.message == "Campo <nomeCampo> nao informado"

    Examples: campos obrigatorios
      |nomeCampoPath|nomeCampo|
      |holder.address.zipCode|zipCode|
      |holder.address.street |street |
      |holder.address.number|number  |
      |holder.birthDate|birthDate    |
      |holder.cpf|cpf                |
      |holder.accountType|accountType|
      |holder.name|name              |

  Scenario Outline: Validar regras dos campos
    * set payload.<nomeCampoPath> = '<valorCampo>'
    Given path '/holders'
    And request payload
    When method POST
    Then assert responseStatus == <statusCode>
    And match response.message == '<returnedMessage>'

    Examples:
      |nomeCampoPath|valorCampo|statusCode|returnedMessage|
      |holder.address.zipCode|abcd|400|Campo zipCode invalido|
      |holder.birthDate|08-09-2020|400|Campo birthDate invalido|
      |holder.birthDate|2015-08-09|412|Cadastro permitido somente para maiores de 18 anos|
      |holder.birthDate|2029-12-31|412|Data de nascimento deve ser menor que data atual|
      |holder.cpf|1234|400|Campo cpf deve conter 11 digitos|
      |holder.cpf|123.456.789-12|400|Campo cpf invalido|
      |holder.accountType|XT|400|Campo accountType deve ser PF ou PJ|
      |holder.cnpj|1234|400|Campo cnpj deve conter 14 digitos|
      |holder.cnpj|12.345.678/9123-45|400|Campo cnpj invalido|

  Scenario Outline: validar que <campo> é obrigatorio  para contas do tipo PJ
    * set payload.holder.accountType = 'PJ'
    * remove payload.<nomeCampoPath>
    Given path '/holders'
    And request payload
    When method POST
    Then assert responseStatus == 400
    And match response.message == '<returnedMessage>'

    Examples:
      |nomeCampoPath|returnedMessage|campo|
      |holder.cnpj  |Campo cnpj nao informado|cnpj|
      |holder.socialName|Campo socialName nao informado|socialName|
