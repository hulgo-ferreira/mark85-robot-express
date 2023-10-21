*** Settings ***
Documentation            Cenários de tentativa de cadastro com senha muito curta

Resource             ../resources/base.resource
#Esse template suite de teste chama a Keyword Short password
Test Template        Short password

Test Setup           Iniciar sessão
Test Teardown        Take Screenshot

*** Test Cases ***
Não deve logar com senha de 1 digito     1 
Não deve logar com senha de 2 digitos    12
Não deve logar com senha de 3 digitos    123
Não deve logar com senha de 4 digitos    1234
Não deve logar com senha de 5 digitos    12345

# Este é um template de suite que valida a senha com poucos caracteres e que está sendo usado em todos os testes desse arquivo.
*** Keywords ***
Short password
    [Arguments]        ${short_pass}

    #Massa de teste que valida o campo vazio a variável de ambiente ${EMPTY}
    ${user}        Create Dictionary
    ...            name=Hulgo Ferreira
    ...            email=hulgo@msn.com
    ...            password=${short_pass}

    Acessar a página de cadastro
    Submeter formulário de cadastro    ${user}
    
    Alert should be    Informe uma senha com pelo menos 6 digitos
