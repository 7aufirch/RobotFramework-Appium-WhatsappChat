*** Settings ***
Library         AppiumLibrary

*** Variables ***
${AppiumServer}=                http://127.0.0.1:8080/wd/hub
${automationName}=              Appium
${platformName}=                Android
${appPackage}=                  com.whatsapp
${appActivity}=                 com.whatsapp.HomeActivity

*** Keywords ***
Open Whatsapp
    [Arguments]     ${alias}        ${UID}      ${url}      ${resetStatus}
    Open Application        ${url}      ${alias}       platformName=${platformName}     deviceName=${UID}     appPackage=${appPackage}       appActivity=${appActivity}       noReset=${resetStatus}
    Sleep       3

Send chat
    [Arguments]     ${message}
    Click element        com.whatsapp:id/entry
    input value       com.whatsapp:id/entry       ${message}
    Click element       id=com.whatsapp:id/send

Read last chat
    Sleep       3
    ${count}=       Get Matching Xpath Count        //android.widget.TextView[contains(@resource-id,'message_text')]
    ${Msg}=        Get Text            xpath=(//android.widget.TextView[contains(@resource-id,'message_text')])[${count}]
    [Return]        ${Msg}

*** Test Cases ***
Chating
    Open Whatsapp       MiA1        0550d2e10504        http://127.0.0.1:8080/wd/hub        True
    Click text      My Love     True
    Send chat       👽(Upik) : hallo
    ${Message}=     Read last chat
    run keyword if      '${Message}'=='👽(Upik) : hallo'        Send chat      💩(Nessa) : hallo juga
    ${Message}=     Read last chat
    run keyword if      '${Message}'=='💩(Nessa) : hallo juga'        Send chat      👽(Upik) : Love you
    ${Message}=     Read last chat
    run keyword if      '${Message}'=='👽(Upik) : Love you'        Send chat      💩(Nessa) : Love you too
    ${Message}=     Read last chat