*** Settings ***
Resource    ${CURDIR}/../../resources/imports.robot
Resource    ${CURDIR}/../../keywords/common/common_keywords.robot
Resource    ${CURDIR}/../../keywords/api/request_method.robot
#Resource    ${CURDIR}/../../keywords/api/assert_response.robot

Test Setup    Open Aster Website Regular

*** Test Cases ***

Get User Info
    [Documentation]    Test Scenario get user info
    ${recaptcha_token}    Get Recaptcha Token
    ${resp}    Get User Info    ${recaptcha_token}    ${session_token}
    Log to console    ${resp.status_code}
    Log to console    ${resp.text}


Check Exist Address
    [Documentation]    Test Check Exist Address
    ${recaptcha_token}    Get Recaptcha Token
    Check Exist Address    ${recaptcha_token}     ${session_token}

Get Nonce
    [Documentation]    Test GetNonce
    ${recaptcha_token}    Get Recaptcha Token
    Get Nonce   ${recaptcha_token}    


GET Prediction History
    [Documentation]    Test GET Prediction History
    ${recaptcha_token}    Get Recaptcha Token
    GET Prediction History    ${recaptcha_token}     ${session_token}    6



GET Redeem History
    [Documentation]    Test GET Redeem History
    ${recaptcha_token}    Get Recaptcha Token
    GET Redeem History    ${recaptcha_token}     ${session_token}



Request Faucet
    [Documentation]    Test Request Faucet
    ${recaptcha_token}    Get Recaptcha Token
    Request Faucet   ${recaptcha_token}     ${session_token}



Get Campaign List
    [Documentation]    Test Get Campaign List
    ${recaptcha_token}    Get Recaptcha Token
    Get Campaign List   ${recaptcha_token}     ${session_token}



Get Campaign Detail
    [Documentation]    Test Get Campaign List
    ${recaptcha_token}    Get Recaptcha Token
    Get Campaign Detail   ${recaptcha_token}     ${session_token}    1

Edit User Info
    [Documentation]    Test Get Campaign List
    ${recaptcha_token}    Get Recaptcha Token
    Edit User Info   ${recaptcha_token}     ${session_token}    Yo who are you    2    8     Yo i dont know what i say


Get User Team and Role
    [Documentation]    Test Get User Team and Role
    ${recaptcha_token}    Get Recaptcha Token
    Get User Team and Role   ${recaptcha_token}     ${session_token}

Upload picture profile
    [Documentation]    Test Upload picture profile
    ${recaptcha_token}    Get Recaptcha Token
    Upload picture profile   ${recaptcha_token}     ${session_token}   

POST Upload Profile Picture
    [Documentation]    Test Scenario Upload Profile Picture
    ${recaptcha_token}    Get Recaptcha Token
    ${resp}    Upload picture profile   ${recaptcha_token}    ${session_token}
    Log to console    ${resp.status_code}
    Log to console    ${resp.text}
