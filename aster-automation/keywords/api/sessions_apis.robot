*** Settings ***
Resource    ${CURDIR}/../../resources/imports.robot
Resource    ${CURDIR}/../../resources/testdata/common_configs.robot
Resource    ${CURDIR}/../../keywords/common/common_keywords.robot


*** Keywords ***

Query Sessions
    DB_CONNECT
    @{query_sessions}    Query    SELECT * FROM session_list
    Log Many     @{query_sessions}
    Set Test Variable    @{query_sessions}
    DB_CLOSE
    [return]    ${query_sessions}

Get All Sessions Success
    [Documentation]    Get all sessions success
    [Arguments]    ${token}
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${token}    
    ${resp}=    GET    ${backoffice_api_url_SIT}/admin-service/v1/sessions    headers=${headers}    expected_status=any
    ${resp}=    Set Variable    ${resp.json()}
    [Return]    ${resp}

Get All Sessions fail permission
    [Documentation]    Get all sessions success
    [Arguments]    ${token}
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${token}    
    ${resp}=    GET    ${backoffice_api_url_SIT}/admin-service/v1/sessions    headers=${headers}    expected_status=any
    ${resp}=    Set Variable    ${resp.json()}
    [Return]    ${resp}

Get All Sessions Fail
    [Documentation]    GET all Sessions fail
    [Arguments]    ${token}
    &{headers}=    Create Dictionary    Content-Type=application/json  Authorization=Bearer ${token}
    ${resp}=    GET    ${backoffice_api_url_SIT}/admin-service/v1/sessions    headers=${headers}    expected_status=any
    ${resp}=    Set Variable    ${resp.json()}
    [Return]    ${resp}

Get Sessions But Bearer Is Not Send
    [Documentation]    GET all Sessions fail
    [Arguments]    ${token}
    &{headers}=    Create Dictionary    Content-Type=application/json  Authorization=${token}
    ${resp}=    GET    ${backoffice_api_url_SIT}/admin-service/v1/sessions    headers=${headers}    expected_status=any
    ${resp}=    Set Variable    ${resp.json()}
    [Return]    ${resp}

Get Sessions But Token Is Not Send
    [Documentation]    GET all Sessions fail
    &{headers}=    Create Dictionary    Content-Type=application/json  
    ${resp}=    GET    ${backoffice_api_url_SIT}/admin-service/v1/sessions    headers=${headers}    expected_status=any
    ${resp}=    Set Variable    ${resp.json()}
    [Return]    ${resp}




Get Sessions But Send Invalid Path
    [Documentation]    Get Sessions But Send Invalid Path
    [Arguments]    ${token}    
    &{headers}=    Create Dictionary    Content-Type=application/json  
    ${resp}     GET    ${backoffice_api_url_SIT}/admin-service/v1/sessionss    headers=${headers}    expected_status=any
    ${resp}    Set Variable    ${resp}
    [Return]    ${resp}

Put Sessions But Send Invalid Method
    [Documentation]    Put Sessions But Send Invalid Method
    [Arguments]    ${token}    
    &{headers}=    Create Dictionary    Content-Type=application/json  
    ${resp}     PUT    ${backoffice_api_url_SIT}/admin-service/v1/sessions    headers=${headers}    expected_status=any
    ${resp}    Set Variable    ${resp}
    [Return]    ${resp}