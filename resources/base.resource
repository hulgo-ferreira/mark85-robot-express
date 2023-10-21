*** Settings ***

Library    libs/database.py
Library    Browser
Library    JSONLibrary

Resource    env.resource

Resource    pages/components/Alert.resource
Resource    pages/components/Notice.resource
Resource    pages/components/Header.resource

Resource    pages/SignupPage.resource
Resource    pages/LoginPage.resource
Resource    pages/TaskCreatePage.resource
Resource    pages/TasksPage.resource

Resource    services.resource

*** Keywords ***
Iniciar sessão
    New Browser     browser=${BROWSER}    headless=False
    New Page        ${BASE_URL}

# Helpers (obter uma fixture)
Get fixture
    [Arguments]        ${file_name}        ${scenário}

    #diretório de execução do projeto, onde eu passo a massa de acordo com o nome do arquivo
    #carrega os dados do arquivo e armazena na variável ${data}
    ${data}    Load Json From File
    ...        ${EXECDIR}/resources/fixtures/${file_name}.json
    ...        encoding=utf-8

    # Retorno apenas a massa que eu quero
    [Return]    ${data}[${scenário}]

Reset user from database
    [Arguments]        ${user}

    Clean user from database      [user][email]
    Insert user from database     [user]

Create a new task from API
    [Arguments]        ${data}

    POST user session      ${data}[user]
    POST a new task        ${data}[task]

Do login
    [Arguments]        ${user}

    Submter fomulário de login    ${user}
    Usuário deve estar logado     ${user}[name]