*** Settings ***
Resource    ${CURDIR}/../../../resources/imports.robot
Resource    ${CURDIR}/../../../keywords/common/common_keywords.robot
Resource    ${CURDIR}/../../../keywords/api/participation_apis.robot

*** Variables ***
${session_id_have_participant}  425
${session_id_not_have_participant}  422
${session_id_not_found}  999

*** Test Cases ***
TC-01-001
    [Documentation]    GET user participant session id success,
    ...    In case of:
    ...    - user have permission
    ...    - have participation data (เรียงตามวันเวลาที่ลงทะเบียนครั้งล่าสุด)
    ...    - valid session_id
    ...    - valid session token
    ${get_participant}    Query Participant  ${session_id_have_participant}
    ${count_query}    Get Length    ${get_participant}

    ${resp}    Get Participant By Session Id Success    ${admin_session_token}  ${session_id_have_participant}
    Assert Http Status Code Is 200 Ok   
    Assert Response Status Object With 2000 Success    ${resp}

    ${count_resp}    Get Length     ${resp['data']}
    Should Be Equal    ${count_query}    ${count_resp}

    Validate All Of Field Name Is Correctly  ${resp['data']}  ${count_resp}

TC-01-002
    [Documentation]    GET user participant session id success,
    ...    In case of:
    ...    - user have permission
    ...    - not have participation data (เรียงตามวันเวลาที่ลงทะเบียนครั้งล่าสุด)
    ...    - valid session_id
    ...    - valid session token
    ${resp}    Get Participant By Session Id Success    ${admin_session_token}  ${session_id_not_have_participant}
    Assert Http Status Code Is 200 Ok   
    Assert Response Status Object With 2000 Success    ${resp}

    Validate Data Is Empty  ${resp['data']}

TC-02-001
    [Documentation]    GET user participant session id fail,
    ...    In case of:
    ...    - user don't have permission
    ...    - have participation data
    ...    - valid session token
    ...    - valid session_id
    ${resp}    Get Participant By Session Id Fail    ${user_management_session_token}  ${session_id_have_participant}
    Assert Http Status Code Is 403 Dont Have Permission
    Assert Response Status Object With 4030 User Doesn't Have Permission    ${resp}

TC-02-002
    [Documentation]    GET user participant session id fail,
    ...    In case of:
    ...    - user don't have permission
    ...    - not have participation data
    ...    - valid session token
    ...    - valid session_id
    ${resp}    Get Participant By Session Id Fail    ${user_management_session_token}  ${session_id_not_have_participant}
    Assert Http Status Code Is 403 Dont Have Permission
    Assert Response Status Object With 4030 User Doesn't Have Permission    ${resp}

TC-03-001
    [Documentation]    GET user participant session id fail,
    ...    In case of:
    ...    - invalid session token (add/delete some text)
    ...    - valid session_id
    ${resp}    Get Participant By Session Id Fail    ${user_management_session_token}1234  ${session_id_have_participant}
    Assert Http Status Code Is 401 Unauthorized
    Assert Response Status Object With 4012 Unauthorized    ${resp}

TC-03-002
    [Documentation]    GET user participant session id fail,
    ...    In case of:
    ...    - session token is an expired
    ...    - valid session_id
    ${resp}    Get Participant By Session Id Fail    ${admin_session_token_exp}  ${session_id_have_participant}
    Assert Http Status Code Is 401 Unauthorized
    Assert Response Status Object With 4012 Unauthorized    ${resp}

TC-03-003
    [Documentation]    GET user participant session id fail,
    ...    In case of:
    ...    - session token is an empty
    ...    - valid session_id
    ${resp}    Get Participant By Session Id Fail    ${EMPTY}  ${session_id_have_participant}
    Assert Http Status Code Is 401 Unauthorized
    Assert Response Status Object With 4011 Unauthorized    ${resp}

TC-03-004
    [Documentation]    GET user participant session id fail,
    ...    In case of:
    ...    - session token is not send
    ...    - valid session_id
    ${resp}    Get Participant By Session Id But Token Is Not Send    ${session_id_have_participant}
    Assert Http Status Code Is 401 Unauthorized
    Assert Response Status Object With 4011 Unauthorized    ${resp}

TC-04-001
    [Documentation]    GET user participant session id fail,
    ...    In case of:
    ...    - valid session token
    ...    - session_id not found
    ${resp}    Get Participant By Session Id Fail    ${admin_session_token}  ${session_id_not_found}
    Assert Http Status Code Is 404 Not Found
    Assert Response Status Object With 4040 Invalid Parameter Request    ${resp}

TC-04-002
    [Documentation]    GET user participant session id fail,
    ...    In case of:
    ...    - valid session token
    ...    - session_id is an empty
    ${resp}    Get Participant By Session Id Fail    ${admin_session_token}  ${EMPTY}
    Assert Http Status Code Is 400 Bad Request
    Assert Response Status Object With 4002 Invalid Parameter Request    ${resp}

TC-04-003
    [Documentation]    GET user participant session id fail,
    ...    In case of:
    ...    - valid session token
    ...    - session_id is not number (String)
    ${resp}    Get Participant By Session Id Fail    ${admin_session_token}  TEST
    Assert Http Status Code Is 400 Bad Request
    Assert Response Status Object With 4002 Invalid Parameter Request    ${resp}

TC-04-005
    [Documentation]    GET user participant session id fail,
    ...    In case of:
    ...    - not have participation data
    ...    - session_id is number (int)
    ${resp}    Get Participant By Session Id Success    ${admin_session_token}  ${session_id_not_have_participant}
    Assert Http Status Code Is 200 Ok   
    Assert Response Status Object With 2000 Success    ${resp}

    Validate Data Is Empty  ${resp['data']}

TC-05-001
    [Documentation]    GET user participant session id fail,
    ...    In case of:
    ...    - invalid method
    ${resp}    Get Participant By Session Id But Send Invalid Method   ${admin_session_token}  ${session_id_have_participant}
    Assert Http Status Code Is 404 Not Found

TC-05-002
    [Documentation]    GET user participant session id fail,
    ...    In case of:
    ...    - invalid path
    ${resp}    Get Participant By Session Id But Send Invalid Path    ${admin_session_token}  ${session_id_have_participant}
    Assert Http Status Code Is 404 Not Found


