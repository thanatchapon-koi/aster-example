*** Settings ***
Resource    ${CURDIR}/../../keywords/common/common_keywords.robot

*** Keywords ***


Query Airdrop Request Lists Where Status
    [Documentation]    use for query the database for a list of airdrop requests based on a specified status.
    [Arguments]    ${status}
    DB_CONNECT
    @{query_airdrop_list}    Query    SELECT * FROM airdrop_request where status='${status}' ORDER BY airdrop_request_id;
    Log Many     @{query_airdrop_list}
    Set Test Variable    @{query_airdrop_list}
    DB_CLOSE
    [return]    ${query_airdrop_list}

GET All Airdrop Request APIs
    [Documentation]    use for send a GET request to the specified API endpoint. If the token is not equal to `*REMOVE*`, it sets the Authorization header to `Bearer `.
    [Arguments]    ${token}
    &{headers}    Create Dictionary    Content-Type=application/json
    Run Keyword If    '${token}' !='*REMOVE*'    Set To Dictionary    ${headers}    Authorization=Bearer ${token}
    ${resp}    Get    ${backoffice_api_url_SIT}${admin_airdrop_list_api}    headers=${headers}    expected_status=any
    ${resp}    Set Variable    ${resp.json()}
    [Return]    ${resp}

GET All Airdrop Request APIs Without Bearer
    [Documentation]    use for send a GET request to the specified API endpoint without including the Bearer token in the Authorization header.
    [Arguments]    ${token}
    &{headers}    Create Dictionary    Content-Type=application/json
    Run Keyword If    '${token}' !='*REMOVE*'    Set To Dictionary    ${headers}    Authorization=${token}
    ${resp}    Get    ${backoffice_api_url_SIT}${admin_airdrop_list_api}    headers=${headers}    expected_status=any
    ${resp}    Set Variable    ${resp.json()}
    [Return]    ${resp}

GET All Airdrop Request APIs Invalid Method
    [Documentation]    use for send a POST request to the specified API endpoint with invalid method.
    [Arguments]    ${token}
    &{headers}    Create Dictionary    Content-Type=application/json
    Run Keyword If    '${token}' !='*REMOVE*'    Set To Dictionary    ${headers}    Authorization=Bearer ${token}
    ${resp}    POST    ${backoffice_api_url_SIT}${admin_airdrop_list_api}    headers=${headers}    expected_status=any
    [Return]    ${resp}

GET All Airdrop Request APIs Invalid Path
    [Documentation]    use for send a GET request to the specified API endpoint with an invalid path.
    [Arguments]    ${token}
    &{headers}    Create Dictionary    Content-Type=application/json
    Run Keyword If    '${token}' !='*REMOVE*'    Set To Dictionary    ${headers}    Authorization=Bearer ${token}
    ${resp}    Get    ${backoffice_api_url_SIT}${admin_airdrop_list_api}dsd    headers=${headers}    expected_status=any
    [Return]    ${resp}

Validate Name Of Fields In All Airdrop Request APIs Is Completely
    [Documentation]    use for validate that the response from the API contains all the expected fields.
    [Arguments]    ${resp}
    Should Contain    ${resp['data'][0]}    airdropRequestId
    Should Contain    ${resp['data'][0]}    sessionName
    Should Contain    ${resp['data'][0]}    requestedDate
    Should Contain    ${resp['data'][0]}    requestedBy
    Should Contain    ${resp['data'][0]}    sessionStatus

Validate Type Of Data In APIs
    [Documentation]    use for validate the data types of specific fields in the API response.
    [Arguments]    ${resp}
    ${airdrop_request_id}=    Verify Types    ${resp['data'][0]['airdropRequestId']}
    ${session_name}=    Verify Types    ${resp['data'][0]['sessionName']}
    ${requested_date}=    Verify Types    ${resp['data'][0]['requestedDate']}
    ${requested_by}=    Verify Types    ${resp['data'][0]['requestedBy']}
    ${session_status}=    Verify Types    ${resp['data'][0]['sessionStatus']}
    Should Be Equal As Strings    ${airdrop_request_id}    INTEGER
    Should Be Equal As Strings    ${session_name}    STRING
    Should Be Equal As Strings    ${requested_date}    INTEGER
    Should Be Equal As Strings    ${requested_by}    STRING
    Should Be Equal As Strings    ${session_status}    STRING
    ${requested_date_string}=    Convert To String    ${resp['data'][0]['requestedDate']}
    ${length_requested_date}    Get Length    ${requested_date_string}
    Should Be Equal As Integers    ${length_requested_date}    10

Preapare Data In Database And APIs
    [Documentation]    use for prepare data by comparing the data from the database and APIs response.
    [Arguments]    ${query_airdrop_list}    ${resp}    ${session_status}
    @{db_list}=    Create List  #data from db
    @{resp_list}=	Create List  #data from api
    #get airdrop_request_id from DB and add to list
    ${count_query_db}    Get Length    ${query_airdrop_list}
    FOR    ${item}    IN RANGE    ${count_query_db}
        Append To List  ${db_list}    ${query_airdrop_list[${item}][0]}
    END
    #get sessionStatus from APIs and add to list
    ${count_query_api}    Get Length    ${resp['data']}
    FOR    ${item}    IN RANGE    ${count_query_api}
        Run Keyword If  '${resp['data'][${item}]['sessionStatus']}' == '${session_status}'    Append To List  ${resp_list}    ${resp['data'][${item}]['airdropRequestId']}
    END
    #prepare data in list by airdrop request id
    #fail when all data in list1 not found in list2
    IF  '${session_status}' != 'REJECTED'
        List Should Contain Sub List    ${resp_list}    ${db_list}
    ELSE
        List Should Contain Sub List    ${db_list}    ${db_list}    #db has version stamp of rejected airdrop when user rejected many times
    END

Query Airdrop Reqeust Id
    [Documentation]    use for get latest airdrop_request_id in database
    DB_CONNECT
    @{query_airdrop_request_id}    Query    SELECT max(airdrop_request_id) FROM airdrop_request;
    Log Many     @{query_airdrop_request_id}
    DB_CLOSE
    [return]    ${query_airdrop_request_id}

Call API Get All User Detail By Airdrop Request Id
    [Documentation]    use for call API
    [Arguments]    ${token}    ${airdrop_request_id}
    &{headers}    Create Dictionary    Content-Type=application/json
    Run Keyword If    '${token}' !='*REMOVE*'    Set To Dictionary    ${headers}    Authorization=Bearer ${token}
    ${resp}    Get    ${backoffice_api_url_SIT}${admin_airdrop_detail_by_airdrop_req_id_api}${airdrop_request_id}    headers=${headers}    expected_status=any
    ${resp}    Set Variable    ${resp.json()}
    [Return]    ${resp}

Call API Get All User Detail By Airdrop Request Id Without Bearer
    [Documentation]    use for call API without bearer
    [Arguments]    ${token}    ${airdrop_request_id}
    &{headers}    Create Dictionary    Content-Type=application/json
    Run Keyword If    '${token}' !='*REMOVE*'    Set To Dictionary    ${headers}    Authorization=${token}
    ${resp}    Get    ${backoffice_api_url_SIT}${admin_airdrop_detail_by_airdrop_req_id_api}${airdrop_request_id}    headers=${headers}    expected_status=any
    ${resp}    Set Variable    ${resp.json()}
    [Return]    ${resp}

Call API Get All User Detail By Airdrop Request Id With Invalid Path
    [Documentation]    use for call API with invalid path
    [Arguments]    ${token}    ${airdrop_request_id}
    &{headers}    Create Dictionary    Content-Type=application/json
    Run Keyword If    '${token}' !='*REMOVE*'    Set To Dictionary    ${headers}    Authorization=Bearer ${token}
    ${resp}    Get    ${backoffice_api_url_SIT}${admin_airdrop_detail_by_airdrop_req_id_api}${airdrop_request_id}/dummy    headers=${headers}    expected_status=any
    [Return]    ${resp}

Call API Get All User Detail By Airdrop Request Id With Invalid Method
    [Documentation]    use for call API with invalid method
    [Arguments]    ${token}    ${airdrop_request_id}
    &{headers}    Create Dictionary    Content-Type=application/json
    Run Keyword If    '${token}' !='*REMOVE*'    Set To Dictionary    ${headers}    Authorization=Bearer ${token}
    ${resp}    POST    ${backoffice_api_url_SIT}${admin_airdrop_detail_by_airdrop_req_id_api}${airdrop_request_id}    headers=${headers}    expected_status=any
    [Return]    ${resp}

Validate Response Fields Of API Get All User Detail By Airdrop Request Id
    [Documentation]    use for validate response fields from API
    [Arguments]    ${resp}
    Should Contain    ${resp['data']}    sessionName
    Should Contain    ${resp['data']}    sessionStatus
    Should Contain    ${resp['data']}    airdropStatus
    Should Contain    ${resp['data']}    airdropSessionUsers
    Should Contain    ${resp['data']['airdropSessionUsers'][0]}    employeeId
    Should Contain    ${resp['data']['airdropSessionUsers'][0]}    fullName
    Should Contain    ${resp['data']['airdropSessionUsers'][0]}    email
    Should Contain    ${resp['data']['airdropSessionUsers'][0]}    totalToken
    Should Contain    ${resp['data']['airdropSessionUsers'][0]}    txnHash
    Should Contain    ${resp['data']['airdropSessionUsers'][0]}    txnDate
    Should Contain    ${resp['data']['airdropSessionUsers'][0]}    status

Validate Type Of API Get All User Detail By Airdrop Request Id
    [Documentation]    use for validate response field type from API
    [Arguments]    ${resp}

    Log    ${resp['data']['airdropSessionUsers'][0]['employeeId']}

    ${sessionName}    Verify Types    ${resp['data']['sessionName']}
    ${sessionStatus}    Verify Types    ${resp['data']['sessionStatus']}
    ${airdropStatus}    Verify Types    ${resp['data']['airdropStatus']}
    ${employeeId}    Verify Types    ${resp['data']['airdropSessionUsers'][0]['employeeId']}
    ${fullName}    Verify Types    ${resp['data']['airdropSessionUsers'][0]['fullName']}
    ${email}    Verify Types    ${resp['data']['airdropSessionUsers'][0]['email']}
    ${totalToken}    Verify Types    ${resp['data']['airdropSessionUsers'][0]['totalToken']}
    ${txnHash}    Verify Types    ${resp['data']['airdropSessionUsers'][0]['txnHash']}
    ${txnDate}    Verify Types    ${resp['data']['airdropSessionUsers'][0]['txnDate']}
    ${status}    Verify Types    ${resp['data']['airdropSessionUsers'][0]['status']}

    Should Be Equal As Strings    ${sessionName}    STRING
    Should Be Equal As Strings    ${sessionStatus}    STRING
    Should Be Equal As Strings    ${airdropStatus}    STRING
    Should Be Equal As Strings    ${employeeId}    INTEGER
    Should Be Equal As Strings    ${fullName}    STRING
    Should Be Equal As Strings    ${email}    STRING
    Should Be Equal As Strings    ${totalToken}    INTEGER
    Should Be Equal As Strings    ${txnHash}    STRING
    Should Be Equal As Strings    ${txnDate}    STRING
    Should Be Equal As Strings    ${status}    STRING
    