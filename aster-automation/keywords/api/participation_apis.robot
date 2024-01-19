*** Settings ***
Resource    ${CURDIR}/../../resources/imports.robot
Resource    ${CURDIR}/../../resources/testdata/common_configs.robot
Resource    ${CURDIR}/../../keywords/common/common_keywords.robot

*** Variables ***
${participation_path}  /admin-service/v1/participation

*** Keywords ***
Get Participant By Session Id Success
    [Documentation]    Get Participant By Session Id Success
    [Arguments]    ${token}  ${session_id}
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${token}    
    ${resp}=    GET    url=${backoffice_api_url_SIT}${admin_participation_detail_by_session_id_api}${session_id}    headers=${headers}    expected_status=any
    ${resp}=    Set Variable    ${resp.json()}
    [Return]    ${resp}

Get Participant By Session Id Fail
    [Documentation]    Get Participant By Session Id Fail
    [Arguments]    ${token}  ${session_id}
    &{headers}=    Create Dictionary    Content-Type=application/json  Authorization=Bearer ${token}
    ${resp}=    GET    url=${backoffice_api_url_SIT}${admin_participation_detail_by_session_id_api}${session_id}    headers=${headers}    expected_status=any
    ${resp}=    Set Variable    ${resp.json()}
    [Return]    ${resp}

Get Participant By Session Id But Token Is Not Send
    [Documentation]    GET all events fail
    [Arguments]    ${session_id}
    &{headers}=    Create Dictionary    Content-Type=application/json  
    ${resp}=    GET    url=${backoffice_api_url_SIT}${admin_participation_detail_by_session_id_api}${session_id}    headers=${headers}    expected_status=any
    ${resp}=    Set Variable    ${resp.json()}
    [Return]    ${resp}

Get Participant By Session Id But Send Invalid Path
    [Documentation]    Call API GET User Success
    [Arguments]    ${token}  ${session_id}  ${invalid_path}=Dummy
    &{headers}=    Create Dictionary    Content-Type=application/json  
    ${resp}=    GET    url=${backoffice_api_url_SIT}${participation_path}/${invalid_path}${session_id}    headers=${headers}    expected_status=any
    ${resp}    Set Variable    ${resp}
    [Return]    ${resp}

Get Participant By Session Id But Send Invalid Method
    [Documentation]    Call API GET User Success
    [Arguments]    ${token}    ${session_id}
    &{headers}=    Create Dictionary    Content-Type=application/json  
    ${resp}=    POST    url=${backoffice_api_url_SIT}${admin_participation_detail_by_session_id_api}${session_id}    headers=${headers}    expected_status=any
    ${resp}    Set Variable    ${resp}
    [Return]    ${resp}

Query Participant
    [Arguments]    ${session_id}  
    DB_CONNECT
    @{query_participant}    Query    SELECT * FROM registered_session_user WHERE session_id = ${session_id}
    Log Many     @{query_participant}
    Set Test Variable    @{query_participant}
    DB_CLOSE
    [return]    ${query_participant}

Validate All Of Field Name Is Correctly
    [Documentation]    Field name is completely
    [Arguments]     ${resp_data}  ${count_resp}
    ${length_resp}      Set Variable    ${count_resp}
    FOR    ${number}    IN RANGE  ${length_resp}
        FOR    ${item}    IN    ${resp_data[${number}]}
            Should Contain  ${item}     walletAddress         
            Should Contain  ${item}     employeeId         
            Should Contain  ${item}     name         
            Should Contain  ${item}     email         
            Should Contain  ${item}     registrationType         
            Should Contain  ${item}     participateToken         
            Should Contain  ${item}     extraToken         
            Should Contain  ${item}     userRegistrationDate         
            Should Contain  ${item}     tShirtSize         
            Should Contain  ${item}     requestedFood         
            Should Contain  ${item}     foodAllergies         
            Should Contain  ${item}     deliveryAddress         
            Should Contain  ${item}     phoneNumber         
            Should Contain  ${item}     isJoin         
        END
    END

Validate Data Is Empty
    [Documentation]    Validate Data Is Empty
    [Arguments]     ${resp_data}
    Should Be Empty    ${resp_data}    @{EMPTY}


