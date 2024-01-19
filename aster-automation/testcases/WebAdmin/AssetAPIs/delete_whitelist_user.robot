*** Settings ***
Resource    ${CURDIR}/../../../resources/imports.robot
Resource    ${CURDIR}/../../../keywords/common/common_keywords.robot
Resource    ${CURDIR}/../../../keywords/api/asset_apis.robot


*** Test Cases ***

TC-01-001
    [Documentation]    DELETE whitelist user  by whitelist_id success
    ...    In case of:
    ...    - vaild whitelist_id

    ${resp}    Post Submit Upload Whitelist    ${admin_session_token}    493    630176    employee_id    0
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}
    ${resp}    Delete Whitelist User    ${admin_session_token}    493
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}
    ${count_query}    Verify Delete Whitelist User DB
    Should Be Equal As Integers    ${count_query}     1



TC-01-002
    [Documentation]   DELETE whitelist user  by whitelist_id  fail
    ...    In case of:
    ...    - whitelist_id  have been deleted before

    ${resp}    Post Submit Upload Whitelist    ${admin_session_token}    493    630176    employee_id    0
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}
    ${resp}    Delete Whitelist User    ${admin_session_token}    493
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}
    ${count_query}    Verify Delete Whitelist User DB
    Should Be Equal As Integers    ${count_query}     1
    ${resp}   Delete Whitelist User Invalid    ${admin_session_token}    493
    Assert Http Status Code Is 400 Bad Request
    Assert Response Status Object With 4002 Invalid Parameter Request    ${resp}
    Should Be Equal As Strings    ${resp['error']}     session already deleted



TC-01-003
    [Documentation]   DELETE whitelist user  by whitelist_id fail
    ...    In case of:
    ...    - whitelist_id is wrong format/type

    ${resp}   Delete Whitelist User Invalid    ${admin_session_token}    493    abc
    Assert Http Status Code Is 400 Bad Request
    Assert Response Status Object With 4002 Invalid Parameter Request    ${resp}
    Should Be Equal As Strings    ${resp['error']}     strconv.ParseInt: parsing \"abc\": invalid syntax



TC-01-004
    [Documentation]   DELETE whitelist user  by whitelist_id fail
    ...    In case of:
    ...    - whitelist_id is not found or not existing
    ...    - valid session token
    ...    //ไม่มี whitelist_id นี้

    ${resp}   Delete Whitelist User Invalid    ${admin_session_token}    493    001
    Assert Http Status Code Is 404 Not Found
    Assert Response Status Object With 4040 Invalid Parameter Request    ${resp}
    Should Be Equal As Strings    ${resp['error']}     whitelist not found


TC-01-005
    [Documentation]   DELETE whitelist user  by whitelist_id fail
    ...    In case of:
    ...    - whitelist_id is not send

    ${resp}    Delete Whitelist User 404 page not found    ${admin_session_token}    493     ${EMPTY}
    Assert Http Status Code Is 404 Not Found


TC-02-001
    [Documentation]    DELETE whitelist user  by whitelist_id success
    ...    In case of:
    ...    - vaild assets_id

    ${resp}    Post Submit Upload Whitelist    ${admin_session_token}    493    630176    employee_id    0
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}
    ${resp}    Delete Whitelist User    ${admin_session_token}    493
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}
    ${count_query}    Verify Delete Whitelist User DB
    Should Be Equal As Integers    ${count_query}     1


TC-02-002
    [Documentation]   DELETE whitelist user  by whitelist_id  fail
    ...    In case of:
    ...    - assets_id  have been deleted before

    ${resp}    Post Submit Upload Whitelist    ${admin_session_token}    493    630176    employee_id    0
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}
    ${resp}    Delete Whitelist User    ${admin_session_token}    493
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}
    ${count_query}    Verify Delete Whitelist User DB
    Should Be Equal As Integers    ${count_query}     1
    ${resp}   Delete Whitelist User Invalid    ${admin_session_token}    493
    Assert Http Status Code Is 400 Bad Request
    Assert Response Status Object With 4002 Invalid Parameter Request    ${resp}
    Should Be Equal As Strings    ${resp['error']}     session already deleted



TC-02-003
    [Documentation]   DELETE whitelist user  by whitelist_id fail
    ...    In case of:
    ...    - assets_id is wrong format/type

    ${resp}   Delete Whitelist User Invalid    ${admin_session_token}    abc    556
    Assert Http Status Code Is 400 Bad Request
    Assert Response Status Object With 4002 Invalid Parameter Request    ${resp}
    Should Be Equal As Strings    ${resp['error']}     strconv.ParseInt: parsing \"abc\": invalid syntax



TC-02-004
    [Documentation]   DELETE whitelist user  by whitelist_id fail
    ...    In case of:
    ...    - assets_id is not found or not existing

    ${resp}   Delete Whitelist User Invalid    ${admin_session_token}    001    556
    Assert Http Status Code Is 404 Not Found
    Assert Response Status Object With 4040 Invalid Parameter Request    ${resp}
    Should Be Equal As Strings    ${resp['error']}     whitelist not found


TC-02-005
    [Documentation]   DELETE whitelist user  by whitelist_id fail
    ...    In case of:
    ...    - assets_id is not send

    ${resp}   Delete Whitelist User Invalid    ${admin_session_token}    ${EMPTY}    556
    Assert Http Status Code Is 400 Bad Request
    Assert Response Status Object With 4002 Invalid Parameter Request    ${resp}
    Should Be Equal As Strings    ${resp['error']}     Key: 'DeleteWhitelistRequest.AssetId' Error:Field validation for 'AssetId' failed on the 'required' tag


TC-03-001
    [Documentation]    DELETE whitelist user  by whitelist_id success
    ...    In case of:
    ...    - valid session token

    ${resp}    Post Submit Upload Whitelist    ${admin_session_token}    493    630176    employee_id    0
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}
    ${resp}    Delete Whitelist User    ${admin_session_token}    493
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}
    ${count_query}    Verify Delete Whitelist User DB
    Should Be Equal As Integers    ${count_query}     1


TC-03-002
    [Documentation]   DELETE whitelist user  by whitelist_id  fail
    ...    In case of:
    ...    - invalid session token

    ${resp}   Delete Whitelist User Invalid    ${admin_session_token}2222    493    556
    Assert Http Status Code Is 401 Unauthorized
    Assert Response Status Object With 4012 Unauthorized    ${resp}
    Should Be Equal As Strings    ${resp['error']}     signature is invalid



TC-03-003
    [Documentation]   DELETE whitelist user  by whitelist_id  fail
    ...    In case of:
    ...    - session token is an empty

    ${resp}   Delete Whitelist User Invalid    ${EMPTY}    493    556
    Assert Http Status Code Is 401 Unauthorized
    Assert Response Status Object With 4011 Unauthorized    ${resp}
    Should Be Equal As Strings    ${resp['error']}     Unable to parse token. Token might be empty string or null


TC-03-004
    [Documentation]   DELETE whitelist user  by whitelist_id  fai
    ...    In case of:
    ...    - session token expired

    ${resp}   Delete Whitelist User Invalid    ${admin_session_token_exp}    493    556
    Assert Http Status Code Is 401 Unauthorized
    Assert Response Status Object With 4012 Unauthorized     ${resp}
    Should Contain    ${resp['error']}     token is expired by



TC-03-005
    [Documentation]   DELETE whitelist user  by whitelist_id  fail
    ...    In case of:
    ...    - token doesn't have permission to do this action.

    ${resp}   Delete Whitelist User Invalid    ${user_management_session_token}    493    556
    Assert Http Status Code Is 403 Dont Have Permission
    Assert Response Status Object With 4030 User Doesn't Have Permission     ${resp}
    Should Contain    ${resp['error']}     User doesn't have permission to do this action.


TC-03-006
    [Documentation]   DELETE whitelist user  by whitelist_id  fail
    ...    In case of:
    ...    - token doesn't have permission to do this action.

    ${resp}   Delete Whitelist User Invalid    *REMOVE*    493    556
    Assert Http Status Code Is 401 Unauthorized
    Assert Response Status Object With 4011 Unauthorized     ${resp}
    Should Contain    ${resp['error']}     Unable to parse token. Token might be empty string or null



TC-04-001
    [Documentation]   DELETE whitelist user  by whitelist_id fail
    ...    In case of:
    ...    -invalid path

    ${resp}    Delete Whitelist User 404 page not found    ${admin_session_token}    493     556/user
    Assert Http Status Code Is 404 Not Found


TC-04-002
    [Documentation]   DELETE whitelist user  by whitelist_id fail
    ...    In case of:
    ...    -invalid method

    ${resp}    Delete Whitelist User Invalid Method     ${admin_session_token}    493     556
    Assert Http Status Code Is 404 Not Found