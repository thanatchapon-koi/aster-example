*** Settings ***
Resource    ${CURDIR}/../../../resources/imports.robot
Resource    ${CURDIR}/../../../keywords/common/common_keywords.robot
Resource    ${CURDIR}/../../../keywords/api/asset_apis.robot

*** Variables ***
${asset_id}  591
${asset_id_is_not_found}  9999


*** Test Cases ***
TC-01-001
    [Documentation]    DELETE asset by asset_id success
    Updated Asset At DB for Delete   ${asset_id}
    ${resp}    Delete Asset By ID   ${admin_session_token}   ${asset_id}
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp} 
    ${query_asset}    Verify Deleted Asset At DB   ${asset_id}

TC-01-002
    [Documentation]    DELETE asset by asset_id fail,
    ...    In case of:
    ...    - asset id has deleted before
    ${resp}    Delete Asset By ID   ${admin_session_token}   ${asset_id}
    Assert Response Status Object With 4040 Invalid Parameter Request   ${resp}

TC-01-003
    [Documentation]    DELETE asset by asset_id fail,
    ...    In case of:
    ...    - asset id is wrong format/type
    ${resp}    Delete Asset By ID   ${admin_session_token}   abcd
    Assert Response Status Object With 4002 Invalid Parameter Request   ${resp}

TC-01-004
    [Documentation]    DELETE asset by asset_id fail,
    ...    In case of:
    ...    - asset id is not found or not existing
    ${resp}    Delete Asset By ID   ${admin_session_token}   ${asset_id_is_not_found}
    Assert Response Status Object With 4040 Invalid Parameter Request   ${resp}

TC-02-001
    [Documentation]    DELETE asset by asset_id fail,
    ...    In case of:
    ...    - invalid session token
    ${resp}    Delete Asset By ID   ${admin_session_token}test   ${asset_id}
    Assert Http Status Code Is 401 Unauthorized
    Assert Response Status Object With 4012 Unauthorized    ${resp}
    Should Be Equal As Strings    ${resp['error']}     signature is invalid

TC-02-002
    [Documentation]    DELETE asset by asset_id fail,
    ...    In case of:
    ...    - session token expired
    ${resp}   Delete Asset By ID    ${admin_session_token_exp}   ${asset_id}
    Assert Http Status Code Is 401 Unauthorized
    Assert Response Status Object With 4012 Unauthorized    ${resp}
    Should Contain    ${resp['error']}     token is expired by

TC-02-003
    [Documentation]    DELETE asset by asset_id fail,
    ...    In case of:
    ...    - session token is an empty
    ${resp}   Delete Asset By ID    ${EMPTY}   ${asset_id}
    Assert Http Status Code Is 401 Unauthorized
    Assert Response Status Object With 4011 Unauthorized    ${resp}
    Should Be Equal As Strings    ${resp['error']}     Unable to parse token. Token might be empty string or null

TC-02-004
    [Documentation]    DELETE asset by asset_id fail,
    ...    In case of:
    ...    - session token (bearer) is not send
    ${resp}   Delete Asset By ID But Bearer Is Not Send    ${admin_session_token}   ${asset_id} 
    Assert Http Status Code Is 401 Unauthorized
    Assert Response Status Object With 4011 Unauthorized    ${resp}
    Should Be Equal As Strings    ${resp['error']}     Unable to parse token. Token might be empty string or null

TC-02-005
    [Documentation]    DELETE asset by asset_id fail,
    ...    In case of:
    ...    - session token is not send
    ${resp}   Delete Asset By ID But Token Is Not Send  
    Assert Http Status Code Is 401 Unauthorized
    Assert Response Status Object With 4011 Unauthorized    ${resp}
    Should Be Equal As Strings    ${resp['error']}     Unable to parse token. Token might be empty string or null

TC-03-001
    [Documentation]    DELETE asset by asset_id fail,
    ...    In case of:
    ...    - invalid path
    ${resp}   Delete Asset By ID But Send Invalid Path   ${admin_session_token}   ${asset_id} 
    Assert Http Status Code Is 404 Not Found

TC-03-002
    [Documentation]    DELETE asset by asset_id fail,
    ...    In case of:
    ...    - invalid method
    ${resp}   Delete Asset By ID But Send Invalid Method   ${admin_session_token}   ${asset_id} 
    Assert Http Status Code Is 404 Not Found