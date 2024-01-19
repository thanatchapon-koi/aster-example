*** Settings ***
Resource    ${CURDIR}/../../resources/imports.robot
Resource    ${CURDIR}/../../resources/testdata/common_configs.robot


*** Keywords ***

Create Header Object
    [Arguments]    ${token}    ${recaptcha_token}
    ${headers}    Create Dictionary    Content-Type=application/json
    Run Keyword If    '${token}' != '*REMOVE*'    Set To Dictionary    ${headers}    Authorization=Bearer ${token}
    Run Keyword If    '${recaptcha_token}' != '*REMOVE*'    Set To Dictionary    ${headers}    access-token=${recaptcha_token}
    [Return]    ${headers}

Create Header With Session Token and Recapcha Token
    [Arguments]    ${recaptcha_token}    
    &{headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${session_token}    Recaptcha-Token=${recaptcha_token}
    [Return]    ${headers}

Create Header With Recapcha Token
    [Arguments]    ${recaptcha_token}
    &{headers}=    Create Dictionary    Content-Type=application/json    Recaptcha-Token=${recaptcha_token}
    [Return]    ${headers}


Get User Info
    [Documentation]    Get User Information
    [Arguments]    ${recaptcha_token}    ${token}
    &{headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${token}    Recaptcha-Token=${recaptcha_token}
    ${resp}=    GET    ${aster_api_url_SIT}/registration-service/v1/user    headers=${headers}
    Log    ${resp.text}
    [Return]    ${resp}


Check exist address
    [Documentation]    Check exist address
    [Arguments]    ${recaptcha_token}    ${token}
    &{headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${token}    Recaptcha-Token=${recaptcha_token}
    ${resp}=    GET    ${aster_api_url_SIT}/registration-service/v1/user/${wallet_id}    headers=${headers}    expected_status=any
    Log    ${resp.text}
    [Return]    ${resp}

Get nonce
    [Documentation]    Get nonce
    [Arguments]    ${recaptcha_token}
    &{headers}=    Create Dictionary    Content-Type=application/json    Recaptcha-Token=${recaptcha_token}
    ${resp}=    GET    ${aster_api_url_SIT}/authentication-service/v1/authen/get-nonce    headers=${headers}    expected_status=any
    Log    ${resp.text}
    [Return]    ${resp}
    

GET Prediction History
    [Documentation]    GET Prediction History
    [Arguments]    ${recaptcha_token}    ${token}    ${game_id}
    &{headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${token}    Recaptcha-Token=${recaptcha_token}
    ${resp}=    GET    ${aster_api_url_SIT}/gamification-service/v1/game/prediction/${game_id}    headers=${headers}    expected_status=any
    Log    ${resp.text}
    [Return]    ${resp}


GET Redeem History
    [Documentation]    GET Prediction History
    [Arguments]    ${recaptcha_token}    ${token}
    &{headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${token}    Recaptcha-Token=${recaptcha_token}
    ${resp}=    GET    ${aster_api_url_SIT}/gamification-service/v1/reward/history    headers=${headers}    expected_status=any
    Log    ${resp.text}
    [Return]    ${resp}


Request Faucet
    [Documentation]     Request Faucet
    [Arguments]    ${recaptcha_token}    ${token}
    &{headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${token}    Recaptcha-Token=${recaptcha_token}
    ${resp}=    POST    ${aster_api_url_SIT}/faucet-service/v1/faucet/request    headers=${headers}    expected_status=any
    Log    ${resp.text}
    [Return]    ${resp}


Get Campaign List
    [Documentation]    Get Campaign List All
    [Arguments]    ${recaptcha_token}    ${token}
    &{headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${token}    Recaptcha-Token=${recaptcha_token}
    ${resp}=    GET    ${aster_api_url_SIT}/gamification-service/v1/campaign/list    headers=${headers}    expected_status=any
    Log    ${resp.text}
    [Return]    ${resp}


Get Campaign Detail
    [Documentation]    Get Campaign Detail
    [Arguments]    ${recaptcha_token}    ${token}    ${campaign_id}
    &{headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${token}    Recaptcha-Token=${recaptcha_token}
    ${resp}=    GET    ${aster_api_url_SIT}/gamification-service/v1/campaign/detail/${campaign_id}     headers=${headers}    expected_status=any
    Log    ${resp.text}
    [Return]    ${resp}



#เดี๋ยวมาเช็คอีกรอบว่าจะใช้ Arguments แบบไหน
Edit User Info
    [Documentation]    Put Edit User Info
    [Arguments]    ${recaptcha_token}    ${token}    ${displayName}    ${teamId}    ${roleId}    ${Bio}   
    &{headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${token}    Recaptcha-Token=${recaptcha_token}
    ${team_Id}    Convert To Integer    ${teamId}
    ${role_Id}    Convert To Integer    ${roleId}
    &{Body}=    Create Dictionary    displayName=${displayName}    teamId=${team_Id}    roleId=${roleId}    Bio=${Bio} 
    ${Json_Body}=    json.Dumps    ${Body}
    ${resp}=    PUT    ${aster_api_url_SIT}/registration-service/v1/user     headers=${headers}    data=${Json_Body}    expected_status=any
    Log    ${resp.text}
    [Return]    ${resp}



Get User Team and Role
    [Documentation]    Get User Team and Role
    [Arguments]    ${recaptcha_token}    ${token}
    &{headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${token}    Recaptcha-Token=${recaptcha_token}
    ${resp}=    GET    ${aster_api_url_SIT}/registration-service/v1/user/team-role     headers=${headers}    expected_status=any
    Log    ${resp.text}
    [Return]    ${resp}


Upload picture profile
    [Documentation]    Upload picture profile
    [Arguments]    ${recaptcha_token}    ${token}
    #${file_1}=    Get File For Streaming Upload    ${img_path}
    ${file}=    GET FILE FOR STREAMING UPLOAD    ${CURDIR}/../../resources/testdata/imgtest.png
    &{files}=    CREATE DICTIONARY    picture[]    ${file}
    #${data}=   Create Dictionary  picture=@=${img_path}
    #${data}=    Evaluate    {'picture': str(${data}).replace("'",'"'))
    &{headers}=    Create Dictionary    Authorization=Bearer ${token}    Recaptcha-Token=${recaptcha_token}
    ${resp}=    Post    ${aster_api_url_SIT}/registration-service/v1/user/picture     headers=${headers}    files=&{files}
    Log    ${resp.text}
    [Return]    ${resp}


Upload picture profile2
    [Arguments]    ${recaptcha_token}    ${token}
    ${command}    Set Variable    curl -X '[POST]' '${aster_api_url_SIT}/registration-service/v1/user/picture' -H 'Recaptcha-Token: ${recaptcha_token}' -H 'Authorization: Barear ${token}' -H 'Content-Type: multipart/form-data' --form 'picture=@"${CURDIR}/../../resources/testdata/Test.png"'
    ${result}    Run Process    ${command}    shell=True
