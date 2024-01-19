*** Settings ***
Resource    ${CURDIR}/../../../resources/imports.robot
Resource    ${CURDIR}/../../../keywords/common/common_keywords.robot
Resource    ${CURDIR}/../../../keywords/api/user_apis.robot

*** Test Cases ***

TC-01-001
    [Documentation]    GET search api for speaker on admin
    ...    In case of: input query with alphabet = 1 digit
    ...    Remark: ระบบแสดงจำนวนข้อมูล default = 10
    ${query_user_list}    Query User Lists Where String    A
    ${resp}    Call API GET Search Speaker User With Query    ${admin_session_token}    A
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}
    Validate Name Of Fields In Search Speaker User APIs Is Completely    ${resp}
    Validate Type Of Speaker User Data In APIs    ${resp}
    Preapare Data In Database And Search Speaker User APIs With Limits    ${query_user_list}    ${resp}    10

TC-01-002
    [Documentation]    GET search api for speaker on admin
    ...    In case of: input query with alphabet > 1 digit
    ...    Remark: ระบบแสดงจำนวนข้อมูล default = 10
    ${query_user_list}    Query User Lists Where String    Ni
    ${resp}    Call API GET Search Speaker User With Query    ${admin_session_token}    Ni
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}
    Validate Name Of Fields In Search Speaker User APIs Is Completely    ${resp}
    Validate Type Of Speaker User Data In APIs    ${resp}
    Preapare Data In Database And Search Speaker User APIs With Limits    ${query_user_list}    ${resp}    10

TC-01-003
    [Documentation]    GET search api for speaker on admin
    ...    In case of: input query with first name
    ${query_user_list}    Query User Lists Where String    Nipaphorn
    ${resp}    Call API GET Search Speaker User With Query    ${admin_session_token}    Nipaphorn
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}
    Validate Name Of Fields In Search Speaker User APIs Is Completely    ${resp}
    Validate Type Of Speaker User Data In APIs    ${resp}
    Preapare Data In Database And Search Speaker User APIs With Limits    ${query_user_list}    ${resp}    10

TC-01-004
    [Documentation]    GET search api for speaker on admin
    ...    In case of: input query with last name
    ${query_user_list}    Query User Lists Where String    Khantikit
    ${resp}    Call API GET Search Speaker User With Query    ${admin_session_token}    Khantikit
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}
    Preapare Data In Database And Search Speaker User APIs With Limits    ${query_user_list}    ${resp}    10

TC-01-005
    [Documentation]    GET search api for speaker on admin
    ...    In case of: input query with email (e.g. abcd.e@infinitaskt.com)
    ${query_user_list}    Query User Lists Where String    nipaphorn.k@arise.tech
    ${resp}    Call API GET Search Speaker User With Query    ${admin_session_token}    nipaphorn.k@arise.tech
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}
    Validate Name Of Fields In Search Speaker User APIs Is Completely    ${resp}
    Validate Type Of Speaker User Data In APIs    ${resp}
    Preapare Data In Database And Search Speaker User APIs With Limits    ${query_user_list}    ${resp}    10

TC-01-006
    [Documentation]    GET search api for speaker on admin
    ...    In case of: input query with email or name that not found
    ${query_user_list}    Query User Lists Where String    not found
    ${resp}    Call API GET Search Speaker User With Query    ${admin_session_token}    not found
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}
    Preapare Data In Database And Search Speaker User APIs With Limits    ${query_user_list}    ${resp}    10

TC-01-007
    [Documentation]    GET search api for speaker on admin
    ...    In case of: input query with numeric = 1 digit 
    ${query_user_list}    Query User Lists Where String    6
    ${resp}    Call API GET Search Speaker User With Query    ${admin_session_token}    6
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}
    Validate Name Of Fields In Search Speaker User APIs Is Completely    ${resp}
    Validate Type Of Speaker User Data In APIs    ${resp}
    Preapare Data In Database And Search Speaker User APIs With Limits    ${query_user_list}    ${resp}    10

TC-01-008
    [Documentation]    GET search api for speaker on admin
    ...    In case of: input query with numeric > 1 digit
    ${query_user_list}    Query User Lists Where String    667
    ${resp}    Call API GET Search Speaker User With Query    ${admin_session_token}    667
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}
    Validate Name Of Fields In Search Speaker User APIs Is Completely    ${resp}
    Validate Type Of Speaker User Data In APIs    ${resp}
    Preapare Data In Database And Search Speaker User APIs With Limits    ${query_user_list}    ${resp}    10

TC-01-009
    [Documentation]    GET search api for speaker on admin
    ...    In case of: input query with employee id
    ${query_user_list}    Query User Lists Where String    667038
    ${resp}    Call API GET Search Speaker User With Query    ${admin_session_token}    667038
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}
    Validate Name Of Fields In Search Speaker User APIs Is Completely    ${resp}
    Validate Type Of Speaker User Data In APIs    ${resp}
    Preapare Data In Database And Search Speaker User APIs With Limits    ${query_user_list}    ${resp}    10

TC-01-010
    [Documentation]    GET search api for speaker on admin
    ...    In case of: input query with employee id that not found
    ${query_user_list}    Query User Lists Where String    666666
    ${resp}    Call API GET Search Speaker User With Query    ${admin_session_token}    666666
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}
    Preapare Data In Database And Search Speaker User APIs With Limits    ${query_user_list}    ${resp}    10

TC-01-011
    [Documentation]    GET search api for speaker on admin
    ...    In case of: send query data with empty value
    ...    Remark: ระบบแสดงจำนวนข้อมูล default = 10
    ${query_user_list}    Query User Lists Where String    T
    ${resp}    Call API GET Search Speaker User With Query    ${admin_session_token}    T
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}
    Validate Name Of Fields In Search Speaker User APIs Is Completely    ${resp}
    Validate Type Of Speaker User Data In APIs    ${resp}
    Preapare Data In Database And Search Speaker User APIs With Limits    ${query_user_list}    ${resp}    10

TC-01-012
    [Documentation]    GET search api for speaker on admin
    ...    In case of: not send Query query data
    ${query_user_list}    Query User Lists Without String
    ${resp}    Call API GET Search Speaker User Without Query    ${admin_session_token}
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}
    Validate Name Of Fields In Search Speaker User APIs Is Completely    ${resp}
    Validate Type Of Speaker User Data In APIs    ${resp}
    Preapare Data In Database And Search Speaker User APIs With Limits    ${query_user_list}    ${resp}    10

TC-02-001
    [Documentation]    GET search api for speaker on admin
    ...    In case of:
    ...    - input query with alphabet or numeric
    ...    - input limit with numeric < 100
    ...    Remark: ระบบแสดงจำนวนข้อมูลตาม limit ที่กรอก
    ${query_user_list}    Query User Lists Without String And With Limits    5
    ${resp}    Call API GET Search Speaker User With Limits    ${admin_session_token}    5
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}
    Validate Name Of Fields In Search Speaker User APIs Is Completely    ${resp}
    Validate Type Of Speaker User Data In APIs    ${resp}
    Preapare Data In Database And Search Speaker User APIs With Limits    ${query_user_list}    ${resp}    5

TC-02-002
    [Documentation]    GET search api for speaker on admin
    ...    In case of:
    ...    - input query with alphabet or numeric
    ...    - input limit with numeric = 100
    ...    Remark: ระบบแสดงจำนวนข้อมูลตาม limit ที่กรอก หากมีข้อมูลเพียงพอ
    ${query_user_list}    Query User Lists Without String And With Limits    100
    ${resp}    Call API GET Search Speaker User With Limits    ${admin_session_token}    100
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}
    Validate Name Of Fields In Search Speaker User APIs Is Completely    ${resp}
    Validate Type Of Speaker User Data In APIs    ${resp}
    Preapare Data In Database And Search Speaker User APIs With Limits    ${query_user_list}    ${resp}    100

TC-02-003
    [Documentation]    GET search api for speaker on admin
    ...    In case of:
    ...    - input query with alphabet or numeric
    ...    - input limit with numeric > 100
    ...    Remark: ระบบแสดงจำนวนข้อมูล = 10
    ${query_user_list}    Query User Lists Without String And With Limits    10
    ${resp}    Call API GET Search Speaker User With Limits    ${admin_session_token}    188
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}
    Validate Name Of Fields In Search Speaker User APIs Is Completely    ${resp}
    Validate Type Of Speaker User Data In APIs    ${resp}
    Preapare Data In Database And Search Speaker User APIs With Limits    ${query_user_list}    ${resp}    10

TC-03-001
    [Documentation]    GET search api for speaker on admin
    ...    In case of:
    ...    - input query with alphabet or numeric
    ...    - input limit with numeric < 100
    ...    Remark: ระบบแสดงจำนวนข้อมูลตาม limit ที่กรอก
    ${query_user_list}    Query User Lists Where String And With Limits    66    13
    ${resp}    Call API GET Search Speaker User With Query And Limits    ${admin_session_token}    66    13
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}
    Validate Name Of Fields In Search Speaker User APIs Is Completely    ${resp}
    Validate Type Of Speaker User Data In APIs    ${resp}
    Preapare Data In Database And Search Speaker User APIs With Limits    ${query_user_list}    ${resp}    13

TC-03-002
    [Documentation]    GET search api for speaker on admin
    ...    In case of:
    ...    - input query with alphabet or numeric
    ...    - input limit with numeric = 100
    ...    Remark: ระบบแสดงจำนวนข้อมูลตาม limit ที่กรอก
    ${query_user_list}    Query User Lists Where String And With Limits    6    100
    ${resp}    Call API GET Search Speaker User With Query And Limits    ${admin_session_token}    6    100
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}
    Validate Name Of Fields In Search Speaker User APIs Is Completely    ${resp}
    Validate Type Of Speaker User Data In APIs    ${resp}
    Preapare Data In Database And Search Speaker User APIs With Limits    ${query_user_list}    ${resp}    100  

TC-03-003
    [Documentation]    GET search api for speaker on admin
    ...    In case of:
    ...    - input query with alphabet or numeric
    ...    - input limit with numeric > 100
    ...    Remark: ระบบแสดงจำนวนข้อมูล = 10 
    ${query_user_list}    Query User Lists Where String And With Limits    6    10
    ${resp}    Call API GET Search Speaker User With Query And Limits    ${admin_session_token}    6    399
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}
    Validate Name Of Fields In Search Speaker User APIs Is Completely    ${resp}
    Validate Type Of Speaker User Data In APIs    ${resp}
    Preapare Data In Database And Search Speaker User APIs With Limits    ${query_user_list}    ${resp}    10  

TC-03-004
    [Documentation]    GET search api for speaker on admin
    ...    In case of:
    ...    - input query with alphabet or numeric
    ...    - input limit with negative numeric
    ...    Remark: ระบบแสดงจำนวนข้อมูล = 10 
    ${query_user_list}    Query User Lists Where String And With Limits    667    10
    ${resp}    Call API GET Search Speaker User With Query And Limits    ${admin_session_token}    667    -8
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}
    Validate Name Of Fields In Search Speaker User APIs Is Completely    ${resp}
    Validate Type Of Speaker User Data In APIs    ${resp}
    Preapare Data In Database And Search Speaker User APIs With Limits    ${query_user_list}    ${resp}    10     

TC-03-005
    [Documentation]    GET search api for speaker on admin
    ...    In case of:
    ...    - input query with alphabet or numeric
    ...    - input limit with alphabet
    ...    Remark: ระบบแสดงจำนวนข้อมูล = 10 
    ${query_user_list}    Query User Lists Where String And With Limits    667    10
    ${resp}    Call API GET Search Speaker User With Query And Limits    ${admin_session_token}    667    DD
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}
    Validate Name Of Fields In Search Speaker User APIs Is Completely    ${resp}
    Validate Type Of Speaker User Data In APIs    ${resp}
    Preapare Data In Database And Search Speaker User APIs With Limits    ${query_user_list}    ${resp}    10     

TC-04-001
    [Documentation]    GET search api for speaker on admin
    ...    In case of: - invalid session token (add/delete some text)
    ${query_user_list}    Query User Lists Where String    A
    ${resp}    Call API GET Search Speaker User With Query    ${admin_session_token}fdg    A
    Assert Http Status Code Is 401 Unauthorized
    Assert Response Status Object With 4012 Unauthorized    ${resp}

TC-04-002
    [Documentation]    GET search api for speaker on admin
    ...    In case of: - session token is an expired
    ${query_user_list}    Query User Lists Where String    A
    ${resp}    Call API GET Search Speaker User With Query    ${admin_session_token_exp}    A
    Assert Http Status Code Is 401 Unauthorized
    Assert Response Status Object With 4012 Unauthorized    ${resp}

TC-04-003
    [Documentation]    GET search api for speaker on admin
    ...    In case of: - session token is an empty
    ${resp}    Call API GET Search Speaker User With Query    ${EMPTY}    A
    Assert Http Status Code Is 401 Unauthorized
    Assert Response Status Object With 4011 Unauthorized    ${resp}

TC-04-004
    [Documentation]    GET search api for speaker on admin
    ...    In case of: - session token (bearer) is not send
    ${resp}    Call API GET Search Speaker User Without Bearer    ${admin_session_token}    A
    Assert Http Status Code Is 401 Unauthorized
    Assert Response Status Object With 4011 Unauthorized    ${resp}

TC-04-005
    [Documentation]    GET search api for speaker on admin
    ...    In case of: - session token is not send
    ${resp}    Call API GET Search Speaker User With Query    *REMOVE*    A
    Assert Http Status Code Is 401 Unauthorized
    Assert Response Status Object With 4011 Unauthorized    ${resp}

TC-05-001
    [Documentation]    GET search api for speaker on admin
    ...    In case of:  - invalid method
    ${resp}    Call API GET Search Speaker User With Invalid Method    ${admin_session_token}    A
    Assert Http Status Code Is 404 Not Found

TC-05-002
    [Documentation]    GET search api for speaker on admin
    ...    In case of:  - invalid path
    ${resp}    Call API GET Search Speaker User With Invalid Path    ${admin_session_token}    A
    Assert Http Status Code Is 404 Not Found  