*** Settings ***
Resource    ${CURDIR}/../../../resources/imports.robot
Resource    ${CURDIR}/../../../keywords/common/common_keywords.robot
Resource    ${CURDIR}/../../../keywords/api/campaign_apis.robot


*** Test Cases ***

TC-01-001
    [Documentation]    GET all campaigns success
    ...    In case of:
    ...    - show data format correctly

    ${resp}    Call API GET Backoffice User    ${admin_session_token}       
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}
    Should Be Equal As Integers    ${resp['data'][0]['id']}   1
    Should Be Equal As Strings    ${resp['data'][0]['name']}   The Speaker 2023
    Should Be Equal As Integers    ${resp['data'][0]['event_id']}   1
    Should Be Equal As Integers    ${resp['data'][1]['id']}   2
    Should Be Equal As Strings    ${resp['data'][1]['name']}   E-Sport 2023
    Should Be Equal As Integers    ${resp['data'][1]['event_id']}   2


TC-02-001
    [Documentation]    GET all campaigns success
    ...    In case of:
    ...    - input valid "event_id"

    ${resp}    Call API GET Backoffice User By Path    ${admin_session_token}    ?event_id=2
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}
    Should Be Equal As Integers    ${resp['data'][0]['id']}   2
    Should Be Equal As Strings    ${resp['data'][0]['name']}   E-Sport 2023
    Should Be Equal As Integers    ${resp['data'][0]['event_id']}   2

TC-02-002
    [Documentation]    GET all campaigns success
    ...    In case of:
    ...    - input "event_id" value that not found

    ${resp}    Call API GET Backoffice User By Path    ${admin_session_token}    ?event_id=10
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}
    Should Be Empty    ${resp['data']}    @{EMPTY}


TC-02-003
    [Documentation]    GET all campaigns success
    ...    In case of:
    ...    - input valid "event_id" except value

    ${resp}    Call API GET Backoffice User By Path    ${admin_session_token}    ?event_id=
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}
    Should Be Empty    ${resp['data']}    @{EMPTY}


TC-02-004
    [Documentation]    GET all campaigns success
    ...    In case of:
    ...    - input invalid "event_id"  value (wrong type/ format)

    ${resp}    Call API GET Backoffice User By Path    ${admin_session_token}    ?event_id=A
    Assert Http Status Code Is 400 Bad Request
    Assert Response Status Object With 4001 Cannot Binding Json To Struct    ${resp}
    Should Be Equal As Strings    ${resp['error']}    strconv.ParseInt: parsing \"A\": invalid syntax


TC-03-001
    [Documentation]    GET all campaigns fail
    ...    In case of:
    ...    - invalid session token

    ${resp}    Call API GET Backoffice User    ${admin_session_token}33333
    Assert Http Status Code Is 401 Unauthorized
    Assert Response Status Object With 4012 Unauthorized    ${resp}
    Should Be Equal As Strings    ${resp['error']}    signature is invalid


TC-03-002
    [Documentation]    GET all campaigns fail
    ...    In case of:
    ...    - session token expired

    ${resp}    Call API GET Backoffice User    ${admin_session_token_exp}
    Assert Http Status Code Is 401 Unauthorized
    Assert Response Status Object With 4012 Unauthorized    ${resp}
    Should Contain    ${resp['error']}    token is expired by


TC-03-003
    [Documentation]    GET all campaigns fail
    ...    In case of:
    ...    - session token is an empty

    ${resp}    Call API GET Backoffice User    ${EMPTY}
    Assert Http Status Code Is 401 Unauthorized
    Assert Response Status Object With 4011 Unauthorized    ${resp}
    Should Be Equal As Strings    ${resp['error']}    Unable to parse token. Token might be empty string or null


TC-03-005
    [Documentation]   GET all campaigns fail
    ...    In case of:
    ...    - session token is not send 

    ${resp}    Call API GET Backoffice User    *REMOVE*
    Assert Http Status Code Is 401 Unauthorized
    Assert Response Status Object With 4011 Unauthorized    ${resp}
    Should Be Equal As Strings    ${resp['error']}    Unable to parse token. Token might be empty string or null

TC-04-001
    [Documentation]    GET all campaigns fail
    ...    In case of:
    ...    - invalid path

    ${resp}    Call API GET Backoffice User Invalid    ${admin_session_token}    /5555
    Assert Http Status Code Is 404 Not Found


TC-04-002
    [Documentation]    GET all campaigns fail
    ...    In case of:
    ...    - invalid method

    ${resp}    Call API GET Backoffice User Invalid Method    ${admin_session_token}
    Assert Http Status Code Is 404 Not Found





