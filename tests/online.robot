*** Settings ***
Documentation            Online

Resource    ../resources/base.resource

*** Test Cases ***
Webapp deve estar online

    Iniciar sessão
    Get Title       equal    Mark85 by QAx
