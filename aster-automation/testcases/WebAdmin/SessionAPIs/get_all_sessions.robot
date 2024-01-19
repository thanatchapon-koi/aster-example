*** Settings ***
Resource    ${CURDIR}/../../../resources/imports.robot
Resource    ${CURDIR}/../../../keywords/common/common_keywords.robot
Resource    ${CURDIR}/../../../keywords/api/sessions_apis.robot

*** Test Cases ***
TC-01-001
    [Documentation]    Get All Sessions Success
    ...    In case of:
    ...    - show Session  all
    ${query_sessions}    Query Sessions
    ${count_query}    Get Length    ${query_sessions}
    ${resp}    Get All Sessions Success    ${admin_session_token}
    Assert Http Status Code Is 200 Ok   
    Assert Response Status Object With 2000 Success    ${resp}
    ${count_resp}    Get Length     ${resp['data']}
    Should Be Equal    ${count_query}    ${count_resp}

TC-01-002
    [Documentation]    Get All Sessions Success
    ...    In case of:
    ...    - user can see status : ONGOING
    ${query_sessions}    Query Sessions
    ${count_query}    Get Length    ${query_sessions}
    ${resp}    Get All Sessions Success    ${admin_session_token}
    Assert Http Status Code Is 200 Ok   
    Assert Response Status Object With 2000 Success    ${resp}
    ${status}    Set Variable    ONGOING
    FOR    ${item}    IN    @{resp['data']}
        ${item_status}    Set Variable    ${item['status']}
        Log    Item status --- ${item_status}
        ${result}    Run Keyword If  '${item_status}' == '${status}'    Set Variable    ${True}
        Exit For Loop If    '${result}' == '${True}'
    END
    Should Be True    ${result}

TC-01-003
    [Documentation]    Get All Sessions Success
    ...    In case of:
    ...    - user can see status : WAITING FOR AIRDROP
    ${query_sessions}    Query Sessions
    ${count_query}    Get Length    ${query_sessions}
    ${resp}    Get All Sessions Success    ${admin_session_token}
    Assert Http Status Code Is 200 Ok   
    Assert Response Status Object With 2000 Success    ${resp}
    ${status}    Set Variable    WAITING FOR AIRDROP
    FOR    ${item}    IN    @{resp['data']}
        ${item_status}    Set Variable    ${item['status']}
        Log    Item status --- ${item_status}
        ${result}    Run Keyword If  '${item_status}' == '${status}'    Set Variable    ${True}
        Exit For Loop If    '${result}' == '${True}'
    END
    Should Be True    ${result}

TC-01-004
    [Documentation]    Get All Sessions Success
    ...    In case of:
    ...    - user can see status : REJECTED
    ${query_sessions}    Query Sessions
    ${count_query}    Get Length    ${query_sessions}
    ${resp}    Get All Sessions Success    ${admin_session_token}
    Assert Http Status Code Is 200 Ok   
    Assert Response Status Object With 2000 Success    ${resp}
    ${status}    Set Variable    REJECTED
    FOR    ${item}    IN    @{resp['data']}
        ${item_status}    Set Variable    ${item['status']}
        Log    Item status --- ${item_status}
        ${result}    Run Keyword If  '${item_status}' == '${status}'    Set Variable    ${True}
        Exit For Loop If    '${result}' == '${True}'
    END
    Should Be True    ${result}

TC-01-005
    [Documentation]    Get All Sessions Success
    ...    In case of:
    ...    - user can see status : COMPLETED
    ${query_sessions}    Query Sessions
    ${count_query}    Get Length    ${query_sessions}
    ${resp}    Get All Sessions Success    ${admin_session_token}
    Assert Http Status Code Is 200 Ok   
    Assert Response Status Object With 2000 Success    ${resp}
    ${status}    Set Variable    COMPLETED
    FOR    ${item}    IN    @{resp['data']}
        ${item_status}    Set Variable    ${item['status']}
        Log    Item status --- ${item_status}
        ${result}    Run Keyword If  '${item_status}' == '${status}'    Set Variable    ${True}
        Exit For Loop If    '${result}' == '${True}'
    END
    Should Be True    ${result}

TC-01-006
    [Documentation]    Get All Sessions Success
    ...    In case of:
    ...    - user can see status : SESSION ENDED
    ${query_sessions}    Query Sessions
    ${count_query}    Get Length    ${query_sessions}
    ${resp}    Get All Sessions Success    ${admin_session_token}
    Assert Http Status Code Is 200 Ok   
    Assert Response Status Object With 2000 Success    ${resp}
    ${status}    Set Variable    SESSION ENDED
    FOR    ${item}    IN    @{resp['data']}
        ${item_status}    Set Variable    ${item['status']}
        Log    Item status --- ${item_status}
        ${result}    Run Keyword If  '${item_status}' == '${status}'    Set Variable    ${True}
        Exit For Loop If    '${result}' == '${True}'
    END
    Should Be True    ${result}

TC-01-007
    [Documentation]    Get All Sessions Success
    ...    In case of:
    ...    - user can see additionalQuestions : food
    ${query_sessions}    Query Sessions
    ${count_query}    Get Length    ${query_sessions}
    ${resp}    Get All Sessions Success    ${admin_session_token}
    Assert Http Status Code Is 200 Ok   
    Assert Response Status Object With 2000 Success    ${resp}
    ${additional}    Set Variable    food
    ${result}    Set Variable    ${False}
    FOR    ${item}    IN    @{resp['data']}
        ${item_additional}    Set Variable    ${item['additionalQuestions']}
        Log    Item additional --- ${item_additional}
        ${match_additional}    Run Keyword If    '${additional}' in ${item_additional}    Set Variable    ${True}
        ${result}    Run Keyword If    '${match_additional}' == 'True'    Set Variable    ${True}
        Exit For Loop If    '${result}' == 'True'
    END
    Should Be True    ${result}


    

TC-01-008
    [Documentation]    Get All Sessions Success
    ...    In case of:
    ...    - user can see additionalQuestions : address
    ${query_sessions}    Query Sessions
    ${count_query}    Get Length    ${query_sessions}
    ${resp}    Get All Sessions Success    ${admin_session_token}
    Assert Http Status Code Is 200 Ok   
    Assert Response Status Object With 2000 Success    ${resp}
    ${additional}    Set Variable    address
    ${result}    Set Variable    ${False}
    FOR    ${item}    IN    @{resp['data']}
        ${item_additional}    Set Variable    ${item['additionalQuestions']}
        Log    Item additional --- ${item_additional}
        ${match_additional}    Run Keyword If    '${additional}' in ${item_additional}    Set Variable    ${True}
        ${result}    Run Keyword If    '${match_additional}' == 'True'    Set Variable    ${True}
        Exit For Loop If    '${result}' == 'True'
    END
    Should Be True    ${result}

TC-01-009
    [Documentation]    Get All Sessions Success
    ...    In case of:
    ...    - user can see additionalQuestions : shirt
    ${query_sessions}    Query Sessions
    ${count_query}    Get Length    ${query_sessions}
    ${resp}    Get All Sessions Success    ${admin_session_token}
    Assert Http Status Code Is 200 Ok   
    Assert Response Status Object With 2000 Success    ${resp}
    ${additional}    Set Variable    shirt
    ${result}    Set Variable    ${False}
    FOR    ${item}    IN    @{resp['data']}
        ${item_additional}    Set Variable    ${item['additionalQuestions']}
        Log    Item additional --- ${item_additional}
        ${match_additional}    Run Keyword If    '${additional}' in ${item_additional}    Set Variable    ${True}
        ${result}    Run Keyword If    '${match_additional}' == 'True'    Set Variable    ${True}
        Exit For Loop If    '${result}' == 'True'
    END
    Should Be True    ${result}

TC-02-001
    [Documentation]    Get All Sessions Success
    ...    In case of:
    ...    - user don't have permission
    ${resp}    Get All Sessions fail permission    ${user_management_session_token}
    Assert Http Status Code Is 403 Dont Have Permission
    Assert Response Status Object With 4030 User Doesn't Have Permission     ${resp}


TC-03-001
    [Documentation]    Get all Sessions fail,
    ...    In case of:
    ...    - invalid session token 
    ${resp}    Get all Sessions fail    ${admin_session_token}123
    Assert Http Status Code Is 401 Unauthorized
    Assert Response Status Object With 4012 Unauthorized    ${resp}

TC-03-002
    [Documentation]    Get all Sessions fail,
    ...    In case of:
    ...    - session token expired
    ${resp}    Get All Sessions Fail    ${admin_session_token_exp}
    Assert Http Status Code Is 401 Unauthorized
    Assert Response Status Object With 4012 Unauthorized    ${resp}

TC-03-003
    [Documentation]    Get all Sessions fail,
    ...    In case of:
    ...    - session token is an empty
    ${resp}    Get All Sessions Fail    ${EMPTY}
    Assert Http Status Code Is 401 Unauthorized
    Assert Response Status Object With 4011 Unauthorized    ${resp}

TC-03-004
    [Documentation]    Get all Sessions fail,
    ...    In case of:
    ...    - session token (bearer) is not send
    ${resp}    Get Sessions But Bearer Is Not Send    ${admin_session_token}
    Assert Http Status Code Is 401 Unauthorized
    Assert Response Status Object With 4011 Unauthorized    ${resp}

TC-03-005
    [Documentation]    Get all Sessions fail,
    ...    In case of:
    ...    - session token is not send
    ${resp}    Get Sessions But Token Is Not Send
    Assert Http Status Code Is 401 Unauthorized
    Assert Response Status Object With 4011 Unauthorized    ${resp}

TC-04-001
    [Documentation]    Get all Sessions fail,
    ...    In case of:
    ...    - invalid path
    ${resp}    Get Sessions But Send Invalid Path    ${admin_session_token}
    Assert Http Status Code Is 404 Not Found

TC-04-002
    [Documentation]    Get all Sessions fail,
    ...    In case of:
    ...    - invalid method
    ${resp}    Put Sessions But Send Invalid Method    ${admin_session_token}
    Assert Http Status Code Is 404 Not Found