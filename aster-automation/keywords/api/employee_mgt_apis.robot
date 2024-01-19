*** Settings ***
Resource    ${CURDIR}/../../resources/imports.robot
Resource    ${CURDIR}/../../resources/testdata/common_configs.robot
Resource    ${CURDIR}/../../keywords/common/common_keywords.robot

*** Variables ***


*** Keywords ***
Query Employee
    DB_CONNECT
    @{query_employee}    Query    SELECT * FROM employee
    Log Many     @{query_employee}
    Set Test Variable    @{query_employee}
    DB_CLOSE
    [return]    ${query_employee}

Get Employee List Success
    [Documentation]    Get employee list success    
    [Arguments]    ${token}
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${token}    
    ${resp}=    GET    ${backoffice_api_url_SIT}${admin_employee_management_api}    headers=${headers}    expected_status=any
    ${resp}=    Set Variable    ${resp.json()}
    [Return]    ${resp}

Get Employee List Fail
    [Documentation]    Get employee list fail    
    [Arguments]    ${token}
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${token}    
    ${resp}=    GET    ${backoffice_api_url_SIT}${admin_employee_management_api}    headers=${headers}    expected_status=any
    ${resp}=    Set Variable    ${resp.json()}
    [Return]    ${resp}

Get Employee List But Token Is Not Send
    [Documentation]    Get Employee List But Token Is Not Send
    &{headers}=    Create Dictionary    Content-Type=application/json  
    ${resp}=    GET    ${backoffice_api_url_SIT}${admin_employee_management_api}    headers=${headers}    expected_status=any
    ${resp}=    Set Variable    ${resp.json()}
    [Return]    ${resp}

Get Employee List But Bearer Is Not Send 
    [Documentation]    Get employee list fail    
    [Arguments]    ${token}
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=${token}    
    ${resp}=    GET    ${backoffice_api_url_SIT}${admin_employee_management_api}    headers=${headers}    expected_status=any
    ${resp}=    Set Variable    ${resp.json()}
    [Return]    ${resp}

Get Employee List But Send Invalid Path
    [Documentation]    Call API GET User Success
    [Arguments]    ${token}  ${invalid_path}=Dummy
    &{headers}=    Create Dictionary    Content-Type=application/json  
    ${resp}=    GET    ${backoffice_api_url_SIT}${admin_employee_management_api}/${invalid_path}    headers=${headers}    expected_status=any
    ${resp}    Set Variable    ${resp}
    [Return]    ${resp}

Get Employee List But Send Invalid Method
    [Documentation]    Call API GET User Success
    [Arguments]    ${token}    
    &{headers}=    Create Dictionary    Content-Type=application/json  
    ${resp}=    PATCH    url=${backoffice_api_url_SIT}${admin_employee_management_api}    headers=${headers}    expected_status=any
    ${resp}    Set Variable    ${resp}
    [Return]    ${resp}

Validate All Of Field Name Is Correctly
    [Documentation]    Field name is completely
    [Arguments]     ${resp_data}  ${count_resp}
    ${length_resp}      Set Variable    ${count_resp}
    FOR    ${number}    IN RANGE  ${length_resp}
        FOR    ${item}    IN    ${resp_data[${number}]}
            Should Contain  ${item}    employeeId
            Should Contain  ${item}    firstName
            Should Contain  ${item}    lastName
            Should Contain  ${item}    email
            Should Contain  ${item}    contractStartDate
            Should Contain  ${item}    employeeStatus
            Should Contain  ${item}    updatedDate
            Should Contain  ${item}    createBy
        END
    END

Validate Employee ID Is Sort Data Correctly
    [Documentation]    Field name is completely
    [Arguments]     ${resp_data}  ${count_resp}
    ${length_resp}      Set Variable    ${count_resp}
    ${nums}      Set Variable    0  
    ${result2}    Convert To Integer    ${nums}
    FOR    ${number}    IN RANGE  ${length_resp}
        FOR    ${item}    IN    ${resp_data[${number}]["employeeId"]}
            ${result1}    Convert To Integer    ${item}
            Log   current number = ${result1}
            Log   previous number = ${result2}
            IF  ${result1} > ${result2} or ${result1} == ${result2}
                ${result2}      Set Variable    ${result1}
                Log    result1 = ${result1}
                Log    result2 = ${result2}
            END
        END
    END

User Can See Employee Status Is Available
    [Documentation]    Validate Employee Status Is Available
    [Arguments]     ${resp}  ${status_available}
    FOR    ${item}    IN    @{resp['data']}
        ${item_status}    Set Variable    ${item['employeeStatus']}
        Log    Item status: ${item_status}
        Log    Item expeted: ${status_available}
        ${result}    Run Keyword If  '${item_status}' == '${status_available}'    Set Variable    ${True}
        Exit For Loop If    '${result}' == '${True}'
    END
    Should Be True    ${result}

User Can See Employee Status Is Resign
    [Documentation]    Validate Employee Status Is Resign
    [Arguments]     ${resp}  ${status_resign}
    FOR    ${item}    IN    @{resp['data']}
        ${item_status}    Set Variable    ${item['employeeStatus']}
        Log    Item status: ${item_status}
        Log    Item expeted: ${status_resign}
        ${result}    Run Keyword If  '${item_status} == ${status_resign}'    Set Variable    ${True}
        Exit For Loop If    '${result}' == '${True}'
    END
    Should Be True    ${result}