*** Settings ***
Resource    ${CURDIR}/../../resources/imports.robot
Resource    ${CURDIR}/../../resources/testdata/common_configs.robot
Resource    ${CURDIR}/../../keywords/common/common_keywords.robot


*** Keywords ***

Get All Event Success
    [Documentation]    Get all event success
    [Arguments]    ${token}
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${token}    
    ${resp}=    GET    ${backoffice_api_url_SIT}/admin-service/v1/events    headers=${headers}    expected_status=any
    ${resp}=    Set Variable    ${resp.json()}
    [Return]    ${resp}

Get All Event Fail
    [Documentation]    GET all events fail
    [Arguments]    ${token}
    &{headers}=    Create Dictionary    Content-Type=application/json  Authorization=Bearer ${token}
    ${resp}=    GET    ${backoffice_api_url_SIT}/admin-service/v1/events    headers=${headers}    expected_status=any
    ${resp}=    Set Variable    ${resp.json()}
    [Return]    ${resp}

Get Event But Bearer Is Not Send
    [Documentation]    GET all events fail
    [Arguments]    ${token}
    &{headers}=    Create Dictionary    Content-Type=application/json  Authorization=${token}
    ${resp}=    GET    ${backoffice_api_url_SIT}/admin-service/v1/events    headers=${headers}    expected_status=any
    ${resp}=    Set Variable    ${resp.json()}
    [Return]    ${resp}

Get Event But Token Is Not Send
    [Documentation]    GET all events fail
    &{headers}=    Create Dictionary    Content-Type=application/json  
    ${resp}=    GET    ${backoffice_api_url_SIT}/admin-service/v1/events    headers=${headers}    expected_status=any
    ${resp}=    Set Variable    ${resp.json()}
    [Return]    ${resp}

Get Event But Send Invalid Path
    [Documentation]    Call API GET User Success
    [Arguments]    ${token}    ${invalid_path}=Dummy
    &{headers}=    Create Dictionary    Content-Type=application/json  Authorization=${token}
    ${resp}     GET    ${backoffice_api_url_SIT}/admin-service/v1/events/${invalid_path}    headers=${headers}    expected_status=any
    ${resp}    Set Variable    ${resp}
    [Return]    ${resp}

Get Event But Send Invalid Method
    [Documentation]    Call API GET User Success
    [Arguments]    ${token}    
    &{headers}=    Create Dictionary    Content-Type=application/json  
    ${resp}     POST    ${backoffice_api_url_SIT}/admin-service/v1/events    headers=${headers}    expected_status=any
    ${resp}    Set Variable    ${resp}
    [Return]    ${resp}

Query Events
    DB_CONNECT
    @{query_events}    Query    SELECT * FROM events
    Log Many     @{query_events}
    Set Test Variable    @{query_events}
    DB_CLOSE
    [return]    ${query_events}

Validate All Of Field Name Is Correctly
    [Documentation]    Field name is completely
    [Arguments]     ${resp_data}  ${count_resp}
    ${length_resp}      Set Variable    ${count_resp}
    FOR    ${number}    IN RANGE  ${length_resp}
        FOR    ${item}    IN    ${resp_data[${number}]}
            Should Contain  ${item}    id
            Should Contain  ${item}    name
            Should Contain  ${item}    image
            Should Contain  ${item}    tag
        END
    END

