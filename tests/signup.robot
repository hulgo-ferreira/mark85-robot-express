*** Settings ***
Documentation            Cenários de testes do cadastro de usuários

Resource    ../resources/base.resource

#Ganchos
Suite Setup        Log    Tudo aqui ocorre antes da Suite (antes de todos os testes)
Suite Teardown     Log    Tudo aqui ocorre depois da Suite (depois de todos os testes)

#Ganchos que será executado antes e depois de cada teste
Test Setup       Iniciar sessão
Test Teardown    Take Screenshot

*** Test Cases ***
Deve poder cadastrar um novo usuário

    #criação de super variáveis
    ${user}         Create Dictionary    
    ...    name=Hulgo Ferreira    
    ...    email=hulgo@yahoo.com    
    ...    password=pwd123

#realizo a exclusão por email pra garantir que a massa é boa
    Remove user from database    ${user}[email]

    Acessar a página de cadastro
    Submeter formulário de cadastro    ${user}
    Notice should be                   Boas vindas ao Mark85, o seu gerenciador de tarefas.

Não deve permitir o cadastro com email duplicado
    [Tags]    dup

    #criação de super variáveis
    ${user}         Create Dictionary
    ...        name=Hulgo Rafael
    ...        email=rafael@gmail.com
    ...        password=pwd123
    
    Remove user from database    ${user}[email]    #remove o usuario do banco pelo email
    Insert user from database    ${user}           #insere um novo usuario

    Acessar a página de cadastro
    Submeter formulário de cadastro    ${user}
    Notice should be                   Oops! Já existe uma conta com o e-mail informado.

Campos obrigatórios
    [Tags]    required

    #Massa de teste que valida o campo vazio a variável de ambiente ${EMPTY}
    ${user}        Create Dictionary
    ...            name=${EMPTY}
    ...            email=${EMPTY}
    ...            password=${EMPTY}

    Acessar a página de cadastro
    Submeter formulário de cadastro    ${user}
    
    Alert should be    Informe seu nome completo
    Alert should be    Informe seu e-email
    Alert should be    Informe uma senha com pelo menos 6 digitos

Não deve cadastrar com email incorreto
    [Tags]         inv_email

    ${user}        Create Dictionary
    ...            name=Charles Xavier
    ...            email=xavier.com.br
    ...            password=123456

    Acessar a página de cadastro
    Submeter formulário de cadastro    ${user}
    Alert should be                    Digite um e-mail válido

Não deve cadastrar com senha muito curta
    [Tags]    temp

    #variável que tem uma lista de dados (lista de senhas)
    @{password_list}   Create List    1    12    123    1234    12345

    #usando FOR para percorrer uma lista de senhas para validação do campo senha
    FOR  ${password}    IN    @{password_list}  
        ${user}        Create Dictionary
        ...            name=Hulgo Ferreira
        ...            email=hulgo@msn.com
        ...            password=${password}

        Acessar a página de cadastro
        Submeter formulário de cadastro    ${user}
        
        Alert should be    Informe uma senha com pelo menos 6 digitos
    END