*** Settings ***
Resource    ${CURDIR}/../../../resources/imports.robot
Resource    ${CURDIR}/../../../keywords/common/common_keywords.robot
Resource    ${CURDIR}/../../../keywords/api/user_apis.robot



*** Test Cases ***


TC-01-001
    [Documentation]   DELETE delete user success
    ...    In case of:
    ...    - delete other's role (Airdrop Manager)

    ${resp}     Create Admin User    ${user_management_session_token}    ${email_test_userapis}    5
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}
    sleep    3
    ${query_admin_user}    Query Admin User      ${email_test_userapis}
    Verify Add Admin User    ${fullname_test_userapis}    ${email_test_userapis}    5
    ${resp}    Delete Admin User     ${user_management_session_token}
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}


TC-01-002
    [Documentation]    DELETE delete user success
    ...    In case of:
    ...    - delete other's role (Banner Manager)

    ${resp}    Create Admin User    ${user_management_session_token}    ${email_test_userapis}    4
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}
    sleep    3
    ${query_admin_user}    Query Admin User      ${email_test_userapis}
    Verify Add Admin User    ${fullname_test_userapis}    ${email_test_userapis}    4
    ${resp}    Delete Admin User     ${user_management_session_token}
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}


TC-01-003
    [Documentation]    DELETE delete user success
    ...    In case of:
    ...    - delete other's role (Reward Manager)

    ${resp}    Create Admin User    ${user_management_session_token}    ${email_test_userapis}    2
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}
    sleep    3
    ${query_admin_user}    Query Admin User      ${email_test_userapis}
    Verify Add Admin User    ${fullname_test_userapis}    ${email_test_userapis}    2
    ${resp}    Delete Admin User     ${user_management_session_token}
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}


TC-01-004
    [Documentation]    DELETE delete user success
    ...    In case of:
    ...    - delete other's role (Session Manager)

    ${resp}    Create Admin User    ${user_management_session_token}    ${email_test_userapis}    3
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}
    sleep    3
    ${query_admin_user}    Query Admin User      ${email_test_userapis}
    Verify Add Admin User    ${fullname_test_userapis}    ${email_test_userapis}    3
    ${resp}    Delete Admin User     ${user_management_session_token}
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}


TC-01-005
    [Documentation]    DELETE delete user success
    ...    In case of:
    ...    - delete same role but delete other user (Admin)

    ${resp}    Create Admin User    ${user_management_session_token}    ${email_test_userapis}    1
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}
    sleep    3
    ${query_admin_user}    Query Admin User      ${email_test_userapis}
    Verify Add Admin User    ${fullname_test_userapis}    ${email_test_userapis}    1
    ${resp}    Delete Admin User     ${user_management_session_token}
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}


TC-01-006
    [Documentation]    DELETE delete user success
    ...    In case of:
    ...    - delete same role but delete other user (User manager)

    ${resp}    Create Admin User    ${user_management_session_token}    ${email_test_userapis}    6
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}
    sleep    3
    ${query_admin_user}    Query Admin User      ${email_test_userapis}
    Verify Add Admin User    ${fullname_test_userapis}    ${email_test_userapis}    6
    ${resp}    Delete Admin User     ${user_management_session_token}
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}


TC-02-001
    [Documentation]    DELETE delete user failed
    ...    In case of:
    ...    - user don't have permission

    ${resp}    Create Admin User    ${user_management_session_token}    ${email_test_userapis}    6
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}
    sleep    3
    ${query_admin_user}    Query Admin User      ${email_test_userapis}
    Verify Add Admin User    ${fullname_test_userapis}    ${email_test_userapis}    6
    ${resp}    Delete Admin User     ${admin_session_token}
    Assert Http Status Code Is 403 Dont Have Permission
    Assert Response Status Object With 4030 User Doesn't Have Permission     ${resp}
    Should Be Equal As Strings    ${resp['error']}    no permission
    ${resp}    Delete Admin User     ${user_management_session_token}
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}


TC-02-002
    [Documentation]    DELETE delete user failed
    ...    In case of:
    ...    - delete themself
    
    ${resp}    Delete Admin User     ${admin_session_token}    aster.internal1@gmail.com
    Assert Http Status Code Is 403 Dont Have Permission
    Assert Response Status Object With 4030 User Doesn't Have Permission     ${resp}
    Should Be Equal As Strings    ${resp['error']}    no permission

TC-03-001
    [Documentation]    DELETE delete user failed
    ...    In case of:
    ...    - invalid session token

    ${resp}    Create Admin User    ${user_management_session_token}    ${email_test_userapis}    1
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}
    sleep    3
    ${query_admin_user}    Query Admin User      ${email_test_userapis}
    Verify Add Admin User    ${fullname_test_userapis}    ${email_test_userapis}    1
    ${resp}    Delete Admin User     ${admin_session_token}33333
    Assert Http Status Code Is 401 Unauthorized
    Assert Response Status Object With 4012 Unauthorized     ${resp}
    Should Be Equal As Strings    ${resp['error']}    signature is invalid
    ${resp}    Delete Admin User     ${user_management_session_token}
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}



TC-03-002
    [Documentation]    DELETE delete user failed
    ...    In case of:
    ...    - session token expired

    ${resp}    Create Admin User    ${user_management_session_token}    ${email_test_userapis}    1
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}
    sleep    3
    ${query_admin_user}    Query Admin User      ${email_test_userapis}
    Verify Add Admin User    ${fullname_test_userapis}    ${email_test_userapis}    1
    ${resp}    Delete Admin User     ${user_management_session_token_exp}
    Assert Http Status Code Is 401 Unauthorized
    Assert Response Status Object With 4012 Unauthorized     ${resp}
    Should Contain    ${resp['error']}    token is expired by
    ${resp}    Delete Admin User     ${user_management_session_token}
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}


TC-03-003
    [Documentation]     DELETE delete user failed
    ...    In case of:
    ...    - session token is an empty

    ${resp}    Create Admin User    ${user_management_session_token}    ${email_test_userapis}    1
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}
    sleep    3
    ${query_admin_user}    Query Admin User      ${email_test_userapis}
    Verify Add Admin User    ${fullname_test_userapis}    ${email_test_userapis}    1
    ${resp}    Delete Admin User     ${EMPTY}
    Assert Http Status Code Is 401 Unauthorized
    Assert Response Status Object With 4011 Unauthorized     ${resp}
    Should Be Equal As Strings    ${resp['error']}    Unable to parse token. Token might be empty string or null
    ${resp}    Delete Admin User     ${user_management_session_token}
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}


TC-03-004
    [Documentation]    DELETE delete user failed
    ...    In case of:
    ...    - session token is not send

    ${resp}    Create Admin User    ${user_management_session_token}    ${email_test_userapis}    1
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}
    sleep    3
    ${query_admin_user}    Query Admin User      ${email_test_userapis}
    Verify Add Admin User    ${fullname_test_userapis}    ${email_test_userapis}    1
    ${resp}    Delete Admin User     *REMOVE*
    Assert Http Status Code Is 401 Unauthorized
    Assert Response Status Object With 4011 Unauthorized     ${resp}
    Should Be Equal As Strings    ${resp['error']}    Unable to parse token. Token might be empty string or null
    ${resp}    Delete Admin User     ${user_management_session_token}
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}


TC-04-001
    [Documentation]    DELETE delete user failed
    ...    In case of:
    ...    - invalid userId (roleId not found)

    ${resp}    Create Admin User    ${user_management_session_token}    ${email_test_userapis}    1
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}
    sleep    3
    ${query_admin_user}    Query Admin User      ${email_test_userapis}
    Verify Add Admin User    ${fullname_test_userapis}    ${email_test_userapis}    1
    ${resp}    Delete Admin User Case Invalid     ${user_management_session_token}    11111111
    Assert Http Status Code Is 404 Not Found
    Assert Response Status Object With 4040 Invalid Parameter Request    ${resp}
    Should Be Equal As Strings    ${resp['error']}    user not found
    ${resp}    Delete Admin User     ${user_management_session_token}
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}


TC-04-002
    [Documentation]     DELETE delete user failed
    ...    In case of:
    ...    - invalid userId (input string)

    ${resp}    Create Admin User    ${user_management_session_token}    ${email_test_userapis}    1
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}
    sleep    3
    ${query_admin_user}    Query Admin User      ${email_test_userapis}
    Verify Add Admin User    ${fullname_test_userapis}    ${email_test_userapis}    1
    ${user_id}    Convert To Integer    11111111
    ${resp}    Delete Admin User Case Invalid     ${user_management_session_token}    ${user_id}
    Assert Http Status Code Is 400 Bad Request
    Assert Response Status Object With 4001 Cannot Binding Json To Struct    ${resp}
    Should Be Equal As Strings    ${resp['error']}    json: cannot unmarshal number into Go struct field DeleteUserRequest.userId of type string
    ${resp}    Delete Admin User     ${user_management_session_token}
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}



TC-04-003
    [Documentation]    DELETE delete user failed
    ...    In case of:
    ...    - userId is an empty (userId = "")

    ${resp}    Create Admin User    ${user_management_session_token}    ${email_test_userapis}    1
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}
    sleep    3
    ${query_admin_user}    Query Admin User      ${email_test_userapis}
    Verify Add Admin User    ${fullname_test_userapis}    ${email_test_userapis}    1
    ${resp}    Delete Admin User Case Invalid     ${user_management_session_token}    ${EMPTY}
    Assert Http Status Code Is 404 Not Found
    Assert Response Status Object With 4040 Invalid Parameter Request    ${resp}
    Should Be Equal As Strings    ${resp['error']}    user not found
    ${resp}    Delete Admin User     ${user_management_session_token}
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}



TC-04-004
    [Documentation]   DELETE delete user failed
    ...    In case of:
    ...    - userId is not send

    ${resp}    Create Admin User    ${user_management_session_token}    ${email_test_userapis}    1
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}
    sleep    3
    ${query_admin_user}    Query Admin User      ${email_test_userapis}
    Verify Add Admin User    ${fullname_test_userapis}    ${email_test_userapis}    1
    ${resp}    Delete Admin User Case Invalid     ${user_management_session_token}    *REMOVE*
    Assert Http Status Code Is 400 Bad Request
    Assert Response Status Object With 4002 Invalid Parameter Request    ${resp}
    Should Be Equal As Strings    ${resp['error']}    Invalid Parameters: 'UserId' must be REQUIRED field but the input is '<nil>'
    ${resp}    Delete Admin User     ${user_management_session_token}
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}


TC-04-005
    [Documentation]    DELETE delete user failed
     ...    In case of:
     ...    - userId is invalid type

    ${resp}    Create Admin User    ${user_management_session_token}    ${email_test_userapis}    1
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}
    sleep    3
    ${query_admin_user}    Query Admin User      ${email_test_userapis}
    Verify Add Admin User    ${fullname_test_userapis}    ${email_test_userapis}    1
    ${user_id}    Convert To Integer    11111111
    ${resp}    Delete Admin User Case Invalid     ${user_management_session_token}    ${user_id}
    Assert Http Status Code Is 400 Bad Request
    Assert Response Status Object With 4001 Cannot Binding Json To Struct    ${resp}
    Should Be Equal As Strings    ${resp['error']}    json: cannot unmarshal number into Go struct field DeleteUserRequest.userId of type string
    ${resp}    Delete Admin User     ${user_management_session_token}
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}


TC-04-006
    [Documentation]    DELETE delete user failed
    ...    In case of:
    ...    - invalid session token
    ...    - invalid userId (roleId not found)

    ${resp}    Create Admin User    ${user_management_session_token}    ${email_test_userapis}    1
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}
    sleep    3
    ${query_admin_user}    Query Admin User      ${email_test_userapis}
    Verify Add Admin User    ${fullname_test_userapis}    ${email_test_userapis}    1
    ${resp}    Delete Admin User Case Invalid     ${user_management_session_token}333333    abcdefg
    Assert Http Status Code Is 401 Unauthorized
    Assert Response Status Object With 4012 Unauthorized     ${resp}
    Should Be Equal As Strings    ${resp['error']}    illegal base64 data at input byte 48
    ${resp}    Delete Admin User     ${user_management_session_token}
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}


TC-04-007
    [Documentation]    DELETE delete user failed
    ...    In case of:
    ...    - user already deleted

    ${resp}    Create Admin User    ${user_management_session_token}    ${email_test_userapis}    5
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}
    sleep    3
    ${query_admin_user}    Query Admin User      ${email_test_userapis}
    Verify Add Admin User    ${fullname_test_userapis}    ${email_test_userapis}    5
    ${resp}    Delete Admin User     ${user_management_session_token}    
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}
    ${resp}    Delete Admin User Case Invalid     ${user_management_session_token}    ${query_admin_user[0][0]} 
    Assert Http Status Code Is 404 Not Found
    Assert Response Status Object With 4040 Invalid Parameter Request    ${resp}
    Should Be Equal As Strings    ${resp['error']}    user not found   


TC-05-001
    [Documentation]    DELETE delete user failed
    ...    In case of:
    ...    - invalid method

    ${rest}    Delete Admin User Invalid Method    ${user_management_session_token}    e7d25721-5717-4dd5-aab0-29a9290de205
    Assert Http Status Code Is 404 Not Found


TC-05-002
    [Documentation]    DELETE delete user failed
    ...    In case of:
    ...    - invalid path

    ${resp}    Delete Admin User Case Path     ${user_management_session_token}    e7d25721-5717-4dd5-aab0-29a9290de205
    Assert Http Status Code Is 404 Not Found







