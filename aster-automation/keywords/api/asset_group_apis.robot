*** Settings ***
Resource    ${CURDIR}/../../resources/imports.robot
Resource    ${CURDIR}/../../resources/testdata/common_configs.robot
Resource    ${CURDIR}/../../keywords/common/common_keywords.robot

*** Variables ***


*** Keywords ***
Query Group Category
    # [Arguments]    ${session_id}  
    DB_CONNECT
    @{query_participant}    Query    SELECT * FROM asset_group_category
    Log Many     @{query_participant}
    Set Test Variable    @{query_participant}
    DB_CLOSE
    [return]    ${query_participant}

Get All Assets Group Success
    [Documentation]    Get all assets group success
    [Arguments]    ${token}  ${parameter}
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${token}    
    ${resp}=    GET    url=${backoffice_api_url_SIT}${admin_assets_group_api}?${parameter}   headers=${headers}    expected_status=any
    ${resp}=    Set Variable    ${resp.json()}
    [Return]    ${resp}

Get All Assets Group Fail
    [Documentation]    GET all assets group fail
    [Arguments]    ${token}  ${parameter}
    &{headers}=    Create Dictionary    Content-Type=application/json  Authorization=Bearer ${token}
    ${resp}=    GET    url=${backoffice_api_url_SIT}${admin_assets_group_api}?${parameter}   headers=${headers}    expected_status=any
    ${resp}=    Set Variable    ${resp.json()}
    [Return]    ${resp}

Get All Assets Group But Bearer Is Not Send
    [Documentation]    GET all assets group fail
    [Arguments]    ${token}  ${parameter}
    &{headers}=    Create Dictionary    Content-Type=application/json  Authorization=${token}
    ${resp}=    GET    url=${backoffice_api_url_SIT}${admin_assets_group_api}?${parameter}   headers=${headers}    expected_status=any
    ${resp}=    Set Variable    ${resp.json()}
    [Return]    ${resp}
    
Get All Assets Group But Token Is Not Send
    [Documentation]    GET all events fail
    &{headers}=    Create Dictionary    Content-Type=application/json  
    ${resp}=    GET    url=${backoffice_api_url_SIT}${admin_assets_group_api}   headers=${headers}    expected_status=any
    ${resp}=    Set Variable    ${resp.json()}
    [Return]    ${resp}

Get All Assets Group But Send Invalid Path
    [Documentation]    Call API GET User Success
    [Arguments]    ${token}    ${invalid_path}=Dummy
    &{headers}=    Create Dictionary    Content-Type=application/json  
    ${resp}=    GET    url=${backoffice_api_url_SIT}${admin_assets_group_api}${invalid_path}   headers=${headers}    expected_status=any
    ${resp}    Set Variable    ${resp}
    [Return]    ${resp}

Get All Assets Group But Send Invalid Method
    [Documentation]    Call API GET User Success
    [Arguments]    ${token}    
    &{headers}=    Create Dictionary    Content-Type=application/json  Authorization=${token}
    ${resp}=    POST    url=${backoffice_api_url_SIT}${admin_assets_group_api}   headers=${headers}    expected_status=any
    ${resp}    Set Variable    ${resp}
    [Return]    ${resp}

Validate All Of Field Name Is Correctly
    [Documentation]    Field name is completely
    [Arguments]     ${resp_data}  ${count_resp}
    ${length_resp}      Set Variable    ${count_resp}
    FOR    ${number}    IN RANGE  ${length_resp}
        FOR    ${item}    IN    ${resp_data[${number}]}
            Should Contain  ${item}              id
            Should Contain  ${item}              category
            Should Contain  ${item["category"]}  id
            Should Contain  ${item["category"]}  name
            Should Contain  ${item["category"]}  type
            Should Contain  ${item}              group
            Should Contain  ${item["group"]}     id
            Should Contain  ${item["group"]}     name
            Should Contain  ${item}              contractAddress
        END
    END