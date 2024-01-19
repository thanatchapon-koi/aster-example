*** Settings ***
Resource    ${CURDIR}/../../../resources/imports.robot
Resource    ${CURDIR}/../../../keywords/common/common_keywords.robot
Resource    ${CURDIR}/../../../keywords/api/asset_group_apis.robot

*** Variables ***
${TC-01-003}  group_id=1
${TC-01-004}  category_id=1
${TC-01-005}  category_id=1&group_id=2
${TC-01-006}  group_id=1&category_id=1
${TC-01-007}  category_id=

*** Test Cases ***
TC-01-001
    [Documentation]    GET all assets group success,
    ...    In case of:
    ...    - have data all assets group 
    ${query_group_categoory}    Query Group Category  
    ${count_query}    Get Length    ${query_group_categoory}

    ${resp}    Get All Assets Group Success    ${admin_session_token}  ${EMPTY}
    Assert Http Status Code Is 200 Ok   
    Assert Response Status Object With 2000 Success    ${resp}

    ${count_resp}    Get Length     ${resp['data']}
    Should Be Equal    ${count_query}    ${count_resp}
    
    Validate All Of Field Name Is Correctly  ${resp['data']}  ${count_resp}


TC-01-003
    [Documentation]    GET all assets group success,
    ...    In case of:
    ...    - add parameter: group_id 
    ${resp}    Get All Assets Group Success    ${admin_session_token}  ${TC-01-003}
    Assert Http Status Code Is 200 Ok   
    Assert Response Status Object With 2000 Success    ${resp}
    ${count_resp}    Get Length     ${resp['data']}
    Validate All Of Field Name Is Correctly  ${resp['data']}  ${count_resp}


TC-01-004
    [Documentation]    GET all assets group success,
    ...    In case of:
    ...    - add parameter: category_id
    ${resp}    Get All Assets Group Success    ${admin_session_token}  ${TC-01-004}
    Assert Http Status Code Is 200 Ok   
    Assert Response Status Object With 2000 Success    ${resp}

    ${count_resp}    Get Length     ${resp['data']}
    Validate All Of Field Name Is Correctly  ${resp['data']}  ${count_resp}

TC-01-005
    [Documentation]    GET all assets group success,
    ...    In case of:
    ...    - add parameter: swap position (1)
    ...    1st: category_id
    ...    2nd: group_id
    ${resp}    Get All Assets Group Success    ${admin_session_token}  ${TC-01-005}
    Assert Http Status Code Is 200 Ok   
    Assert Response Status Object With 2000 Success    ${resp}

    ${count_resp}    Get Length     ${resp['data']}
    Validate All Of Field Name Is Correctly  ${resp['data']}  ${count_resp}

TC-01-006
    [Documentation]    GET all assets group success,
    ...    In case of:
    ...    - add parameter: swap position (2)
    ...    1st: group_id
    ...    2nd: category_id
    ${resp}    Get All Assets Group Success    ${admin_session_token}  ${TC-01-006}
    Assert Http Status Code Is 200 Ok   
    Assert Response Status Object With 2000 Success    ${resp}

    ${count_resp}    Get Length     ${resp['data']}
    Validate All Of Field Name Is Correctly  ${resp['data']}  ${count_resp}

TC-01-007
    [Documentation]    GET all assets group success,
    ...    In case of:
    ...    - add parameter group_id or category_id but not fill value
    ${resp}    Get All Assets Group Success    ${admin_session_token}  ${TC-01-007}
    Assert Http Status Code Is 200 Ok   
    Assert Response Status Object With 2000 Success    ${resp}
    
    ${result}=  Convert to String  ${resp['data']}
    Should Be Equal    ${result}    []

TC-02-001
    [Documentation]    GET all assets group fail,
    ...    In case of:
    ...    - invalid session token
    ${resp}    Get All Assets Group Fail    ${admin_session_token}123  ${EMPTY}
    Assert Http Status Code Is 401 Unauthorized
    Assert Response Status Object With 4012 Unauthorized    ${resp}

TC-02-002
    [Documentation]    GET all assets group fail,
    ...    In case of:
    ...    - session token expired
    ${resp}    Get All Assets Group Fail    ${admin_session_token_exp}  ${EMPTY}
    Assert Http Status Code Is 401 Unauthorized
    Assert Response Status Object With 4012 Unauthorized    ${resp}

TC-02-003
    [Documentation]    GET all assets group fail,
    ...    In case of:
    ...    - session token is an empty
    ${resp}    Get All Assets Group Fail    ${EMPTY}  ${EMPTY}
    Assert Http Status Code Is 401 Unauthorized
    Assert Response Status Object With 4011 Unauthorized    ${resp}

TC-02-004
    [Documentation]    GET all assets group fail,
    ...    In case of:
    ...    - session token (bearer) is not send
    ${resp}    Get All Assets Group But Bearer Is Not Send    ${admin_session_token}  ${EMPTY}
    Assert Http Status Code Is 401 Unauthorized
    Assert Response Status Object With 4011 Unauthorized    ${resp}

TC-02-005
    [Documentation]    GET all assets group fail,
    ...    In case of:
    ...    - session token is not send
    ${resp}    Get All Assets Group But Token Is Not Send     
    Assert Http Status Code Is 401 Unauthorized
    Assert Response Status Object With 4011 Unauthorized    ${resp}

TC-03-001
    [Documentation]    GET all assets group fail,
    ...    In case of:
    ...    - invalid path
    ${resp}    Get All Assets Group But Send Invalid Path    ${admin_session_token}
    Assert Http Status Code Is 404 Not Found

TC-03-002
    [Documentation]    GET all assets group fail,
    ...    In case of:
    ...    - invalid method
    ${resp}    Get All Assets Group But Send Invalid Method    ${admin_session_token}
    Assert Http Status Code Is 404 Not Found



