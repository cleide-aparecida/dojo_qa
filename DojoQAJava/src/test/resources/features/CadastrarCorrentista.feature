#language: pt
  @REGRESSION
  Funcionalidade: Cadastrar Correntista
    "Funcionalidade responsável pela criação de um novo correntista,
    uma vez os dados validados o sistema deve inserir o registro no banco de
    dados com os valores recebidos."

  Contexto:
    Dado que os dados para cadastro foram fornecidos

  @SMOKE
  Cenario: Validar que o correntista é cadastrado com sucesso
    Quando efetuo a operação de POST no caminho "/holders"
    Então o cadastro é realizado com sucesso
    E status code 201 é retornado


  Esquema do Cenario: Validar campos obrigatórios (<nomeCampo>)
    Dado que o campo "<nomeCampo>" não é informado na request
    Quando efetuo a operação de POST no caminho "/holders"
    Entao a mensagem "Campo <nomeCampo> nao informado" é retornada
    E status code 400 é retornado

    Exemplos: campos obrigatorios
      |nomeCampo|
      |zipCode|
      |street |
      |number|
      |birthDate|
      |cpf|
      |accountType|
      |name|

    Esquema do Cenario: Validar regras dos campos (<nomeCampo>)
      Dado que o campo "<nomeCampo>" é fornecido como "<valorCampo>"
      Quando efetuo a operação de POST no caminho "/holders"
      Entao a mensagem "<returnedMessage>" é retornada
      E status code <statusCode> é retornado

      Exemplos:
        |nomeCampo|valorCampo|statusCode|returnedMessage|
        |zipCode|abcd|400|Campo zipCode invalido|
        |birthDate|08-09-2020|400|Campo birthDate invalido|
        |birthDate|2015-08-09|412|Cadastro permitido somente para maiores de 18 anos|
        |birthDate|2029-12-31|412|Data de nascimento deve ser menor que data atual|
        |cpf|1234|400|Campo cpf deve conter 11 digitos|
        |cpf|123.456.789-12|400|Campo cpf invalido|
        |accountType|XT|400|Campo accountType deve ser PF ou PJ|
        |cnpj|1234|400|Campo cnpj deve conter 14 digitos|
        |cnpj|12.345.678/9123-45|400|Campo cnpj invalido|


  Esquema do Cenario: validar que "<nomeCampo>" é obrigatorio  para contas do tipo PJ
    Dado que o campo "accountType" é fornecido como "PJ"
    E que o campo "<nomeCampo>" não é informado na request
    Quando efetuo a operação de POST no caminho "/holders"
    Entao a mensagem "Campo <nomeCampo> nao informado" é retornada
    E status code 400 é retornado

    Exemplos:
      |nomeCampo|
      |cnpj     |
      |socialName|
