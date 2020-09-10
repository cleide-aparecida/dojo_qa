#language: pt
@REGRESSION
  Funcionalidade: Consultar endereço Correntista
    "Funcionalidade responsável pelo retorno do endereço de um
    correntista através do filtro CPF e Tipo de Conta."

  Contexto:
    Dado que já possuo 1 correntistas cadastrados no sistema

  @SMOKE
  Cenario: Consultar endereço do correntista com sucessso
    Dado que possuo as informações de CFP valido
    E tipo da conta do correntista
    Quando efetuo a consulta de endereço
    Então o endereço correto do correntista é retornado

  Esquema do Cenario: Validar regras dos filtros
    Dado que possuo a informação de <info1> como sendo "<valor>"
    Mas não possuo o <info2> do correntista
    Quando efetuo a consulta de endereço
    Então a mensagem "Campo <info2> nao informado" é retornada na consulta

    Exemplos:
     |info1|info2|valor|
     |cpf|tipo de conta|123456789789|
     |tipo de conta|cpf|PJ          |

  Cenario: Correntista não encontrado no sistema
    Dado que possuo um CFP valido que não esta cadastrado no sistema
    E um tipo da conta valida do correntista
    Quando efetuo a consulta de endereço
    Então a mensagem "Correntista nao encontrado" é retornada na consulta

   Cenario: Verificar que o tipo de conta deve ser PJ ou PF
    Dado que possuo as informações de CFP valido
    E tipo de conta do correntista sendo XT
    Quando efetuo a consulta de endereço
    Então a mensagem "Campo accountType deve ser PF ou PJ" é retornada na consulta

    Cenario: Verificar que não é possível consultar um cpf que não possui 11 digitos
     Dado que possuo a informação de CPF diferente de onze digitos
     E um tipo da conta valida do correntista
     Quando efetuo a consulta de endereço
     Então a mensagem "Campo cpf deve conter 11 digitos" é retornada na consulta






