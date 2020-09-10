Feature:

###########################
# POST /holders           #
###########################

Scenario: methodIs('post') && pathMatches('/api/v1/holders') && typeof request.holder.addres.zipCode == 'number' && typeof request.holder.addres.street == 'string' && typeof request.holder.addres.number == 'number'
&& typeof request.holder.addres.complement == 'object' && typeof request.holder.birthDate == 'string' && typeof request.holder.cpf == 'string' && typeof request.holder.accountType == 'string'
&& typeof request.holder.name == 'string' && typeof request.holder.socialName == 'object' && typeof request.holder.cnpj == 'object'
* def response =  {"holderId": '123456' }
* def responseStatus =  201
* if (responseStatus == 201) karate.abort()

Scenario: methodIs('post') && pathMatches('/api/v1/holders') && typeof request.holder.address.zipCode != 'object' && typeof request.holder.address.zipCode != 'number'
* def response =  {"message": "Campo zipCode invalido"}
* def responseStatus = 400
* if (responseStatus == 400) karate.abort()

Scenario: methodIs('post') && pathMatches('/api/v1/holders') && request.holder.accountType == 'PJ'
* def resp = {"holderId": '123456' }
* def response =  typeof request.holder.cnpj == 'object' ? {"message": "Campo cnpj nao informado"} : resp
* def responseStatus = typeof request.holder.cnpj == 'object' ? 400 : 201
* if (responseStatus == 400) karate.abort()

* def response =  typeof request.holder.socialName == 'object' ? {"message": "Campo socialName nao informado"} : resp
* def responseStatus = typeof request.holder.socialName == 'object' ? 400 : 201
* if (responseStatus == 400) karate.abort()

Scenario: methodIs('post') && pathMatches('/api/v1/holders') &&  request.holder.birthDate != '08-09-2020' && request.holder.birthDate != '2015-08-09' && request.holder.birthDate != '2029-12-31'
&& request.holder.cpf != 1234 && request.holder.cpf != '123.456.789-12' && request.holder.accountType != 'XT'  && request.holder.cnpj != 1234 && request.holder.cnpj != '12.345.678/9123-45'
* def resp = {"holderId": '123456' }

* def response = typeof request.holder.address.zipCode == 'object' ? {"message": "Campo zipCode nao informado"} : resp
* def responseStatus = typeof request.holder.address.zipCode == 'object' ? 400 : 201
* if (responseStatus == 400) karate.abort()

* def response = typeof request.holder.address.street == 'object' ? {"message": "Campo street nao informado"} : resp
* def responseStatus = typeof request.holder.address.street == 'object' ? 400 : 201
* if (responseStatus == 400) karate.abort()

* def response = typeof request.holder.address.number == 'object' ? {"message": "Campo number nao informado"} : resp
* def responseStatus = typeof request.holder.address.number == 'object' ? 400 : 201
* if (responseStatus == 400) karate.abort()

* def response = typeof request.holder.birthDate == 'object' ? {"message": "Campo birthDate nao informado"} : resp
* def responseStatus = typeof request.holder.birthDate == 'object' ? 400 : 201
* if (responseStatus == 400) karate.abort()

* def response = typeof request.holder.cpf == 'object' ? {"message": "Campo cpf nao informado"} : resp
* def responseStatus = typeof request.holder.cpf == 'object' ? 400 : 201
* if (responseStatus == 400) karate.abort()

* def response = typeof request.holder.accountType == 'object' ? {"message": "Campo accountType nao informado"} : resp
* def responseStatus = typeof request.holder.accountType == 'object' ? 400 : 201
* if (responseStatus == 400) karate.abort()

* def response = typeof request.holder.name == 'object' ? {"message": "Campo name nao informado"} : resp
* def responseStatus = typeof request.holder.name == 'object' ? 400 : 201
* if (responseStatus == 400) karate.abort()

Scenario: methodIs('post') && pathMatches('/api/v1/holders') && request.holder.birthDate == '08-09-2020'
* def response =  {"message": "Campo birthDate invalido"}
* def responseStatus = 400
* if (responseStatus == 400) karate.abort()

Scenario: methodIs('post') && pathMatches('/api/v1/holders') && request.holder.birthDate == '2015-08-09'
* def response =  {"message": "Cadastro permitido somente para maiores de 18 anos"}
* def responseStatus = 412
* if (responseStatus == 412) karate.abort()

Scenario: methodIs('post') && pathMatches('/api/v1/holders') && request.holder.birthDate == '2029-12-31'
* def response =  {"message": "Data de nascimento deve ser menor que data atual"}
* def responseStatus = 412
* if (responseStatus == 412) karate.abort()

Scenario: methodIs('post') && pathMatches('/api/v1/holders') && request.holder.cpf == 1234
* def response =  { "message": "Campo cpf deve conter 11 digitos"}
* def responseStatus =  400
* if (responseStatus == 400) karate.abort()

Scenario: methodIs('post') && pathMatches('/api/v1/holders') && request.holder.cpf == '123.456.789-12'
* def response =  { "message": "Campo cpf invalido"}
* def responseStatus =  400
* if (responseStatus == 400) karate.abort()

Scenario: methodIs('post') && pathMatches('/api/v1/holders') && request.holder.accountType == 'XT'
* def response =  { "message": "Campo accountType deve ser PF ou PJ"}
* def responseStatus =  400
* if (responseStatus == 400) karate.abort()

Scenario: methodIs('post') && pathMatches('/api/v1/holders') && request.holder.cnpj == 1234
* def response =  { "message": "Campo cnpj deve conter 14 digitos"}
* def responseStatus =  400
* if (responseStatus == 400) karate.abort()

Scenario: methodIs('post') && pathMatches('/api/v1/holders') && request.holder.cnpj == '12.345.678/9123-45'
* def response =  { "message": "Campo cnpj invalido"}
* def responseStatus =  400
* if (responseStatus == 400) karate.abort()



###########################
# GET /holders/address    #
###########################

Scenario: methodIs('get') && pathMatches('/api/v1/holders/address') || paramExists('cpf') || paramExists('accountType')
* def myResponse = {"address": {"zipCode": "string","street": "string","number": numeric,"complement": "string"}}

* def response = paramExists('cpf') ? myResponse : {"message": "Campo cpf nao informado"}
* def responseStatus = paramExists('cpf')  ? 200 : 400
* if (responseStatus == 400) karate.abort()

* def response = paramExists('accountType') ? myResponse : { "message": "Campo tipo de conta nao informado"}
* def responseStatus = paramExists('accountType') ? 200 : 400
* if (responseStatus == 400) karate.abort()

* def response = paramValue('accountType') == 'PF' || paramValue('accountType') == 'PJ' ? myResponse : { "message": "Campo accountType deve ser PF ou PJ"}
* def responseStatus = paramValue('accountType') == 'PJ' || paramValue('accountType') == 'PF' ? 200 : 400
* if (responseStatus == 400) karate.abort()

* def response = paramValue('cpf').length == 11  ? myResponse : { "message": "Campo cpf deve conter 11 digitos"}
* def responseStatus = paramValue('cpf').length == 11 ? 200 : 400
* if (responseStatus == 400) karate.abort()

* def response = paramValue('cpf') != '00000000000'  ? myResponse : { "message": "Correntista nao encontrado"}
* def responseStatus = paramValue('cpf') != '00000000000' ? 200 : 404
* if (responseStatus == 404) karate.abort()

