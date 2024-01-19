*** Settings ***
Resource    ${CURDIR}/../../../resources/imports.robot
Resource    ${CURDIR}/../../../keywords/common/common_keywords.robot
Resource    ${CURDIR}/../../../keywords/api/airdrop_apis.robot

*** Test Cases ***
# create data before test this file

TC-01-001
    [Documentation]    Get all airdrop success
    ...    In case of:
    ...    - airdrop request status: PENDING (on DB)
    ...    - session status: WAITING FOR AIRDROP
    ${query_airdrop_list}    Query Airdrop Request Lists Where Status    PENDING
    ${resp}    GET All Airdrop Request APIs    ${admin_session_token}
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}
    Validate Name Of Fields In All Airdrop Request APIs Is Completely    ${resp}
    Validate Type Of Data In APIs    ${resp}
    Preapare Data In Database And APIs    ${query_airdrop_list}    ${resp}    WAITING FOR AIRDROP

TC-01-002
    [Documentation]    Get all airdrop success
    ...    In case of:
    ...    - airdrop request status: ONGOING (on DB)
    ...    - session status: WAITING FOR AIRDROP
    ${query_airdrop_list}    Query Airdrop Request Lists Where Status    ONGOING
    ${resp}    GET All Airdrop Request APIs    ${admin_session_token}
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}
    Validate Name Of Fields In All Airdrop Request APIs Is Completely    ${resp}
    Validate Type Of Data In APIs    ${resp}
    Preapare Data In Database And APIs    ${query_airdrop_list}    ${resp}    WAITING FOR AIRDROP

TC-01-003    [Documentation]    Get all airdrop success
    ...    In case of:
    ...    - airdrop request status: REJECTED (on DB)
    ...    - session status: REJECTED
    ${query_airdrop_list}    Query Airdrop Request Lists Where Status    REJECTED
    ${resp}    GET All Airdrop Request APIs    ${admin_session_token}
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}
    Validate Name Of Fields In All Airdrop Request APIs Is Completely    ${resp}
    Validate Type Of Data In APIs    ${resp}
    Preapare Data In Database And APIs    ${query_airdrop_list}    ${resp}    REJECTED

TC-01-004    [Documentation]    Get all airdrop success
    ...    In case of:
    ...    - airdrop request status: FAILED (on DB)
    ...    - session status: WAITING FOR AIRDROP
    ${query_airdrop_list}    Query Airdrop Request Lists Where Status    FAILED
    ${resp}    GET All Airdrop Request APIs    ${admin_session_token}
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}
    Validate Name Of Fields In All Airdrop Request APIs Is Completely    ${resp}
    Validate Type Of Data In APIs    ${resp}
    Preapare Data In Database And APIs    ${query_airdrop_list}    ${resp}    WAITING FOR AIRDROP

TC-01-005    [Documentation]    Get all airdrop success
    ...    In case of:
    ...    - airdrop request status: COMPLETED (on DB)
    ...    - session status: COMPLETED
    ${query_airdrop_list}    Query Airdrop Request Lists Where Status    COMPLETED
    ${resp}    GET All Airdrop Request APIs    ${admin_session_token}
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}
    Validate Name Of Fields In All Airdrop Request APIs Is Completely    ${resp}
    Validate Type Of Data In APIs    ${resp}
    Preapare Data In Database And APIs    ${query_airdrop_list}    ${resp}    COMPLETED

TC-02-001    [Documentation]    Get all airdrop fail
    ...    In case of:
    ...    - invalid session token
    ${resp}    GET All Airdrop Request APIs    ${admin_session_token}sdfsdf
    Assert Http Status Code Is 401 Unauthorized
    Assert Response Status Object With 4012 Unauthorized    ${resp}

TC-02-002    [Documentation]    Get all airdrop fail
    ...    In case of:
    ...    - session token expired
    ${resp}    GET All Airdrop Request APIs    ${admin_session_token_exp}
    Assert Http Status Code Is 401 Unauthorized
    Assert Response Status Object With 4012 Unauthorized    ${resp}

TC-02-003    [Documentation]    Get all airdrop fail
    ...    In case of:
    ...    - session token is an empty
    ${resp}    GET All Airdrop Request APIs    ${EMPTY}
    Assert Http Status Code Is 401 Unauthorized
    Assert Response Status Object With 4011 Unauthorized    ${resp}

TC-02-004    [Documentation]    Get all airdrop fail
    ...    In case of:
    ...    - session token (bearer) is not send
    ${resp}    GET All Airdrop Request APIs Without Bearer    ${admin_session_token}
    Assert Http Status Code Is 401 Unauthorized
    Assert Response Status Object With 4011 Unauthorized    ${resp}

TC-02-005    [Documentation]    Get all airdrop fail
    ...    In case of:
    ...     - session token is not send
    ${resp}    GET All Airdrop Request APIs    *REMOVE*
    Assert Http Status Code Is 401 Unauthorized
    Assert Response Status Object With 4011 Unauthorized    ${resp}

TC-03-001    [Documentation]    Get all airdrop fail
    ...    In case of:
    ...    - invalid method
    ${resp}    GET All Airdrop Request APIs Invalid Method    ${admin_session_token}
    Assert Http Status Code Is 404 Not Found

TC-03-002    [Documentation]    Get all airdrop fail
    ...    In case of:
    ...    - invalid path
    ${resp}    GET All Airdrop Request APIs Invalid Path    ${admin_session_token}
    Assert Http Status Code Is 404 Not Found