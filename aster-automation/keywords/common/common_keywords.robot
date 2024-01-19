*** Settings ***
Library    SeleniumLibrary
Resource    ${CURDIR}/../../resources/WebElement/generate_recaptcha_page.robot
Resource    ${CURDIR}/../../resources/api/all_api_backoffice.robot
Resource    ${CURDIR}/../../resources/api/all_api_webaster.robot
Resource    ${CURDIR}/../../resources/testdata/common_configs.robot
Resource    ${CURDIR}/../../keywords/api/assert_response.robot
Resource    ${CURDIR}/../../keywords/api/http_status_code.robot
Resource    ${CURDIR}/../../resources/database.robot


*** Keywords ***

#open website keywords
Open Aster Website Regular
    Open Browser    ${aster_web_url}    chrome    options=add_argument("--ignore-certificate-errors")
    Set Window Size    1920    1080
    Title Should Be    ${aster_title}   

Open Aster Website Headless
    Open Browser    ${aster_web_url}    headlesschrome
    Title Should Be    ${aster_title} 

Get Recaptcha Token
    Go to   ${aster_web_url}${recaptcha_token_page}
    Page Should Contain    Get Recaptcha Token
    Page Should Contain Button    ${generate_recaptcha_token_btn}
    Click Element    xpath=${generate_recaptcha_token_btn}
    sleep    10s
    Wait Until Page Contains Element     xpath=${copy_recaptcha_token_btn}
    ${recaptcha_token}    Get Text    xpath=${recaptcha_text}
    [Return]    ${recaptcha_token}
    sleep     5s
    Close All Browsers

#database keywords
DB_CONNECT
    Connect To Database    psycopg2    ${DBName}    ${DBUser}    ${DBPass}    ${DBHost}    ${DBPort}

DB_CLOSE
    Disconnect From Database

#check data type keywords
Check Type
    [Arguments]    ${object}
    [Documentation]    Checks if the ${object} is INTEGER, NUMBER or STRING
    Return From Keyword If    not "${object}"    NONE
    ${result}    ${value}=    Run Keyword And Ignore Error    Convert To Number    ${object}
    ${isnumber}=    Run Keyword And Return Status    Should Be Equal As Strings    ${object}    ${value}
    ${result}    ${value}=    Run Keyword And Ignore Error    Convert To Integer    ${object}
    ${isinteger}=    Run Keyword And Return Status    Should Be Equal As Strings    ${object}    ${value}
    Return From Keyword If    ${isnumber}    NUMBER
    Return From Keyword If    ${isinteger}    INTEGER
    Return From Keyword    STRING

Verify Types
    [Arguments]    ${resp}
    [Documentation]    format: ${var1}    Verify Types    ${resp['data'][0]['fields_name']}
    ${result}=    Check Type    ${resp}
    Log    Item ${resp} is ${result}
    [return]    ${result}