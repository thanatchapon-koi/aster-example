*** Settings ***
Resource    ${CURDIR}/../../../resources/imports.robot
Resource    ${CURDIR}/../../../keywords/common/common_keywords.robot
Resource    ${CURDIR}/../../../keywords/api/user_apis.robot




*** Test Cases ***

TC-01-001
    [Documentation]    PUT update user role success
    ...    In case of:
    ...    - send valid field "userId"
    ...    - send valid field "role" (change to new role)

    Create Admin User Success
    ${resp}    Edit Admin User    ${user_management_session_token}    5
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}
    sleep    2
    ${query_admin_user}    Query Admin User     ${email_test_userapis}
    Verify Add Admin User    ${fullname_test_userapis}    ${email_test_userapis}    5
    Delete Admin User Success


TC-01-002
    [Documentation]    PUT update user role success
    ...    In case of:
    ...    - send valid field "userId" 
    ...    - send valid field "role" (input the same role or old role)

    Create Admin User Success
    ${resp}    Edit Admin User    ${user_management_session_token}    1
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}
    sleep    2
    ${query_admin_user}    Query Admin User     ${email_test_userapis}
    Verify Add Admin User    ${fullname_test_userapis}    ${email_test_userapis}    1
    Delete Admin User Success



TC-01-004
    [Documentation]    PUT update user role fail
    ...    In case of:
    ...    - send field "userId" is empty
    ...    - send valid field "userId" 

    ${resp}    Edit Admin User Case Invalid    ${user_management_session_token}    ${EMPTY}    2
    Assert Http Status Code Is 404 Not Found
    Assert Response Status Object With 4040 Invalid Parameter Request    ${resp}
    Should Be Equal As Strings    ${resp['error']}    user not found


TC-01-005
    [Documentation]    PUT update user role fail
    ...    In case of:
    ...    - not send valid field "userId" 
    ...    - send valid field "role"  

    ${resp}    Edit Admin User Case Invalid    ${user_management_session_token}    *REMOVE*     2 
    Assert Http Status Code Is 400 Bad Request
    Assert Response Status Object With 4002 Invalid Parameter Request    ${resp}
    Should Be Equal As Strings    ${resp['error']}    Invalid Parameters: 'UserId' must be REQUIRED field but the input is '<nil>'


TC-01-006
    [Documentation]    PUT update user role fail
    ...    In case of:
    ...    - send valid field "userId" 
    ...    - not send valid field "role"

    ${resp}    Edit Admin User Case Invalid Roleid    ${user_management_session_token}    e7d25721-5717-4dd5-aab0-29a9290de333     *REMOVE*
    Assert Http Status Code Is 400 Bad Request
    Assert Response Status Object With 4002 Invalid Parameter Request    ${resp}
    Should Be Equal As Strings    ${resp['error']}    Invalid Parameters: 'roleId' must be REQUIRED field but the input is '<nil>'



TC-01-007
    [Documentation]    PUT update user role fail
    ...    In case of:
    ...    - send field "userId" is not existing (not found)
    ...    - send valid field "role"

    ${resp}    Edit Admin User Case Invalid    ${user_management_session_token}    88d25721-5717-4dd5-aab0-29a9290de333     3
    Assert Http Status Code Is 404 Not Found
    Assert Response Status Object With 4040 Invalid Parameter Request    ${resp}
    Should Be Equal As Strings    ${resp['error']}    user not found


TC-01-008
    [Documentation]    PUT update user role fail
    ...    In case of:
    ...    - send valid field "userId"
    ...    - send field "role" is invalid and not existing (not found)

    ${resp}    Edit Admin User Case Invalid    ${user_management_session_token}    e7d25721-5717-4dd5-aab0-29a9290de205     11
    Assert Http Status Code Is 404 Not Found
    Assert Response Status Object With 4040 Invalid Parameter Request    ${resp}
    Should Be Equal As Strings    ${resp['error']}    invalid role id



TC-01-009
    [Documentation]    PUT update user role fail
    ...    In case of:
    ...    - send field "userId" is invalid type 
    ...    - send valid field "role"

    ${user_id}    Convert To Integer    45
    ${resp}    Edit Admin User Case Invalid    ${user_management_session_token}    ${user_id}     3
    Assert Http Status Code Is 400 Bad Request
    Assert Response Status Object With 4001 Cannot Binding Json To Struct    ${resp}
    Should Be Equal As Strings    ${resp['error']}    json: cannot unmarshal number into Go struct field EditUserRequest.userId of type string


TC-01-010
    [Documentation]    PUT update user role fail
    ...    In case of:
    ...    - send valid field "userId" 
    ...    - send field "role" is invalid  (input string)

    
    ${resp}    Edit Admin User Case Invalid Roleid    ${user_management_session_token}    e7d25721-5717-4dd5-aab0-29a9290de205    Test     
    Assert Http Status Code Is 400 Bad Request
    Assert Response Status Object With 4001 Cannot Binding Json To Struct    ${resp}
    Should Be Equal As Strings    ${resp['error']}    json: cannot unmarshal string into Go struct field EditUserRequest.roleId of type int

TC-01-011
    [Documentation]    PUT update user role success
    ...    In case of:
    ...    - send valid field "userId"
    ...    - send valid field "role" (แก้ role ของตัวเอง ให้ต่ำกว่า USER MANAGER )

    ${resp}    Edit Admin User Case Invalid    ${user_management_session_token}    906a7819-7a97-480b-b381-4197c5faad0a    1
    Assert Http Status Code Is 403 Dont Have Permission
    Assert Response Status Object With 4030 User Doesn't Have Permission    ${resp}
    Should Be Equal As Strings    ${resp['error']}    user can't edit yourself



TC-01-012
    [Documentation]    PUT update user role success
    ...    In case of:
    ...    - send valid field "userId"
    ...    - send valid field "role" (แก้ role ของ USER MANAGER คนอื่น > เป็น Role อื่น)

    Create Admin User Success
    ${resp}    Edit Admin User    ${user_management_session_token}    1
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}
    sleep    2
    ${query_admin_user}    Query Admin User     ${email_test_userapis}
    Verify Add Admin User    ${fullname_test_userapis}    ${email_test_userapis}    1
    Delete Admin User Success



TC-02-001
    [Documentation]    PUT update user role fail
    ...    In case of:
    ...    - user don't have permission

    ${resp}    Edit Admin User Case Invalid    ${admin_session_token}    e7d25721-5717-4dd5-aab0-29a9290de205    1
    Assert Http Status Code Is 403 Dont Have Permission
    Assert Response Status Object With 4030 User Doesn't Have Permission    ${resp}
    Should Be Equal As Strings    ${resp['error']}    no permission


TC-03-001
    [Documentation]    PUT update user role fail
    ...    In case of:
    ...    - invalid session token

    ${resp}    Edit Admin User Case Invalid    ${user_management_session_token}33333    e7d25721-5717-4dd5-aab0-29a9290de205    1
    Assert Http Status Code Is 401 Unauthorized
    Assert Response Status Object With 4012 Unauthorized    ${resp}
    Should Be Equal As Strings    ${resp['error']}    signature is invalid


TC-03-002
    [Documentation]    PUT update user role fail
    ...    In case of:
    ...    - session token expired

    ${resp}    Edit Admin User Case Invalid    ${user_management_session_token_exp}     e7d25721-5717-4dd5-aab0-29a9290de205    1
    Assert Http Status Code Is 401 Unauthorized
    Assert Response Status Object With 4012 Unauthorized    ${resp}
    Should Contain    ${resp['error']}    token is expired by


TC-03-003
    [Documentation]    PUT update user role fail
    ...    In case of:
    ...    - session token is not send

    ${resp}    Edit Admin User Case Invalid    *REMOVE*     e7d25721-5717-4dd5-aab0-29a9290de205    1
    Assert Http Status Code Is 401 Unauthorized
    Assert Response Status Object With 4011 Unauthorized    ${resp}
    Should Be Equal As Strings    ${resp['error']}    Unable to parse token. Token might be empty string or null



