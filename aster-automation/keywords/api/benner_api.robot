*** Settings ***
Resource    ${CURDIR}/../../resources/imports.robot
Resource    ${CURDIR}/../../resources/testdata/common_configs.robot
Resource    ${CURDIR}/../../keywords/common/common_keywords.robot
Resource    ${CURDIR}/../../resources/api/all_api_backoffice.robot


*** Keywords ***
GET Session Banner List Success
    [Documentation]    Get session banner list for preview in back office success
    [Arguments]    ${token} 
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${token}    
    ${resp}=    GET    ${backoffice_api_url_SIT}${admin_banner_managenent_api}    headers=${headers}    expected_status=any
    ${resp}=    Set Variable    ${resp.json()}
    [Return]    ${resp} 

GET Session Banner List Failed
    [Documentation]    GET get session banner list for preview in back office failed
    [Arguments]    ${token}
    &{headers}    Create Dictionary    Content-Type=application/json    
    Run Keyword If    '${token}' !='*REMOVE*'    Set To Dictionary    ${headers}    Authorization=Bearer ${token}    
    ${resp}    GET    ${backoffice_api_url_SIT}${admin_banner_managenent_api}    headers=${headers}    expected_status=any
    ${resp}    Set Variable    ${resp.json()}
    [Return]    ${resp}

Get Session Banner But Bearer Is Not Send
    [Documentation]    GET get session banner list for preview in back office failed
    [Arguments]    ${token}
    &{headers}    Create Dictionary    Content-Type=application/json    Authorization=${token}
    ${resp}    GET    ${backoffice_api_url_SIT}${admin_banner_managenent_api}    headers=${headers}    expected_status=any
    ${resp}    Set Variable    ${resp.json()}
    [Return]    ${resp}

Get Session Banner But Send Invalid Path
    [Documentation]    GET get session banner list for preview in back office failed
    [Arguments]    ${token}
    &{headers}=    Create Dictionary    Content-Type=application/json  
    ${resp}     GET    ${backoffice_api_url_SIT}${admin_banner_managenent_api}aaa    headers=${headers}    expected_status=any
    ${resp}    Set Variable    ${resp}
    [Return]    ${resp}

OPTIONS Session Banner But Send Invalid Method
    [Documentation]    GET get session banner list for preview in back office failed
    [Arguments]    ${token}  
    &{headers}=    Create Dictionary    Content-Type=application/json   Authorization=Bearer ${token}  
    ${resp}     OPTIONS    ${backoffice_api_url_SIT}${admin_banner_managenent_api}    headers=${headers}    expected_status=any
    ${resp}    Set Variable    ${resp}
    [Return]    ${resp}


Query Session Banner
    DB_CONNECT
    @{query_banner}    Query    select * from banner where status='active' and is_delete=false;
    Log Many     @{query_banner}
    Set Test Variable    @{query_banner}
    DB_CLOSE
    [return]    ${query_banner}

