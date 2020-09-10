@REGRESSION
Feature: Cadastrar Correntista
  "Funcionalidade responsável pela criação de um novo correntista,
  uma vez os dados validados o sistema deve inserir o registro no banco de
  dados com os valores recebidos."

  Background:
    * url BASE_URL
    * callonce read('classpath:correntistas/Cadastrar.feature@CADASTRO')
    * def payload = read('classpath:requests/CadastrarCorrentista.json')

  @SMOKE
  Scenario: Consultar endereço do correntista com sucessso
    * def cpf = get payload.holder.cpf
    * def accountType = get payload.holder.accountType
    Given path '/holders/address'
    * params {cpf: '#(cpf)', accountType: '#(accountType)'}
    When method GET
    Then assert responseStatus == 200

  Scenario: Validar regras dos filtros accountType
    Given path '/holders/address'
    * params {cpf: '123456789789'}
    When method GET
    Then assert responseStatus == 400
    And match response.message == "Campo tipo de conta nao informado"

  Scenario: Validar regras dos filtros cpf
    Given path '/holders/address'
    * params {accountType: 'PJ'}
    When method GET
    Then assert responseStatus == 400
    And match response.message == "Campo cpf nao informado"

  Scenario: Correntista não encontrado no sistema
    Given path '/holders/address'
    * params {cpf: '00000000000', accountType: 'PF'}
    When method GET
    Then assert responseStatus == 404
    And match response.message == "Correntista nao encontrado"

  Scenario: Verificar que o tipo de conta deve ser PJ ou PF
    Given path '/holders/address'
    * params {cpf: '123456789789', accountType: 'XT'}
    When method GET
    Then assert responseStatus == 400
    And match response.message == "Campo accountType deve ser PF ou PJ"

  Scenario: Verificar que não é possível consultar um cpf que não possui 11 digitos
    Given path '/holders/address'
    * params {cpf: '1234567897', accountType: 'PF'}
    When method GET
    Then assert responseStatus == 400
    And match response.message == "Campo cpf deve conter 11 digitos"
