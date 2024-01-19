*** Settings ***
Resource    ${CURDIR}/../../../resources/imports.robot
Resource    ${CURDIR}/../../../keywords/common/common_keywords.robot
Resource    ${CURDIR}/../../../keywords/api/user_apis.robot

*** Test Cases ***


TC-01-001
    [Documentation]    POST create new user with role success - USER MANAGER
                    #    In case of:
                    #    - USER MANAGER
                    #    - roleId = 6
    ${resp}    Create Admin User    ${user_management_session_token}    ${email_test_userapis}    6
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}
    sleep    5
    ${query_admin_user}    Query Admin User      ${email_test_userapis}
    Verify Add Admin User    ${fullname_test_userapis}    ${email_test_userapis}    6
    ${resp}    Delete Admin User     ${user_management_session_token}
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}


TC-01-002
    [Documentation]    POST create new user with role success  - AIRDROP MANAGER
                #      In case of:
                #      - AIRDROP MANAGER
                #      - roleId = 5
    ${resp}    Create Admin User    ${user_management_session_token}    ${email_test_userapis}    5
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}
    sleep    5
    ${query_admin_user}    Query Admin User      ${email_test_userapis}
    Verify Add Admin User    ${fullname_test_userapis}    ${email_test_userapis}    5
    ${resp}    Delete Admin User     ${user_management_session_token}
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}


TC-01-003
    [Documentation]    POST create new user with role success - BANNER MANAGER
                #      In case of:
                #      - BANNER MANAGER
                #      - roleId = 4
    ${resp}    Create Admin User    ${user_management_session_token}    ${email_test_userapis}    4
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}
    sleep    5
    ${query_admin_user}    Query Admin User      ${email_test_userapis}
    Verify Add Admin User    ${fullname_test_userapis}    ${email_test_userapis}    4
    ${resp}    Delete Admin User     ${user_management_session_token}
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}


TC-01-004
    [Documentation]    POST create new user with role success - SESSION MANAGER
                #      In case of:
                #      - SESSION MANAGER
                #      - roleId = 3
    ${resp}    Create Admin User    ${user_management_session_token}    ${email_test_userapis}    3
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}
    sleep    5
    ${query_admin_user}    Query Admin User      ${email_test_userapis}
    Verify Add Admin User    ${fullname_test_userapis}    ${email_test_userapis}    3
    ${resp}    Delete Admin User     ${user_management_session_token}
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}


TC-01-005
    [Documentation]    POST create new user with role success - REWARD MANAGER
                #      In case of:
                #     - REWARD MANAGER
                #      - roleId = 2
    ${resp}    Create Admin User    ${user_management_session_token}    ${email_test_userapis}    2
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}
    sleep    5
    ${query_admin_user}    Query Admin User      ${email_test_userapis}
    Verify Add Admin User    ${fullname_test_userapis}    ${email_test_userapis}    2
    ${resp}    Delete Admin User     ${user_management_session_token}
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}


TC-01-006
    [Documentation]    POST create new user with role success  - ADMIN
                #      In case of:
                #       - ADMIN
                #      - roleId = 1
    ${resp}    Create Admin User    ${user_management_session_token}    ${email_test_userapis}    1
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}
    sleep    5
    ${query_admin_user}    Query Admin User      ${email_test_userapis}
    Verify Add Admin User    ${fullname_test_userapis}    ${email_test_userapis}    1
    ${resp}    Delete Admin User     ${user_management_session_token}
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}


TC-02-001
    [Documentation]    POST create new user with role failed - user don't have permission
                    #  In case of:
                    #  - user don't have permission
    ${resp}    Create Admin User    ${admin_session_token}    ${email_test_userapis}    1
    Assert Http Status Code Is 403 Dont Have Permission
    Assert Response Status Object With 4030 User Doesn't Have Permission     ${resp}
    Should Be Equal As Strings    ${resp['error']}    no permission


TC-03-001
    [Documentation]    POST create new user with role failed - invalid session token
                        #In case of:
                        # - invalid session token
    ${resp}    Create Admin User    ${user_management_session_token}23333    ${email_test_userapis}    1
    Assert Http Status Code Is 401 Unauthorized
    Assert Response Status Object With 4012 Unauthorized     ${resp}
    Should Be Equal As Strings    ${resp['error']}    signature is invalid


TC-03-002
    [Documentation]     POST create new user with role failed - session token expired
                        #In case of:
                        # - session token expired
    ${resp}    Create Admin User    ${user_management_session_token_exp}    ${email_test_userapis}    1
    Assert Http Status Code Is 401 Unauthorized
    Assert Response Status Object With 4012 Unauthorized     ${resp}
    Should Contain    ${resp['error']}    token is expired by


TC-03-003
    [Documentation]     POST create new user with role failed  - session token is an empty
                        # ...    In case of:
                        # - session token is an empty
    ${resp}    Create Admin User    ${EMPTY}    ${email_test_userapis}    1
    Assert Http Status Code Is 401 Unauthorized
    Assert Response Status Object With 4011 Unauthorized     ${resp}
    Should Be Equal As Strings    ${resp['error']}    Unable to parse token. Token might be empty string or null


TC-03-004
    [Documentation]     POST create new user with role failed - session token is not send
                        # In case of:
                        # - session token is not send
    ${resp}    Create Admin User    *REMOVE*    ${email_test_userapis}    1
    Assert Http Status Code Is 401 Unauthorized
    Assert Response Status Object With 4011 Unauthorized     ${resp}
    Should Be Equal As Strings    ${resp['error']}    Unable to parse token. Token might be empty string or null


TC-04-001
    [Documentation]     POST create new user with role failed - invalid email (domain not @infinitaskt.com, arise.tech)
                        # In case of:
                        # - invalid email (domain not @infinitaskt.com, arise.tech)
    ${resp}    Create Admin User    ${user_management_session_token}    aster.internal3@gmail.com    1
    Assert Http Status Code Is 400 Bad Request
    Assert Response Status Object With 4002 Invalid Parameter Request    ${resp}
    Should Be Equal As Strings    ${resp['error']}    Invalid Parameters: 'email' must be valid domain krungthai.com infinitaskt.com arise.tech but the input is 'gmail.com'.


TC-04-002
    [Documentation]     POST create new user with role failed - invalid email (email not found)
                        # In case of:
                        # - invalid email (email not found)
    ${resp}    Create Admin User    ${user_management_session_token}    aster.internal1@arise.tech    1
    Assert Http Status Code Is 404 Not Found
    Assert Response Status Object With 4040 Invalid Parameter Request    ${resp}
    Should Be Equal As Strings    ${resp['error']}    email not found


TC-04-003
    [Documentation]     POST create new user with role failed - invalid email (email already exists)
                        # In case of:
                        # - invalid email (email already exists)
    ${resp}    Create Admin User    ${user_management_session_token}    kingkan.n@infinitaskt.com    1
    Assert Http Status Code Is 400 Bad Request
    Assert Response Status Object With 4004 Invalid Duplicated Data Request    ${resp}
    Should Be Equal As Strings    ${resp['error']}    duplicate email backoffice user.


TC-04-004
    [Documentation]     POST create new user with role failed  - email is an empty
                        # In case of:
                        # - email is an empty
    ${resp}    Create Admin User    ${user_management_session_token}    ${EMPTY}    1
    Assert Http Status Code Is 400 Bad Request
    Assert Response Status Object With 4002 Invalid Parameter Request    ${resp}
    Should Be Equal As Strings    ${resp['error']}    Invalid Parameters: 'email' must be email format but the input is ''


TC-04-005
    [Documentation]     POST create new user with role failed - email is not send ex. {}
                        # In case of:
                        # - email is not send ex. {}
    ${resp}    Create Admin User    ${user_management_session_token}    *REMOVE*    1
    Assert Http Status Code Is 400 Bad Request
    Assert Response Status Object With 4002 Invalid Parameter Request    ${resp}
    Should Be Equal As Strings    ${resp['error']}    Invalid Parameters: 'email' must be REQUIRED field but the input is '<nil>'


TC-05-001
    [Documentation]     POST create new user with role failed  - invalid roleId (input int, roleId not found)
                        # In case of: 
                        # - invalid roleId (input int, roleId not found)
    ${resp}    Create Admin User    ${user_management_session_token}    ${email_test_userapis}    9
    Assert Http Status Code Is 404 Not Found
    Assert Response Status Object With 4040 Invalid Parameter Request    ${resp}
    Should Be Equal As Strings    ${resp['error']}    role id not found.


TC-05-002
    [Documentation]     POST create new user with role failed - invalid roleId (input string)
                        # In case of:
                        # - invalid roleId (input string)
    ${resp}    Create Admin User Case Not Send RoleID    ${user_management_session_token}    ${email_test_userapis}    *TEST*
    Assert Http Status Code Is 400 Bad Request
    Assert Response Status Object With 4001 Cannot Binding Json To Struct    ${resp}
    Should Be Equal As Strings    ${resp['error']}    json: cannot unmarshal string into Go struct field RegisterUserRequest.roleId of type int


      
TC-05-004   
    [Documentation]     POST create new user with role failed - roleId is not send 
                        # In case of:
                        # - roleId is not send 
    ${resp}    Create Admin User Case Not Send RoleID    ${user_management_session_token}    ${email_test_userapis}    *REMOVE*
    Assert Http Status Code Is 400 Bad Request
    Assert Response Status Object With 4002 Invalid Parameter Request    ${resp}
    Should Be Equal As Strings    ${resp['error']}    Invalid Parameters: 'roleId' must be REQUIRED field but the input is '<nil>'


TC-05-005 
    [Documentation]     POST create new user with role failed  - invalid email (email not found)  And - invalid roleId (input int, roleId not found)
                        # - invalid email (email not found)
                        # - invalid roleId (input int, roleId not found)
    ${resp}    Create Admin User    ${user_management_session_token}    aster.internal1@arise.tech    9
    Assert Http Status Code Is 404 Not Found
    Assert Response Status Object With 4040 Invalid Parameter Request    ${resp}
    Should Be Equal As Strings    ${resp['error']}    email not found

TC-06-001
        [Documentation]     POST create new user with role failed  - invalid method
                        # - invalid method
    ${resp}    Create Admin User Invalid Method    ${user_management_session_token}    ${email_test_userapis}    2
    Assert Http Status Code Is 404 Not Found


TC-06-002
        [Documentation]     POST create new user with role failed - invalid path
                        # - invalid path
    ${resp}    Create Admin User Invalid Path    ${user_management_session_token}    ${email_test_userapis}    2
    Assert Http Status Code Is 404 Not Found