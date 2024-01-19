*** Settings ***
Resource    ${CURDIR}/../../../resources/imports.robot
Resource    ${CURDIR}/../../../keywords/common/common_keywords.robot
Resource    ${CURDIR}/../../../keywords/api/employee_mgt_apis.robot

*** Variables ***
${status_available}  available
${status_resign}     resign

*** Test Cases ***
TC-01-001
    [Documentation]    GET employee list success,
    ...    In case of:
    ...    - valid session token 
    ${query_employee}    Query Employee
    ${count_query}    Get Length    ${query_employee}
    ${resp}    Get Employee List Success    ${admin_session_token}
    Assert Http Status Code Is 200 Ok   
    Assert Response Status Object With 2000 Success    ${resp}
    ${count_resp}    Get Length     ${resp['data']}
    Should Be Equal    ${count_query}    ${count_resp}
    Validate All Of Field Name Is Correctly  ${resp['data']}  ${count_resp}

TC-01-002
    [Documentation]    GET employee list success,
    ...    In case of:
    ...    - sort data correctly : employeeId sort data by (ASC)
    ${query_employee}    Query Employee
    ${count_query}    Get Length    ${query_employee}
    ${resp}    Get Employee List Success    ${admin_session_token}
    Assert Http Status Code Is 200 Ok   
    Assert Response Status Object With 2000 Success    ${resp}
    ${count_resp}    Get Length     ${resp['data']}
    Should Be Equal    ${count_query}    ${count_resp}
    Validate Employee ID Is Sort Data Correctly    ${resp['data']}  ${count_resp}

TC-01-003
    [Documentation]    GET employee list success,
    ...    In case of:
    ...    - user can see Employee status is "Available"
    ${resp}    Get Employee List Success    ${admin_session_token}
    Assert Http Status Code Is 200 Ok   
    Assert Response Status Object With 2000 Success    ${resp}
    User Can See Employee Status Is Available  ${resp}  ${status_available}

TC-01-004
    [Documentation]    GET employee list success,
    ...    In case of:
    ...    - user can see Employee status is "Resign"
    ${resp}    Get Employee List Success    ${admin_session_token}
    Assert Http Status Code Is 200 Ok   
    Assert Response Status Object With 2000 Success    ${resp}
    User Can See Employee Status Is Resign  ${resp}  ${status_resign}

TC-02-001
    [Documentation]    GET employee list fail,
    ...    In case of:
    ...    - user doesn't have permission (only admin)
    ${resp}    Get Employee List Fail    ${user_management_session_token}
    Assert Http Status Code Is 403 Dont Have Permission
    Assert Response Status Object With 4030 User Doesn't Have Permission    ${resp}

TC-03-001
    [Documentation]    GET employee list fail,
    ...    In case of:
    ...    - invalid session token
    ${resp}    Get Employee List Fail    ${admin_session_token}123
    Assert Http Status Code Is 401 Unauthorized
    Assert Response Status Object With 4012 Unauthorized    ${resp}

TC-03-002
    [Documentation]    GET employee list fail,
    ...    In case of:
    ...    - session token expired
    ${resp}    Get Employee List Fail    ${admin_session_token_exp}
    Assert Http Status Code Is 401 Unauthorized
    Assert Response Status Object With 4012 Unauthorized    ${resp}

TC-03-003
    [Documentation]    GET employee list fail,
    ...    In case of:
    ...    - session token is an empty
    ${resp}    Get Employee List Fail     ${EMPTY}
    Assert Http Status Code Is 401 Unauthorized
    Assert Response Status Object With 4011 Unauthorized    ${resp}

TC-03-004
    [Documentation]    GET employee list fail,
    ...    In case of:
    ...    - session token (bearer) is not send
    ${resp}    Get Employee List But Bearer Is Not Send    ${admin_session_token}
    Assert Http Status Code Is 401 Unauthorized
    Assert Response Status Object With 4011 Unauthorized    ${resp}

TC-03-005
    [Documentation]    GET employee list fail,
    ...    In case of:
    ...    - session token is not send
    ${resp}    Get Employee List But Token Is Not Send    
    Assert Http Status Code Is 401 Unauthorized
    Assert Response Status Object With 4011 Unauthorized    ${resp}

TC-04-001
    [Documentation]    GET employee list fail,
    ...    In case of:
    ...    - invalid path
    ${resp}    Get Employee List But Send Invalid Path    ${admin_session_token}
    Assert Http Status Code Is 404 Not Found

TC-04-002
    [Documentation]    GET employee list fail,
    ...    In case of:
    ...    - invalid method
    ${resp}    Get Employee List But Send Invalid Method   ${admin_session_token}
    Assert Http Status Code Is 404 Not Found



