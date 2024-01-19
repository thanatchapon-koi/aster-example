*** Settings ***
Resource    ${CURDIR}/../../keywords/common/common_keywords.robot


*** Keywords ***


Call API GET Backoffice User
    [Documentation]    Call API GET Backoffice User Success
    [Arguments]    ${token}
    &{headers}    Create Dictionary    Content-Type=application/json
    Run Keyword If    '${token}' !='*REMOVE*'    Set To Dictionary    ${headers}    Authorization=Bearer ${token}
    ${resp}    Get    ${backoffice_api_url_SIT}${admin_campaign_api}    headers=${headers}    expected_status=any
    ${resp}    Set Variable    ${resp.json()}
    [Return]    ${resp}  
    

Call API GET Backoffice User By Path 
    [Documentation]    Call API GET Backoffice User By Path
    [Arguments]    ${token}    ${path}
    &{headers}    Create Dictionary    Content-Type=application/json
    Run Keyword If    '${token}' !='*REMOVE*'    Set To Dictionary    ${headers}    Authorization=Bearer ${token}
    # ${even_id}    Convert To Integer    ${even_id}
    ${resp}    Get    ${backoffice_api_url_SIT}${admin_campaign_api}${path}    headers=${headers}    expected_status=any
    ${resp}    Set Variable    ${resp.json()}
    [Return]    ${resp}  
    

Call API GET Backoffice User Invalid
    [Documentation]    Call API GET Backoffice User Invalid Path
    [Arguments]    ${token}    ${path}
    &{headers}    Create Dictionary    Content-Type=application/json
    Run Keyword If    '${token}' !='*REMOVE*'    Set To Dictionary    ${headers}    Authorization=Bearer ${token}
    # ${even_id}    Convert To Integer    ${even_id}
    ${resp}    Get    ${backoffice_api_url_SIT}${admin_campaign_api}${path}    headers=${headers}    expected_status=any
    [Return]    ${resp}  
    

Call API GET Backoffice User Invalid Method
    [Documentation]    Call API GET Backoffice User Invalid Method
    [Arguments]    ${token}
    &{headers}    Create Dictionary    Content-Type=application/json
    Run Keyword If    '${token}' !='*REMOVE*'    Set To Dictionary    ${headers}    Authorization=Bearer ${token}
    # ${even_id}    Convert To Integer    ${even_id}
    ${resp}    Patch    ${backoffice_api_url_SIT}${admin_campaign_api}    headers=${headers}    expected_status=any
    [Return]    ${resp}  