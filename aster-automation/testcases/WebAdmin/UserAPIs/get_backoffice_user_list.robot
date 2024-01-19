*** Settings ***
Resource    ${CURDIR}/../../../resources/imports.robot
Resource    ${CURDIR}/../../../keywords/common/common_keywords.robot
Resource    ${CURDIR}/../../../keywords/api/user_apis.robot

*** Test Cases ***

TC-01-001
    [Documentation]    Should get backoffice user lists success,
    ...    In case of:
    ...    - have all role
    ${query_backoffice_user}    Query Backoffice User
    ${count_query}    Get Length    ${query_backoffice_user}
    ${resp}    Call API GET Backoffice User    ${user_management_session_token}
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}
    ${count_resp}    Get Length     ${resp['data']}
    Should Be Equal    ${count_query}    ${count_resp}

TC-01-002
    [Documentation]    Should get backoffice user lists success,
    ...    In case of:
    ...    - have some role
    ${query_backoffice_user}    Query Backoffice User
    ${count_query}    Get Length    ${query_backoffice_user}
    ${resp}    Call API GET Backoffice User    ${user_management_session_token}
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}
    ${count_resp}    Get Length     ${resp['data']}
    Should Be Equal    ${count_query}    ${count_resp}

TC-01-003
    [Documentation]    Should get backoffice user lists success,
    ...    In case of:
    ...    - have "ADMIN" role
    ${resp}    Call API GET Backoffice User    ${user_management_session_token}
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}
    
    ${role}    Set Variable    ADMIN
    FOR    ${item}    IN    @{resp['data']}
        ${item_role}    Set Variable    ${item['role']}
        Log    Item role --- ${item_role}
        ${result}    Run Keyword If  '${item_role}' == '${role}'    Set Variable    ${True}
        Exit For Loop If    '${result}' == '${True}'
    END
    Should Be True    ${result}

TC-01-004
    [Documentation]    Should get backoffice user lists success,
    ...    In case of:
    ...    - have "AIRDROP MANAGER" role
    ${resp}    Call API GET Backoffice User    ${user_management_session_token}
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}
    
    ${role}    Set Variable    AIRDROP MANAGER
    FOR    ${item}    IN    @{resp['data']}
        ${item_role}    Set Variable    ${item['role']}
        Log    Item role --- ${item_role}
        ${result}    Run Keyword If  '${item_role}' == '${role}'    Set Variable    ${True}
        Exit For Loop If    '${result}' == '${True}'
    END
    Should Be True    ${result}

TC-01-005
    [Documentation]    Should get backoffice user lists success,
    ...    In case of:
    ...    - have "BANNER MANAGER" role
    ${resp}    Call API GET Backoffice User    ${user_management_session_token}
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}
    
    ${role}    Set Variable    BANNER MANAGER
    FOR    ${item}    IN    @{resp['data']}
        ${item_role}    Set Variable    ${item['role']}
        Log    Item role --- ${item_role}
        ${result}    Run Keyword If  '${item_role}' == '${role}'    Set Variable    ${True}
        Exit For Loop If    '${result}' == '${True}'
    END
    Should Be True    ${result}

TC-01-006
    [Documentation]    Should get backoffice user lists success,
    ...    In case of:
    ...    - have "REWARD MANAGER" role
    ${resp}    Call API GET Backoffice User    ${user_management_session_token}
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}
    
    ${role}    Set Variable    REWARD MANAGER
    FOR    ${item}    IN    @{resp['data']}
        ${item_role}    Set Variable    ${item['role']}
        Log    Item role --- ${item_role}
        ${result}    Run Keyword If  '${item_role}' == '${role}'    Set Variable    ${True}
        Exit For Loop If    '${result}' == '${True}'
    END
    Should Be True    ${result}

TC-01-007
    [Documentation]    Should get backoffice user lists success,
    ...    In case of:
    ...    - have "SESSION MANAGER" role
    ${resp}    Call API GET Backoffice User    ${user_management_session_token}
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}
    
    ${role}    Set Variable    SESSION MANAGER
    FOR    ${item}    IN    @{resp['data']}
        ${item_role}    Set Variable    ${item['role']}
        Log    Item role --- ${item_role}
        ${result}    Run Keyword If  '${item_role}' == '${role}'    Set Variable    ${True}
        Exit For Loop If    '${result}' == '${True}'
    END
    Should Be True    ${result}

TC-01-008
    [Documentation]    Should get backoffice user lists success,
    ...    In case of:
    ...    - have "USER MANAGER" role
    ${resp}    Call API GET Backoffice User    ${user_management_session_token}
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}
    
    ${role}    Set Variable    USER MANAGER
    FOR    ${item}    IN    @{resp['data']}
        ${item_role}    Set Variable    ${item['role']}
        Log    Item role --- ${item_role}
        ${result}    Run Keyword If  '${item_role}' == '${role}'    Set Variable    ${True}
        Exit For Loop If    '${result}' == '${True}'
    END
    Should Be True    ${result}

TC-02-001
    [Documentation]    Should get backoffice user lists failed,
    ...    In case of:
    ...    - user don't have permission
    ${resp}    Call API GET Backoffice User    ${admin_session_token}
    Assert Http Status Code Is 403 Dont Have Permission
    Assert Response Status Object With 4030 User Doesn't Have Permission    ${resp}

TC-03-001
    [Documentation]    Should get backoffice user lists failed,
    ...    In case of:
    ...    - valid token
    ...    - invalid path
    ${resp}    Call API GET Backoffice User Invalid Path    ${user_management_session_token}
    Assert Http Status Code Is 404 Not Found
    Log    ${resp}

TC-03-002
    [Documentation]    Should get backoffice user lists failed,
    ...    In case of:
    ...    - invalid session token
    ${resp}    Call API GET Backoffice User    ${user_management_session_token}Dummy
    Assert Http Status Code Is 401 Unauthorized
    Assert Response Status Object With 4012 Unauthorized    ${resp}
    Log    ${resp}

TC-03-003
    [Documentation]    Should get backoffice user lists failed,
    ...    In case of:
    ...    - session token is expired
    ${resp}    Call API GET Backoffice User    ${user_management_session_token_exp}
    Assert Http Status Code Is 401 Unauthorized
    Assert Response Status Object With 4012 Unauthorized    ${resp}
    Log    ${resp}

TC-03-004
    [Documentation]    Should get backoffice user lists failed,
    ...    In case of:
    ...    - session token is empty
    ${resp}    Call API GET Backoffice User    ${EMPTY}
    Assert Http Status Code Is 401 Unauthorized
    Assert Response Status Object With 4011 Unauthorized    ${resp}
    Log    ${resp}