*** Settings ***
Documentation            Ações e elementos do cabeçalho do mark85

Library        Browser
Library        String

*** Keywords ***
Usuário deve estar logado
    [Arguments]        ${name}

    #Split String separa os nomes e armazena em um array(lista)
    ${splited_name}    Split String    ${name}
    ${element}         Set Variable    css=header .right small

    #garantir que o elemento está visível na tela e depois validar o texto
    Wait For Elements State        ${element}    visible    5

    Get Text    ${element}    equal    Olá, ${splited_name}[0]

#Vai para o formulário de cadastro de tarefas
Go to task form
    Click    css=.button-add