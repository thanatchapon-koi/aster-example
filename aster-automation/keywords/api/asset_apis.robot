*** Settings ***
Resource    ${CURDIR}/../../resources/imports.robot
Resource    ${CURDIR}/../../resources/testdata/common_configs.robot
Resource    ${CURDIR}/../../keywords/common/common_keywords.robot


*** Keywords ***

# GET Show All Whitelist User Success
#     [Documentation]    Get all assets group success
#     [Arguments]    ${token}    ${assetId}
#     ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${token}    
#     ${resp}=    GET    ${backoffice_api_url_SIT}/admin-service/v1/assets/${assetId}/whitelist    headers=${headers}    expected_status=any
#     ${resp}=    Set Variable    ${resp.json()}
#     [Return]    ${resp}

GET Show Whitelist User Success
    [Documentation]    Get all assets group success
    [Arguments]    ${token}    ${assetId}   
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${token}    
    ${resp}=    GET    ${backoffice_api_url_SIT}/admin-service/v1/assets/${assetId}/whitelist    headers=${headers}    expected_status=any
    ${resp}=    Set Variable    ${resp.json()}
    [Return]    ${resp} 

GET Show Whitelist User Failed
    [Documentation]    GET show whitelist user Failed
    [Arguments]    ${token}    ${assetId}
    &{headers}    Create Dictionary    Content-Type=application/json    
    Run Keyword If    '${token}' !='*REMOVE*'    Set To Dictionary    ${headers}    Authorization=Bearer ${token}    
    ${resp}    Get    ${backoffice_api_url_SIT}/admin-service/v1/assets/${assetId}/whitelist    headers=${headers}    expected_status=any
    ${resp}    Set Variable    ${resp.json()}
    [Return]    ${resp}

Get Event But Bearer Is Not Send
    [Documentation]    GET show whitelist user Failed
    [Arguments]    ${token}    ${assetId}
    &{headers}    Create Dictionary    Content-Type=application/json    Authorization=${token}
    ${resp}    Get    ${backoffice_api_url_SIT}/admin-service/v1/assets/${assetId}/whitelist    headers=${headers}    expected_status=any
    ${resp}    Set Variable    ${resp.json()}
    [Return]    ${resp}

Get Event But Send Invalid Path
    [Documentation]    GET show whitelist user Failed
    [Arguments]    ${token}    ${assetId}    ${invalid_path}
    &{headers}=    Create Dictionary    Content-Type=application/json  
    ${resp}     GET    ${backoffice_api_url_SIT}/admin-service/v1/assets/${assetId}/whitelist/${invalid_path}    headers=${headers}    expected_status=any
    ${resp}    Set Variable    ${resp}
    [Return]    ${resp}

Post Event But Send Invalid Method
    [Documentation]    GET show whitelist user Failed
    [Arguments]    ${token}    ${assetId}   
    &{headers}=    Create Dictionary    Content-Type=application/json  
    ${resp}     PUT    ${backoffice_api_url_SIT}/admin-service/v1/assets/${assetId}/whitelist    headers=${headers}    expected_status=any
    ${resp}    Set Variable    ${resp}
    [Return]    ${resp}

Query whitelist
    DB_CONNECT
    [Arguments]    ${assetId}
    @{query_whitelist}    Query    SELECT * FROM asset_whitelists WHERE asset_id='${assetId}' and deleted_at isnull;
    Log Many     @{query_whitelist}
    Set Test Variable    @{query_whitelist}
    DB_CLOSE
    [return]    ${query_whitelist}

# Validate Name Of Field Is Completely
#     [Documentation]    Name of field is completely
#     [Arguments]     ${resp_data}
#     Should Contain  ${resp_data}  id
#     Should Contain  ${resp_data}  name
#     Should Contain  ${resp_data}  image
#     Should Contain  ${resp_data}  tag
    # refId    refType    templateIndex



# Submit Upload Whitelist 

Post Submit Upload Whitelist
    [Documentation]    Post Submit Upload Whitelist Success
    [Arguments]    ${token}    ${assetId}    ${refId}    ${refType}    ${templateIndex}
    &{headers}=    Create Dictionary    Content-Type=application/json
    Run Keyword If    '${token}' !='*REMOVE*'    Set To Dictionary    ${headers}    Authorization=Bearer ${token}
    ${templateIndex}    Convert To Integer    ${templateIndex}
    &{whitelist}=    Create Dictionary
    Run Keyword If    '${refId}' !='*REMOVE*'    Set To Dictionary    ${whitelist}    refId=${refId}
    Run Keyword If    '${refType}' !='*REMOVE*'    Set To Dictionary    ${whitelist}    refType=${refType}
    Run Keyword If    '${templateIndex}' !='*REMOVE*'    Set To Dictionary    ${whitelist}    templateIndex=${templateIndex}
    @{whitelistdata}=    Create List    ${whitelist}
    &{body}=    Create Dictionary    
    Run Keyword If    ${whitelistData} !='*REMOVE*'    Set To Dictionary    ${body}    whitelistData=${whitelistdata}
    ${json_body}=    json.Dumps    ${body}
    ${resp}=    Post    ${backoffice_api_url_SIT}/admin-service/v1/assets/${assetId}/whitelist    headers=${headers}    data=${json_body}    expected_status=any
    ${resp}=    Set Variable    ${resp.json()}
    [Return]    ${resp}



Post Submit Upload Whitelist Mutilist
    [Documentation]    Post Submit Upload Whitelist Mutilist Success
    [Arguments]    ${token}    ${assetId}    ${refId}    ${refType}    ${templateIndex}    ${refId1}    ${refType1}    ${templateIndex1}
    &{headers}=    Create Dictionary    Content-Type=application/json
    Run Keyword If    '${token}' !='*REMOVE*'    Set To Dictionary    ${headers}    Authorization=Bearer ${token}
    ${templateIndex}    Convert To Integer    ${templateIndex}
    ${templateIndex1}    Convert To Integer    ${templateIndex1}
    &{whitelist}=    Create Dictionary
    Run Keyword If    '${refId}' !='*REMOVE*'    Set To Dictionary    ${whitelist}    refId=${refId}
    Run Keyword If    '${refType}' !='*REMOVE*'    Set To Dictionary    ${whitelist}    refType=${refType}
    Run Keyword If    '${templateIndex}' !='*REMOVE*'    Set To Dictionary    ${whitelist}    templateIndex=${templateIndex}
    &{whitelist1}=    Create Dictionary
    Run Keyword If    '${refId}' !='*REMOVE*'    Set To Dictionary    ${whitelist1}    refId=${refId1}
    Run Keyword If    '${refType}' !='*REMOVE*'    Set To Dictionary    ${whitelist1}    refType=${refType1}
    Run Keyword If    '${templateIndex}' !='*REMOVE*'    Set To Dictionary    ${whitelist1}    templateIndex=${templateIndex1}
    @{whitelistdata}=    Create List    ${whitelist}    ${whitelist1}
    &{body}=    Create Dictionary    
    Run Keyword If    ${whitelistData} !='*REMOVE*'    Set To Dictionary    ${body}    whitelistData=${whitelistdata}
    ${json_body}=    json.Dumps    ${body}
    ${resp}=    Post    ${backoffice_api_url_SIT}/admin-service/v1/assets/${assetId}/whitelist    headers=${headers}    data=${json_body}    expected_status=any
    ${resp}=    Set Variable    ${resp.json()}
    [Return]    ${resp}



Post Submit Upload Whitelist Invalid
    [Documentation]    Post Submit Upload Whitelist Fail
    [Arguments]    ${token}    ${assetId}    ${refId}    ${refType}    ${templateIndex}
    &{headers}=    Create Dictionary    Content-Type=application/json
    Run Keyword If    '${token}' !='*REMOVE*'    Set To Dictionary    ${headers}    Authorization=Bearer ${token}
    &{whitelist}=    Create Dictionary
    Run Keyword If    '${refId}' !='*REMOVE*'    Set To Dictionary    ${whitelist}    refId=${refId}
    Run Keyword If    '${refType}' !='*REMOVE*'    Set To Dictionary    ${whitelist}    refType=${refType}
    Run Keyword If    '${templateIndex}' !='*REMOVE*'    Set To Dictionary    ${whitelist}    templateIndex=${templateIndex}
    @{whitelistdata}=    Create List    ${whitelist}
    &{body}=    Create Dictionary    
    Run Keyword If    ${whitelistData} !='*REMOVE*'    Set To Dictionary    ${body}    whitelistData=${whitelistdata}
    ${json_body}=    json.Dumps    ${body}
    ${resp}=    Post    ${backoffice_api_url_SIT}/admin-service/v1/assets/${assetId}/whitelist    headers=${headers}    data=${json_body}    expected_status=any
    ${resp}=    Set Variable    ${resp.json()}
    [Return]    ${resp}




Post Submit Upload Whitelist Not Send Data
    [Documentation]    Post Submit Upload Whitelist Not Send Data
    [Arguments]    ${token}    ${assetId}
    &{headers}=    Create Dictionary    Content-Type=application/json
    Run Keyword If    '${token}' !='*REMOVE*'    Set To Dictionary    ${headers}    Authorization=Bearer ${token}   
    ${resp}=    Post    ${backoffice_api_url_SIT}/admin-service/v1/assets/${assetId}/whitelist    headers=${headers}    data=${EMPTY}    expected_status=any
    ${resp}=    Set Variable    ${resp.json()}
    [Return]    ${resp}



# DELETE whitelist user

Delete Whitelist User
    [Documentation]    Post Delete Whitelist User Success
    [Arguments]    ${token}    ${assetId}    ${whitelist_id}=0
    ${res}    GET Show Whitelist User Success    ${token}    ${assetId}
    ${whitelist_id}    Set Variable    ${res['data'][0]['id']}
    Set Test Variable    ${whitelist_id}
    &{headers}=    Create Dictionary    Content-Type=application/json
    Run Keyword If    '${token}' !='*REMOVE*'    Set To Dictionary    ${headers}    Authorization=Bearer ${token}
    ${resp}=    Delete    ${backoffice_api_url_SIT}/admin-service/v1/assets/${assetId}/whitelist/${whitelist_id}    headers=${headers}    expected_status=any
    ${resp}=    Set Variable    ${resp.json()}
    [Return]    ${resp}


Verify Delete Whitelist User DB
    [Documentation]    Verify Delete Whitelist User DB
    [Arguments]    ${whitelist_id}=${whitelist_id}
    DB_CONNECT
    @{query_whitelist}    Query    SELECT * FROM asset_whitelists WHERE id='${whitelist_id}' and deleted_at is not null;
    Log Many     @{query_whitelist}
    Set Test Variable    @{query_whitelist}
    DB_CLOSE
    ${count_query}    Get Length    ${query_whitelist}
    [return]    ${count_query}


Delete Whitelist User Invalid
    [Documentation]    Delete Whitelist User Invalid
    [Arguments]    ${token}    ${assetId}    ${whitelist_id}=${whitelist_id}
    &{headers}=    Create Dictionary    Content-Type=application/json
    Run Keyword If    '${token}' !='*REMOVE*'    Set To Dictionary    ${headers}    Authorization=Bearer ${token}
    ${resp}=    Delete    ${backoffice_api_url_SIT}/admin-service/v1/assets/${assetId}/whitelist/${whitelist_id}    headers=${headers}    expected_status=any
    ${resp}=    Set Variable    ${resp.json()}
    [Return]    ${resp}

    
Delete Whitelist User 404 page not found
    [Documentation]    Delete Whitelist User 404 page not found
    [Arguments]    ${token}    ${assetId}    ${whitelist_id}=${whitelist_id}
    &{headers}=    Create Dictionary    Content-Type=application/json
    Run Keyword If    '${token}' !='*REMOVE*'    Set To Dictionary    ${headers}    Authorization=Bearer ${token}
    ${resp}=    Delete    ${backoffice_api_url_SIT}/admin-service/v1/assets/${assetId}/whitelist/${whitelist_id}    headers=${headers}    expected_status=any
    [Return]    ${resp}


Delete Whitelist User Invalid Method
    [Documentation]    Delete Whitelist User Invalid
    [Arguments]    ${token}    ${assetId}    ${whitelist_id}=${whitelist_id}
    &{headers}=    Create Dictionary    Content-Type=application/json
    Run Keyword If    '${token}' !='*REMOVE*'    Set To Dictionary    ${headers}    Authorization=Bearer ${token}
    ${resp}=    Patch    ${backoffice_api_url_SIT}/admin-service/v1/assets/${assetId}/whitelist/${whitelist_id}    headers=${headers}    expected_status=any
    [Return]    ${resp}


# DELETE ASSET BY ID

Delete Asset By ID
    [Documentation]    Delete asset by id
    [Arguments]    ${token}    ${assetId}
    &{headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${token} 
    ${resp}=    Delete    ${backoffice_api_url_SIT}/admin-service/v1/assets/${assetId}    headers=${headers}    expected_status=any
    ${resp}=    Set Variable    ${resp.json()}
    [Return]    ${resp}

Verify Deleted Asset At DB
    [Documentation]    Verify Deleted Asset At DB
    [Arguments]    ${assetId}
    DB_CONNECT
    @{query_asset}    Query    SELECT * FROM assets WHERE asset_id='${assetId}' and deleted_date_time is not null;
    Log Many     @{query_asset}
    Set Test Variable    @{query_asset}
    DB_CLOSE

Delete Asset By ID But Bearer Is Not Send
    [Documentation]    GET all assets group fail
    [Arguments]    ${token}  ${assetId}
    &{headers}=    Create Dictionary    Content-Type=application/json  Authorization=${token}
    ${resp}=    Delete    ${backoffice_api_url_SIT}/admin-service/v1/assets/${assetId}    headers=${headers}    expected_status=any
    ${resp}=    Set Variable    ${resp.json()}
    [Return]    ${resp}
    
Delete Asset By ID But Token Is Not Send
    [Documentation]    GET all events fail
    &{headers}=    Create Dictionary    Content-Type=application/json  
    ${resp}=    Delete    ${backoffice_api_url_SIT}/admin-service/v1/assets/${assetId}   headers=${headers}    expected_status=any
    ${resp}=    Set Variable    ${resp.json()}
    [Return]    ${resp}

Delete Asset By ID But Send Invalid Path
    [Documentation]    Call API GET User Success
    [Arguments]    ${token}    ${assetId}    ${invalid_path}=Dummy
    &{headers}=    Create Dictionary    Content-Type=application/json  
    ${resp}=    Delete    ${backoffice_api_url_SIT}/admin-service/v1/assets/${invalid_path}/${assetId}   headers=${headers}    expected_status=any
    ${resp}    Set Variable    ${resp}
    [Return]    ${resp}

Delete Asset By ID But Send Invalid Method
    [Documentation]    Call API GET User Success
    [Arguments]    ${token}    ${assetId}
    &{headers}=    Create Dictionary    Content-Type=application/json  Authorization=${token}
    ${resp}=    POST    ${backoffice_api_url_SIT}/admin-service/v1/assets/${assetId}   headers=${headers}    expected_status=any
    ${resp}    Set Variable    ${resp}
    [Return]    ${resp}

Updated Asset At DB for Delete
    [Documentation]    Verify Deleted Asset At DB
    [Arguments]    ${assetId}
    DB_CONNECT
    ${update} =    Execute SQL String     UPDATE assets SET deleted_date_time = Null WHERE asset_id=${assetId};
    DB_CLOSE

 # Get All Asset Excluding Deleted

Query Asset
    DB_CONNECT
    @{query_asset}    Query    SELECT * FROM assets WHERE deleted_date_time IS NULL; 
    Log Many     @{query_asset}
    Set Test Variable    @{query_asset}
    DB_CLOSE
    [return]    ${query_asset}

Get All Asset Excluding Deleted Success
    [Documentation]    Get all asset excluding deleted success
    [Arguments]    ${token}
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${token}    
    ${resp}=    GET    ${backoffice_api_url_SIT}/admin-service/v1/assets/    headers=${headers}    expected_status=any
    ${resp}=    Set Variable    ${resp.json()}
    [Return]    ${resp}


Get All Asset Excluding Deleted fail permission
    [Documentation]    Get all asset excluding deleted success
    [Arguments]    ${token}
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${token}    
    ${resp}=    GET    ${backoffice_api_url_SIT}/admin-service/v1/assets/    headers=${headers}    expected_status=any
    ${resp}=    Set Variable    ${resp.json()}
    [Return]    ${resp}

Get All Asset Excluding Deleted Fail
    [Documentation]    GET all asset excluding deleted fail
    [Arguments]    ${token}
    &{headers}=    Create Dictionary    Content-Type=application/json  Authorization=Bearer ${token}
    ${resp}=    GET    ${backoffice_api_url_SIT}/admin-service/v1/assets/    headers=${headers}    expected_status=any
    ${resp}=    Set Variable    ${resp.json()}
    [Return]    ${resp}

Get All Asset Excluding Deleted But Bearer Is Not Send
    [Documentation]    GET all asset excluding deleted fail
    [Arguments]    ${token}
    &{headers}=    Create Dictionary    Content-Type=application/json  Authorization=${token}
    ${resp}=    GET    ${backoffice_api_url_SIT}/admin-service/v1/assets/    headers=${headers}    expected_status=any
    ${resp}=    Set Variable    ${resp.json()}
    [Return]    ${resp}

Get All Asset Excluding Deleted But Token Is Not Send
    [Documentation]    GET all asset excluding deleted fail
    &{headers}=    Create Dictionary    Content-Type=application/json  
    ${resp}=    GET    ${backoffice_api_url_SIT}/admin-service/v1/assets/    headers=${headers}    expected_status=any
    ${resp}=    Set Variable    ${resp.json()}
    [Return]    ${resp}

Get All Asset Excluding Deleted But Send Invalid Path
    [Documentation]    Get All Asset Excluding Deleted But Send Invalid Path
    [Arguments]    ${token}    
    &{headers}=    Create Dictionary    Content-Type=application/json  
    ${resp}     GET    ${backoffice_api_url_SIT}/admin-service/v1/assetss/    headers=${headers}    expected_status=any
    ${resp}    Set Variable    ${resp}
    [Return]    ${resp}

Put All Asset Excluding Deleted But Send Invalid Method
    [Documentation]    Put All Asset Excluding Deleted But Send Invalid Method
    [Arguments]    ${token}    
    &{headers}=    Create Dictionary    Content-Type=application/json  
    ${resp}     PUT    ${backoffice_api_url_SIT}/admin-service/v1/assets/    headers=${headers}    expected_status=any
    ${resp}    Set Variable    ${resp}
    [Return]    ${resp}

