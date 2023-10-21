*** Settings ***
Documentation            Cenários de autenticação do usuário

Library          Collections
Resource         ../resources/base.resource

Test Setup       Iniciar sessão
Test Teardown    Take Screenshot

*** Test Cases ***
Deve poder logar com um usuário pré-cadastrado
    [Tags]    user-pre

    ${user}    Create Dictionary
    ...        name=Hulgo Ferreira
    ...        email=hulgo@msn.com
    ...        password=123456

    #aqui estou deletando e recriando os dados do banco e garanto que a massa está correta
    Remove user from database    ${user}[email]
    Insert user from database    ${user}

    Submter fomulário de login    ${user}
    Usuário deve estar logado     ${user}[name]

Não deve logar com senha inválida

    #montando a massa
    ${user}    Create Dictionary
    ...        name=Steve Woz
    ...        email=woz@apple.com
    ...        password=123456

    #apagando no banco os dados para ter acertividade
    Remove user from database    ${user}[email]
    #criando o usuário Steve Woz com os dados e a senha 123456
    Insert user from database    ${user}

    #alterei a senha do usuário para outra senha que não era pra usar no usuário
    Set To Dictionary    ${user}    password=abc123

    Submter fomulário de login    ${user}
    Notice should be              Ocorreu um erro ao fazer login, verifique suas credenciais.
    #implementei a palavra chave "Notice should be" que é um componente(arquivo) global no projeto