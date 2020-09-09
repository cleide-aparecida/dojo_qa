#language: pt
@REGRESSION
  Funcionalidade: Consultar endereço Correntista
    "Funcionalidade responsável pelo retorno do endereço de um
    correntista através do filtro CPF e Tipo de Conta."

  Contexto:
    Dado que já possuo alguns correntistas cadastrados no sistema

  @SMOKE
  Cenario: Consultar endereço do correntista com sucessso
    Dado que possuo as informações de CFP
    E tipo da conta do correntista
    Quando a consulta de endereço é executada
    Então o endereço correto do correntista é retornado

  Esquema do Cenario: Validar regras dos filtros
    Dado que possuo a informação de <info1> como sendo "<valor>"
    Mas não possuo o <info2> do correntista
    Quando a consulta de endereço é executada
    Então a mensagem "Campo <info2> não informado" é retornada

    Exemplos:
     |info1|info2|valor|
     |cpf|tipo de conta|123456789789|
     |tipo de conta|cpf|PJ          |

  Cenario: Correntista não encontrado no sistema
    Dado que possuo um CFP valido
    Mas que não esta cadastrado no sistema
    E um tipo da conta valida do correntista
    Quando efetuo a consulta de endereço é executada
    Então a mensagem "Correntista não encontrado" é retornada

   Cenario: Verificar que o tipo de conta deve ser PJ ou PF
    Dado que possuo a informação de CPF valido
    E tipo de conta do correntista sendo XT
    Quando efetuo a consulta de endereço
    Então a mensagem "Campo accountType deve ser PF ou PJ" é retornada

    Cenario: Verificar que não é possível consultar um cpf que não possui 11 digitos
     Dado que possuo a informação de CPF diferente de 11 digitos
     E tipo de conta do correntista sendo valido
     Quando efetuo a consulta de endereço
     Então a mensagem "Campo cpf deve conter 11 digitos" é retornada






