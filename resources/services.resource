*** Settings ***
Documentation            Consumindo a API REST do sistema Mark85

Library        RequestsLibrary

*** Keywords ***
POST user session
    [Arguments]        ${user}

    ${payload}         Create Dictionary
    ...    email=${user}[email]
    ...    password=${user}[password]

    ${resp}    POST    url=http://localhost:3333/sessions
    ...     json=${payload}
    ...     expected_status=200

    #estou armazenando o valor do token na variável token
    ${token}    Set Variable    ${resp.json()}[token]

    Set Test Variable    ${token}

#cadastrar uma nova tarefa
POST a new task
    [Arguments]        ${payload}

    ${headers}         Create Dictionary
    ...     Authorization=${token}

    POST    url=http://localhost:3333/tasks
    ...     json=${payload}
    ...     headers=${headers}
    ...     expected_status=201