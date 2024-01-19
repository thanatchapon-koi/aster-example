
*** Settings ***
Resource    ${CURDIR}/../../../resources/imports.robot
Resource    ${CURDIR}/../../../keywords/common/common_keywords.robot
Resource    ${CURDIR}/../../../keywords/api/asset_apis.robot

*** Test Cases ***
TC-01-001
    [Documentation]    GET show all whitelist user success
    ...    In case of:
    ...    - valid session token
    ${query_whitelist}    query_whitelist    1
    ${count_query}    Get Length    ${query_whitelist}
    ${resp}    GET Show Whitelist User Success    ${admin_session_token}    1
    Assert Http Status Code Is 200 Ok   
    Assert Response Status Object With 2000 Success    ${resp}
    ${count_resp}    Get Length     ${resp['data']}
    Should Be Equal    ${count_query}    ${count_resp}

TC-01-002
    [Documentation]    GET show all whitelist user success
    ...    In case of:
    ...    - sort data correctly : createdAt sort data by old to new (ASC)

    ${query_whitelist}    query_whitelist    1   
    ${count_query}    Get Length    ${query_whitelist}
    ${resp}    GET Show Whitelist User Success    ${admin_session_token}    1
    Assert Http Status Code Is 200 Ok   
    Assert Response Status Object With 2000 Success    ${resp}
    ${count_resp}    Get Length     ${resp['data']}
    Should Be Equal    ${count_query}    ${count_resp}
    
TC-01-003
    [Documentation]    GET show whitelist user success
    ...    In case of:
    ...    - user can see status is "whitelist"
    ${resp}    GET Show Whitelist User Success    ${admin_session_token}    1   
    Assert Http Status Code Is 200 Ok   
    Assert Response Status Object With 2000 Success    ${resp}
    ${status}    Set Variable    whitelist
    FOR    ${item}    IN    @{resp['data']}
        ${item_status}    Set Variable    ${item['status']}
        Log    Item status --- ${item_status}
        ${result}    Run Keyword If  '${item_status}' == '${status}'    Set Variable    ${True}
        Exit For Loop If    '${result}' == '${True}'
    END
    Should Be True    ${result}

TC-01-004
    [Documentation]    GET show whitelist user success
    ...    In case of:
    ...    - user can see status is "error"
    ${resp}    GET Show Whitelist User Success    ${admin_session_token}    1   
    Assert Http Status Code Is 200 Ok   
    Assert Response Status Object With 2000 Success    ${resp}

    ${status}    Set Variable    error
    FOR    ${item}    IN    @{resp['data']}
        ${item_status}    Set Variable    ${item['status']}
        Log    Item status --- ${item_status}
        ${result}    Run Keyword If  '${item_status}' == '${status}'    Set Variable    ${True}
        Exit For Loop If    '${result}' == '${True}'
    END
    Should Be True    ${result}

TC-01-005
    [Documentation]    GET show whitelist user success
    ...    In case of:
    ...    - user can see status is "claimed"
    ${resp}    GET Show Whitelist User Success    ${admin_session_token}    1   
    Assert Http Status Code Is 200 Ok   
    Assert Response Status Object With 2000 Success    ${resp}
    
    ${status}    Set Variable    claimed
    FOR    ${item}    IN    @{resp['data']}
        ${item_status}    Set Variable    ${item['status']}
        Log    Item status --- ${item_status}
        ${result}    Run Keyword If  '${item_status}' == '${status}'    Set Variable    ${True}
        Exit For Loop If    '${result}' == '${True}'
    END
    Should Be True    ${result}

TC-02-001
    [Documentation]    GET show whitelist user success
    ...    In case of:
    ...    - user send asset id that is in the system
    ...    - Data found (ex.assetId = 1)
    ${query_whitelist}    query_whitelist    1  
    ${count_query}    Get Length    ${query_whitelist}
    ${resp}    GET Show Whitelist User Success    ${admin_session_token}    1   
    Assert Http Status Code Is 200 Ok   
    Assert Response Status Object With 2000 Success    ${resp}
    ${count_resp}    Get Length     ${resp['data']}
    Should Be Equal    ${count_query}    ${count_resp}

TC-02-002
    [Documentation]    GET show whitelist user success
    ...    In case of:
    ...    - asset id is not exsting (not found)
    ...    - Data found (ex.assetId = 999)
    ${resp}    GET Show Whitelist User Success    ${admin_session_token}    999  
    Assert Http Status Code Is 404 Not Found  
    Assert Response Status Object With 4040 Invalid Parameter Request    ${resp}
    
TC-02-003
    [Documentation]    GET show whitelist user success
    ...    In case of:    
    ...    - asset id is invalid type or format
    ...    - Data not found (ex.assetId = abc)
    ${resp}    GET Show Whitelist User Success    ${admin_session_token}    ABC  
    Assert Http Status Code Is 400 Bad Request  
    Assert Response Status Object With 4002 Invalid Parameter Request    ${resp}

TC-03-001
    [Documentation]    GET show whitelist user Failed
    ...    In case of:    
    ...    - user doesn't have permission
    ${resp}     GET Show Whitelist User Failed    ${user_management_session_token}    1  
    Assert Http Status Code Is 403 Dont Have Permission  
    Assert Response Status Object With 4030 User Doesn't Have Permission     ${resp}

TC-04-001
    [Documentation]    GET show whitelist user Failed
    ...    In case of:    
    ...    - invalid session token
    ${resp}     GET Show Whitelist User Failed    ${user_management_session_token}test    1  
    Assert Http Status Code Is 401 Unauthorized  
    Assert Response Status Object With 4012 Unauthorized     ${resp}

TC-04-002
    [Documentation]    GET show whitelist user Failed
    ...    In case of:    
    ...    - session token expired
    ${resp}     GET Show Whitelist User Failed    ${admin_session_token_exp}    1  
    Assert Http Status Code Is 401 Unauthorized  
    Assert Response Status Object With 4012 Unauthorized     ${resp}

TC-04-003
    [Documentation]    GET show whitelist user Failed
    ...    In case of:    
    ...    - session token is an empty
    ${resp}     GET Show Whitelist User Failed    ${EMPTY}    1  
    Assert Http Status Code Is 401 Unauthorized  
    Assert Response Status Object With 4011 Unauthorized     ${resp}

TC-04-004
    [Documentation]    GET show whitelist user Failed
    ...    In case of:    
    ...    - session token (bearer) is not send
    ${resp}     Get Event But Bearer Is Not Send    ${admin_session_token}    1  
    Assert Http Status Code Is 401 Unauthorized
    Assert Response Status Object With 4011 Unauthorized    ${resp}

TC-04-005
    [Documentation]    GET show whitelist user Failed
    ...    In case of:    
    ...    - session token is not send
    ${resp}     GET Show Whitelist User Failed    *REMOVE*    1  
    Assert Http Status Code Is 401 Unauthorized  
    Assert Response Status Object With 4011 Unauthorized     ${resp}

TC-05-001
    [Documentation]    GET show whitelist user Failed
    ...    In case of:
    ...    - invalid path
    ${resp}    Get Event But Send Invalid Path    ${admin_session_token}    1   test
    Assert Http Status Code Is 404 Not Found


TC-05-002
    [Documentation]    GGET show whitelist user Failed
    ...    In case of:
    ...    - invalid method
    ${resp}    Post Event But Send Invalid Method    ${admin_session_token}    1    
    Assert Http Status Code Is 404 Not Found

  