*** Settings ***
Resource    ${CURDIR}/../../resources/imports.robot

*** Keywords ***

Assert Response Status Object With 2000 Success
    [Documentation]    Assert response of status object in case 2000 success
    [Arguments]    ${response}
    Should Be Equal As Integers   ${response['code']}     2000
    Should Be Equal As Strings    ${response['message']}    Success.

Assert Response Status Object With 4001 Cannot Binding Json To Struct
    [Documentation]    Assert Response Status Object With 4001 Cannot Binding Json To Struct
    [Arguments]    ${response}
    Should Be Equal As Integers   ${response['code']}     4001
    Should Be Equal As Strings    ${response['message']}    Cannot binding json to struct.

Assert Response Status Object With 4002 Invalid Parameter Request
    [Documentation]    Assert response of status object in case 4002 Invalid Parameter Request
    [Arguments]    ${response}
    Should Be Equal As Integers   ${response['code']}     4002
    Should Be Equal As Strings    ${response['message']}    Invalid parameter request.

Assert Response Status Object With 4004 Invalid Duplicated Data Request
    [Documentation]    Assert Response Status Object With 4004 Invalid duplicated data request
    [Arguments]    ${response}
    Should Be Equal As Integers   ${response['code']}     4004
    Should Be Equal As Strings    ${response['message']}    Invalid duplicated data request.

Assert Response Status Object With 4010 UNAUTHENTICATED
    [Documentation]    Assert response of status object in case 4010 UNAUTHENTICATED
    [Arguments]    ${response}
    Should Be Equal As Strings    ${response['code']}    4010
    Should Be Equal As Strings    ${response['message']}    UNAUTHENTICATED

Assert Response Status Object With 4011 Unauthorized
    [Documentation]    Assert response of status object in case 4011 unauthorized
    [Arguments]    ${response}
    Should Be Equal As Strings    ${response['code']}    4011
    Should Be Equal As Strings    ${response['message']}    Session token is null or empty string.

Assert Response Status Object With 4012 Unauthorized
    [Documentation]    Assert response of status object in case 4012 unauthorized
    [Arguments]    ${response}
    Should Be Equal As Strings    ${response['code']}    4012
    Should Be Equal As Strings    ${response['message']}    Failed to verify session token or token has expired.

Assert Response Status Object With 4030 User Doesn't Have Permission  
    [Documentation]    Assert response of status object in case 4030 User Doesn't Have Permission
    [Arguments]    ${response}
    Should Be Equal As Integers   ${response['code']}     4030
    Should Be Equal As Strings    ${response['message']}    User doesn't have permission to do this action.

Assert Response Status Object With 4040 Invalid Parameter Request
    [Documentation]    Assert Response Status Object With 4040 Invalid Parameter Request
    [Arguments]    ${response}
    Should Be Equal As Integers   ${response['code']}     4040
    Should Be Equal As Strings    ${response['message']}    Invalid parameter request.
    