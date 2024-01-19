*** Settings ***
Resource    ${CURDIR}/../../../resources/imports.robot
Resource    ${CURDIR}/../../../keywords/common/common_keywords.robot
Resource    ${CURDIR}/../../../keywords/api/event_apis.robot

*** Test Cases ***
TC-01-001
    [Documentation]    GET all event group success,
    ...    In case of:
    ...    - valid session token
    ${query_events}    query_events
    ${count_query}    Get Length    ${query_events}

    ${resp}    Get All Event Success    ${admin_session_token}
    Assert Http Status Code Is 200 Ok   
    Assert Response Status Object With 2000 Success    ${resp}

    ${count_resp}    Get Length     ${resp['data']}
    Should Be Equal    ${count_query}    ${count_resp}
    Validate All Of Field Name Is Correctly  ${resp['data']}  ${count_resp}


TC-02-001
    [Documentation]    Get all event fail,
    ...    In case of:
    ...    - invalid session token 
    ${resp}    Get all event fail    ${admin_session_token}123
    Assert Http Status Code Is 401 Unauthorized
    Assert Response Status Object With 4012 Unauthorized    ${resp}

TC-02-002
    [Documentation]    Get all event fail,
    ...    In case of:
    ...    - session token expired
    ${resp}    Get All Event Fail    ${admin_session_token_exp}
    Assert Http Status Code Is 401 Unauthorized
    Assert Response Status Object With 4012 Unauthorized    ${resp}

TC-02-003
    [Documentation]    Get all event fail,
    ...    In case of:
    ...    - session token is an empty
    ${resp}    Get All Event Fail    ${EMPTY}
    Assert Http Status Code Is 401 Unauthorized
    Assert Response Status Object With 4011 Unauthorized    ${resp}

TC-02-004
    [Documentation]    Get all event fail,
    ...    In case of:
    ...    - session token (bearer) is not send
    ${resp}    Get Event But Bearer Is Not Send    ${admin_session_token}
    Assert Http Status Code Is 401 Unauthorized
    Assert Response Status Object With 4011 Unauthorized    ${resp}

TC-02-005
    [Documentation]    Get all event fail,
    ...    In case of:
    ...    - session token is not send
    ${resp}    Get Event But Token Is Not Send
    Assert Http Status Code Is 401 Unauthorized
    Assert Response Status Object With 4011 Unauthorized    ${resp}

TC-03-001
    [Documentation]    Get all event fail,
    ...    In case of:
    ...    - invalid path
    ${resp}    Get Event But Send Invalid Path    ${admin_session_token}
    Assert Http Status Code Is 404 Not Found

TC-03-002
    [Documentation]    Get all event fail,
    ...    In case of:
    ...    - invalid method
    ${resp}    Get Event But Send Invalid Method    ${admin_session_token}
    Assert Http Status Code Is 404 Not Found