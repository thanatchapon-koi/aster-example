*** Settings ***
Resource    ${CURDIR}/../../../resources/imports.robot
Resource    ${CURDIR}/../../../keywords/common/common_keywords.robot
Resource    ${CURDIR}/../../../resources/testdata/common_configs.robot
Resource    ${CURDIR}/../../../keywords/api/assert_response.robot
Resource    ${CURDIR}/../../../keywords/api/http_status_code.robot
Resource    ${CURDIR}/../../../keywords/api/benner_api.robot

*** Test Cases ***
TC-01-001
    [Documentation]    GET session banner list for preview in back office success
    ...    In case of:
    ...    - no data
    ${query_banner}    Query Session Banner
    ${count_query}    Get Length    ${query_banner}
    ${resp}    GET Session Banner List Success    ${admin_session_token}
    Assert Http Status Code Is 200 Ok   
    Assert Response Status Object With 2000 Success    ${resp}
    ${count_resp}    Get Length     ${resp['data']['activeBanner']}
    Should Be Equal    ${count_query}    ${count_resp}

TC-01-002
    [Documentation]    GET get session banner list for preview in back office success
    ...    In case of:
    ...    - have at least 1 banner
    ${query_banner}    Query Session Banner
    ${count_query}    Get Length    ${query_banner}
    ${resp}    GET Session Banner List Success    ${admin_session_token}
    Assert Http Status Code Is 200 Ok   
    Assert Response Status Object With 2000 Success    ${resp}
    ${count_resp}    Get Length     ${resp['data']['activeBanner']}
    Should Be Equal    ${count_query}    ${count_resp}

TC-02-001
    [Documentation]    GET get session banner list for preview in back office Fail
    ...    In case of:    
    ...    - user doesn't have permission
    ${resp}     GET Session Banner List Failed    ${user_management_session_token}  
    Assert Http Status Code Is 403 Dont Have Permission  
    Assert Response Status Object With 4030 User Doesn't Have Permission     ${resp}


TC-03-001
    [Documentation]    GET get session banner list for preview in back office failed
    ...    In case of:    
    ...    - invalid session token
    ${resp}     GET Session Banner List Failed    ${user_management_session_token}test
    Assert Http Status Code Is 401 Unauthorized  
    Assert Response Status Object With 4012 Unauthorized     ${resp}

TC-03-002
    [Documentation]    GET get session banner list for preview in back office failed
    ...    In case of:    
    ...    - session token expired
    ${resp}     GET Session Banner List Failed    ${admin_session_token_exp} 
    Assert Http Status Code Is 401 Unauthorized  
    Assert Response Status Object With 4012 Unauthorized     ${resp}

TC-03-003
    [Documentation]    GET get session banner list for preview in back office failed
    ...    In case of:    
    ...    - session token is an empty
    ${resp}     GET Session Banner List Failed    ${EMPTY} 
    Assert Http Status Code Is 401 Unauthorized  
    Assert Response Status Object With 4011 Unauthorized     ${resp}

TC-04-004
    [Documentation]    GET get session banner list for preview in back office failed
    ...    In case of:    
    ...    - session token (bearer) is not send
    ${resp}     Get Session Banner But Bearer Is Not Send    ${admin_session_token}    
    Assert Http Status Code Is 401 Unauthorized
    Assert Response Status Object With 4011 Unauthorized    ${resp}

TC-03-005
    [Documentation]    GET get session banner list for preview in back office failed
    ...    In case of:    
    ...    - session token is not send
    ${resp}     GET Session Banner List Failed    *REMOVE* 
    Assert Http Status Code Is 401 Unauthorized  
    Assert Response Status Object With 4011 Unauthorized     ${resp}

TC-04-001
    [Documentation]    GET show whitelist user Failed
    ...    In case of:
    ...    - invalid path
    ${resp}    Get Session Banner But Send Invalid Path    ${admin_session_token}
    Assert Http Status Code Is 404 Not Found


TC-04-002
    [Documentation]    GGET show whitelist user Failed
    ...    In case of:
    ...    - invalid method
    ${resp}    OPTIONS Session Banner But Send Invalid Method    ${admin_session_token}    
    Assert Http Status Code Is 404 Not Found
