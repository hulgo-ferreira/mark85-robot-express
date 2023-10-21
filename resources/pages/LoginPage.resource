*** Settings ***
Documentation            Ações e elementos da página de login

Library         Browser

*** Keywords ***
Submter fomulário de login
    [Arguments]        ${user}

    Fill Text    css=input[placeholder$=mail]    ${user}[email]
    Fill Text    css=input[placeholder=Senha]    ${user}[password]

    Click        css=button >> text=Entrar


    
