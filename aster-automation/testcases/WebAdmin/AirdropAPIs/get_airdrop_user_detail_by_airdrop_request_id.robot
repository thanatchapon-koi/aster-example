*** Settings ***
Resource    ${CURDIR}/../../../resources/imports.robot
Resource    ${CURDIR}/../../../keywords/common/common_keywords.robot
Resource    ${CURDIR}/../../../keywords/api/airdrop_apis.robot

*** Test Cases ***

TC-01-001
    [Documentation]    Should get airdrop user detail success,
    ...    In case of:
    ...    - valid session token
    ...    - valid airdrop_request_id
    ${query_airdrop_request_id}    Query Airdrop Reqeust Id
    ${airdrop_request_id}    Set Variable    ${query_airdrop_request_id[0]}[0]
    ${resp}    Call API Get All User Detail By Airdrop Request Id    ${admin_session_token}    ${airdrop_request_id}
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}
    Validate Response Fields Of API Get All User Detail By Airdrop Request Id    ${resp}
    Validate Type Of API Get All User Detail By Airdrop Request Id    ${resp}

TC-02-001
    [Documentation]    Should get airdrop user detail error,
    ...    In case of:
    ...    - invalid session token
    ${query_airdrop_request_id}    Query Airdrop Reqeust Id
    ${airdrop_request_id}    Set Variable    ${query_airdrop_request_id[0]}[0]
    ${resp}    Call API Get All User Detail By Airdrop Request Id    "DummyToken"    ${airdrop_request_id}
    Assert Http Status Code Is 401 Unauthorized
    Assert Response Status Object With 4012 Unauthorized    ${resp}
    Log    ${resp}

TC-02-002
    [Documentation]    Should get airdrop user detail error,
    ...    In case of:
    ...    - session token expired
    ${query_airdrop_request_id}    Query Airdrop Reqeust Id
    ${airdrop_request_id}    Set Variable    ${query_airdrop_request_id[0]}[0]
    ${resp}    Call API Get All User Detail By Airdrop Request Id    ${admin_session_token_exp}    ${airdrop_request_id}
    Assert Http Status Code Is 401 Unauthorized
    Assert Response Status Object With 4012 Unauthorized    ${resp}
    Log    ${resp}

TC-02-003
    [Documentation]    Should get airdrop user detail error,
    ...    In case of:
    ...    - session token is an empty
    ${query_airdrop_request_id}    Query Airdrop Reqeust Id
    ${airdrop_request_id}    Set Variable    ${query_airdrop_request_id[0]}[0]
    ${resp}    Call API Get All User Detail By Airdrop Request Id    ""    ${airdrop_request_id}
    Assert Http Status Code Is 401 Unauthorized
    Assert Response Status Object With 4012 Unauthorized    ${resp}
    Log    ${resp}

TC-02-004
    [Documentation]    Should get airdrop user detail error,
    ...    In case of:
    ...    - session token (bearer) is not send
    ${query_airdrop_request_id}    Query Airdrop Reqeust Id
    ${airdrop_request_id}    Set Variable    ${query_airdrop_request_id[0]}[0]
    ${resp}    Call API Get All User Detail By Airdrop Request Id Without Bearer    ${admin_session_token}    ${airdrop_request_id}
    Assert Http Status Code Is 401 Unauthorized
    Assert Response Status Object With 4011 Unauthorized    ${resp}
    Log    ${resp}

TC-02-005    [Documentation]    Should get airdrop user detail error,
    ...    In case of:
    ...    - session token is not send
    ${resp}    Call API Get All User Detail By Airdrop Request Id    *REMOVE*    ${airdrop_request_id}
    Assert Http Status Code Is 401 Unauthorized
    Assert Response Status Object With 4011 Unauthorized    ${resp}
    Log    ${resp}

TC-03-001    [Documentation]    Should get airdrop user detail error,
    ...    In case of:
    ...    - invalid input parameter (not existing)
    ${resp}    Call API Get All User Detail By Airdrop Request Id    ${admin_session_token}    999999
    Assert Http Status Code Is 404 Not Found
    Assert Response Status Object With 4040 Invalid Parameter Request    ${resp}
    Log    ${resp}

TC-03-002    [Documentation]    Should get airdrop user detail error,
    ...    In case of:
    ...    - invalid input parameter (input empty (space bar) value)
    ${resp}    Call API Get All User Detail By Airdrop Request Id    ${admin_session_token}    ${airdrop_request_id}Dummy
    Assert Http Status Code Is 400 Bad Request
    Assert Response Status Object With 4001 Cannot Binding Json To Struct    ${resp}
    Log    ${resp}

TC-03-003    [Documentation]    Should get airdrop user detail error,
    ...    In case of:
    ...    - invalid type of input parameter (input string)
    ${resp}    Call API Get All User Detail By Airdrop Request Id    ${admin_session_token}    '${airdrop_request_id}'
    Assert Http Status Code Is 400 Bad Request
    Assert Response Status Object With 4001 Cannot Binding Json To Struct    ${resp}
    Log    ${resp}

TC-04-001    [Documentation]    Should get airdrop user detail error,
    ...    In case of:
    ...    - invalid path
    ${query_airdrop_request_id}    Query Airdrop Reqeust Id
    ${airdrop_request_id}    Set Variable    ${query_airdrop_request_id[0]}[0]
    ${resp}    Call API Get All User Detail By Airdrop Request Id With Invalid Path    ${admin_session_token}    '${airdrop_request_id}'
    Assert Http Status Code Is 404 Not Found
    Log    ${resp}

TC-04-002    [Documentation]    Should get airdrop user detail error,
    ...    In case of:
    ...    - invalid method
    ${query_airdrop_request_id}    Query Airdrop Reqeust Id
    ${airdrop_request_id}    Set Variable    ${query_airdrop_request_id[0]}[0]
    ${resp}    Call API Get All User Detail By Airdrop Request Id With Invalid Method    ${admin_session_token}    '${airdrop_request_id}'
    Assert Http Status Code Is 404 Not Found
    Log    ${resp}