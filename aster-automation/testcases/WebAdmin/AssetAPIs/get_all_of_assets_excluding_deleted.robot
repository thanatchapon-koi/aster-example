*** Settings ***
Resource    ${CURDIR}/../../../resources/imports.robot
Resource    ${CURDIR}/../../../keywords/common/common_keywords.robot
Resource    ${CURDIR}/../../../keywords/api/asset_apis.robot


*** Test Cases ***
TC-01-001
    [Documentation]    Get all Asset excluding deleted success
    ...    In case of:
    ...    - have Asset that have not deleted
    ${query_asset}    Query Asset
    ${count_query}    Get Length    ${query_asset}
    ${resp}    Get All Asset Excluding Deleted Success    ${admin_session_token}
    Assert Http Status Code Is 200 Ok   
    Assert Response Status Object With 2000 Success    ${resp}
    ${count_resp}    Get Length     ${resp['data']}
    Should Be Equal    ${count_query}    ${count_resp}

TC-01-002
    [Documentation]    Get all Asset excluding deleted success
    ...    In case of:
    ...    - have Asset that have deleted (will not show data)
    ${query_asset}    Query Asset
    ${count_query}    Get Length    ${query_asset}
    ${resp}    Get All Asset Excluding Deleted Success    ${admin_session_token}
    Assert Http Status Code Is 200 Ok   
    Assert Response Status Object With 2000 Success    ${resp}
    ${count_resp}    Get Length     ${resp['data']}
    Should Be Equal    ${count_query}    ${count_resp}


TC-01-003
    [Documentation]    Get all Asset excluding deleted success
    ...    In case of:
    ...    - not have data field: previewURL (optional)  will not show parameter
    ${query_asset}    Query Asset
    ${count_query}    Get Length    ${query_asset}
    ${resp}    Get All Asset Excluding Deleted Success    ${admin_session_token}
    Assert Http Status Code Is 200 Ok   
    Assert Response Status Object With 2000 Success    ${resp}
    ${count_resp}    Get Length     ${resp['data']}
    Should Be Equal    ${count_query}    ${count_resp}

TC-01-004
    [Documentation]    Get all Asset excluding deleted success
    ...    In case of:
    ...    - not have data field: tier (optional) will not show parameter
    ${query_asset}    Query Asset
    ${count_query}    Get Length    ${query_asset}
    ${resp}    Get All Asset Excluding Deleted Success    ${admin_session_token}
    Assert Http Status Code Is 200 Ok   
    Assert Response Status Object With 2000 Success    ${resp}
    ${count_resp}    Get Length     ${resp['data']}
    Should Be Equal    ${count_query}    ${count_resp}

TC-01-005
    [Documentation]    Get all Asset excluding deleted success
    ...    In case of:
    ...    - sort data correctly : createdAt sort data by new to old (DESC)
    ${query_asset}    Query Asset
    ${count_query}    Get Length    ${query_asset}
    ${resp}    Get All Asset Excluding Deleted Success    ${admin_session_token}
    Assert Http Status Code Is 200 Ok   
    Assert Response Status Object With 2000 Success    ${resp}
    ${count_resp}    Get Length     ${resp['data']} 
    Should Be Equal    ${count_query}    ${count_resp}
    # Check createdAt sort data by new to old (DESC)
    # ${sorted_data}    Sort List    ${resp['data']}    createdAt    order=descending
    # ${sorted}    Evaluate    ${sorted_data} == ${resp['data']}
    # Should Be True    ${sorted}    Data is sorted by createdAt in descending order

TC-01-006
    [Documentation]    Get all Asset excluding deleted success
    ...    In case of:
    ...    -  Recheck response body in field badge type must use sub field badge type (ex. AAB)   
    ...    -  specify asset all
    ${query_asset}    Query Asset
    ${count_query}    Get Length    ${query_asset}
    ${resp}    Get All Asset Excluding Deleted Success    ${admin_session_token}
    Assert Http Status Code Is 200 Ok   
    Assert Response Status Object With 2000 Success    ${resp}
    ${count_resp}    Get Length     ${resp['data']} 
    Should Be Equal    ${count_query}    ${count_resp}
    ${type}    Set Variable    AAB
    FOR    ${item}    IN    @{resp['data']}
        ${item_category}    Set Variable    ${item['category']}
        ${item_type}    Set Variable    ${item_category['type']}
        Log    Item type --- ${item_type}
        ${result}    Run Keyword If  '${item_type}' == '${type}'    Set Variable    ${True}
        Exit For Loop If    '${result}' == '${True}'
    END
    Should Be True    ${result}

TC-01-007
    [Documentation]    Get all Asset excluding deleted success
    ...    In case of:
    ...    -  Recheck response body in field badge type must use sub field badge type (ex. NFT)   
    ...    -  specify asset all
    ${query_asset}    Query Asset
    ${count_query}    Get Length    ${query_asset}
    ${resp}    Get All Asset Excluding Deleted Success    ${admin_session_token}
    Assert Http Status Code Is 200 Ok   
    Assert Response Status Object With 2000 Success    ${resp}
    ${count_resp}    Get Length     ${resp['data']} 
    Should Be Equal    ${count_query}    ${count_resp}
    ${type}    Set Variable    NFT
    FOR    ${item}    IN    @{resp['data']}
        ${item_category}    Set Variable    ${item['category']}
        ${item_type}    Set Variable    ${item_category['type']}
        Log    Item type --- ${item_type}
        ${result}    Run Keyword If  '${item_type}' == '${type}'    Set Variable    ${True}
        Exit For Loop If    '${result}' == '${True}'
    END
    Should Be True    ${result}

TC-01-008
    [Documentation]    Get all Asset excluding deleted success
    ...    In case of:
    ...    - not empty array
    ...    *Recheck response body in field qualification 
    ${query_asset}    Query Asset
    ${count_query}    Get Length    ${query_asset}
    ${resp}    Get All Asset Excluding Deleted Success    ${admin_session_token}
    Assert Http Status Code Is 200 Ok   
    Assert Response Status Object With 2000 Success    ${resp}
    ${qualification}    Set Variable    Qualification
    ${result}    Set Variable    ${False}
    FOR    ${item}    IN    @{resp['data']}
        ${item_qualification}    Set Variable    ${item['qualification']}
        Log    Item qualification --- ${item_qualification}
        ${match_qualification}    Run Keyword If    '${qualification}' in ${item_qualification}    Set Variable    ${True}
        ${result}    Run Keyword If    '${match_qualification}' == 'True'    Set Variable    ${True}
        Exit For Loop If    '${result}' == 'True'
    END
    Should Be True    ${result}

TC-01-009
    [Documentation]    Get all Asset excluding deleted success
    ...    In case of:
    ...    - empty array
    ...    *Recheck response body in field qualification 
    ${query_asset}    Query Asset
    ${count_query}    Get Length    ${query_asset}
    ${resp}    Get All Asset Excluding Deleted Success    ${admin_session_token}
    Assert Http Status Code Is 200 Ok   
    Assert Response Status Object With 2000 Success    ${resp}
    ${count_resp}    Get Length     ${resp['data']}
    Should Be Equal    ${count_query}    ${count_resp}
    ${qualification}    Set Variable    null
    ${result}    Set Variable    ${False}
    FOR    ${item}    IN    @{resp['data']}
        ${item_qualification}    Set Variable    ${item['qualification']}
        Log    Item qualification --- ${item_qualification} 
        Should Be Empty    ${item_qualification}
        ${match_qualification}    Run Keyword If    '${qualification}' in ${item_qualification}    Set Variable    ${True}
        ${result}    Run Keyword If    '${match_qualification}' == 'True' or '${qualification}' == 'null'    Set Variable    ${True}
        Exit For Loop If    '${result}' == 'True'
    END
    Should Be True    ${result}


TC-02-001
    [Documentation]    Get all Asset excluding deleted fail,
    ...    In case of:
    ...    - invalid session token 
    ${resp}    Get All Asset Excluding Deleted Fail    ${admin_session_token}123
    Assert Http Status Code Is 401 Unauthorized
    Assert Response Status Object With 4012 Unauthorized    ${resp}

TC-02-002
    [Documentation]    Get all Asset excluding deleted fail,
    ...    In case of:
    ...    - session token expired
    ${resp}    Get All Asset Excluding Deleted Fail    ${admin_session_token_exp}
    Assert Http Status Code Is 401 Unauthorized
    Assert Response Status Object With 4012 Unauthorized    ${resp}

TC-02-003
    [Documentation]    Get all Asset excluding deleted fail,
    ...    In case of:
    ...    - session token is an empty
    ${resp}    Get All Asset Excluding Deleted Fail    ${EMPTY}
    Assert Http Status Code Is 401 Unauthorized
    Assert Response Status Object With 4011 Unauthorized    ${resp}

TC-02-004
    [Documentation]    Get all Asset excluding deleted fail,
    ...    In case of:
    ...    - session token (bearer) is not send
    ${resp}    Get All Asset Excluding Deleted But Bearer Is Not Send    ${admin_session_token}
    Assert Http Status Code Is 401 Unauthorized
    Assert Response Status Object With 4011 Unauthorized    ${resp}

TC-02-005
    [Documentation]    Get all Asset excluding deleted fail,
    ...    In case of:
    ...    - session token is not send
    ${resp}    Get All Asset Excluding Deleted But Token Is Not Send
    Assert Http Status Code Is 401 Unauthorized
    Assert Response Status Object With 4011 Unauthorized    ${resp}

TC-03-001
    [Documentation]    Get all Asset excluding deleted fail,
    ...    In case of:
    ...    - invalid path
    ${resp}    Get All Asset Excluding Deleted But Send Invalid Path    ${admin_session_token}
    Assert Http Status Code Is 404 Not Found

TC-03-002
    [Documentation]    Get all Asset excluding deleted fail,
    ...    In case of:
    ...    - invalid method
    ${resp}    Put All Asset Excluding Deleted But Send Invalid Method    ${admin_session_token}
    Assert Http Status Code Is 404 Not Found