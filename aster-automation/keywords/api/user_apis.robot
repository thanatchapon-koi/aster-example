*** Settings ***
Resource    ${CURDIR}/../../keywords/common/common_keywords.robot


*** Keywords ***

Create Admin User
    [Documentation]    creating an admin user by sending a POST request to the specified API endpoint. It takes in three arguments: token, email, and role_id.
    [Arguments]    ${token}    ${email}     ${role_id}
    &{headers}=    Create Dictionary    Content-Type=application/json
    Run Keyword If    '${token}' !='*REMOVE*'    Set To Dictionary    ${headers}    Authorization=Bearer ${token}
    ${role_id}    Convert To Integer    ${role_id}
    &{body}=    Create Dictionary    
    Run Keyword If    '${email}' !='*REMOVE*'    Set To Dictionary    ${body}    email=${email}
    Run Keyword If    '${role_id}'!='*REMOVE*'  Set To Dictionary    ${body}    roleId=${role_id}
    ${json_body}=    json.Dumps    ${body}
    ${resp}=    Post    ${backoffice_api_url_SIT}/admin-service/v1/user    headers=${headers}    data=${json_body}    expected_status=any
    ${resp}=    Set Variable    ${resp.json()}
    [Return]    ${resp}

Delete Admin User
    [Documentation]    deleting an admin user. It takes two arguments, token and email.
    [Arguments]    ${token}    ${email}=${email_test_userapis}
    DB_CONNECT
    sleep    3
    @{query_admin_user}    Query    SELECT user_id FROM backoffice_user WHERE email = '${email}'
    Log Many     @{query_admin_user}
    ${user_id} =    Set Variable    ${query_admin_user[0][0]}
    Set Test Variable    ${user_id}
    DB_CLOSE
    &{headers}=    Create Dictionary    Content-Type=application/json
    Run Keyword If    '${token}' !='*REMOVE*'    Set To Dictionary    ${headers}    Authorization=Bearer ${token}
    &{body}=    Create Dictionary
    Run Keyword If    '${user_id}' !='*REMOVE*'    Set To Dictionary    ${body}    userId=${user_id}
    ${json_body}=    json.Dumps    ${body}
    ${resp}=    Delete    ${backoffice_api_url_SIT}/admin-service/v1/user    headers=${headers}    data=${json_body}    expected_status=any
    ${resp}=    Set Variable    ${resp.json()}
    [Return]    ${resp}

Query Admin User
    [Documentation]    use for query admin user from the database. It takes an email as an argument and queries the `backoffice_user` table to fetch the name, email, and role_id of the user with the specified email.
    [Arguments]    ${email}
    DB_CONNECT
    @{query_admin_user}    Query    SELECT name, email, role_id FROM backoffice_user WHERE email = '${email}'
    Log Many     @{query_admin_user}
    Set Test Variable    @{query_admin_user}
    DB_CLOSE
    [return]    ${query_admin_user}

Verify Add Admin User
    [Documentation]    verifying the functionality of adding an admin user. It takes three arguments: name, email, and role_id.
    [Arguments]    ${name}    ${email}    ${role_id}
    Log Many      @{query_admin_User}[0]    # robotcode: ignore
    ${output} =    Set Variable    ${query_admin_user[0]}    # robotcode: ignore
    Should Be Equal As Strings     ${output}    ('${name}', '${email}', ${role_id})

Create Admin User Case Not Send RoleID
    [Documentation]    Create Admin User Case Not Send RoleID
    [Arguments]    ${token}    ${email}     ${role_id}
    &{headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${token}
    &{body}=    Create Dictionary    
    Run Keyword If    '${email}' !='*REMOVE*'    Set To Dictionary    ${body}    email=${email}
    Run Keyword If    '${role_id}' !='*REMOVE*'    Set To Dictionary    ${body}    roleId=${role_id}
    Run Keyword If    '${role_id}'=='*TEST*'    Set To Dictionary    ${body}    roleId=${role_id}
    ${json_body}=    json.Dumps    ${body}
    ${resp}=    Post    ${backoffice_api_url_SIT}/admin-service/v1/user    headers=${headers}    data=${json_body}    expected_status=any
    ${resp}=    Set Variable    ${resp.json()}
    [Return]    ${resp}

Create Admin User Invalid Method
    [Documentation]    Create Admin User Invalid Method
    [Arguments]    ${token}    ${email}     ${role_id}
    &{headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${token}
    ${role_id}    Convert To Integer    ${role_id}
    &{body}=    Create Dictionary    
    Run Keyword If    '${email}' !='*REMOVE*'    Set To Dictionary    ${body}    email=${email}
    Run Keyword If    '${role_id}'!='*REMOVE*'  Set To Dictionary    ${body}    roleId=${role_id}
    ${json_body}=    json.Dumps    ${body}
    ${resp}=    Patch    ${backoffice_api_url_SIT}/admin-service/v1/user    headers=${headers}    data=${json_body}    expected_status=any
    [Return]    ${resp}


Create Admin User Invalid Path
    [Documentation]    Create Admin User Invalid Path
    [Arguments]    ${token}    ${email}     ${role_id}
    &{headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${token}
    ${role_id}    Convert To Integer    ${role_id}
    &{body}=    Create Dictionary    
    Run Keyword If    '${email}' !='*REMOVE*'    Set To Dictionary    ${body}    email=${email}
    Run Keyword If    '${role_id}'!='*REMOVE*'  Set To Dictionary    ${body}    roleId=${role_id}
    ${json_body}=    json.Dumps    ${body}
    ${resp}=    Post    ${backoffice_api_url_SIT}/admin-service/v1/userssss   headers=${headers}    data=${json_body}    expected_status=any
    [Return]    ${resp}


Delete Admin User Case Invalid
    [Documentation]    Delete Admin User Case Invalid
    [Arguments]    ${token}    ${user_id}
    &{headers}=    Create Dictionary    Content-Type=application/json
    Run Keyword If    '${token}' !='*REMOVE*'    Set To Dictionary    ${headers}    Authorization=Bearer ${token}
    &{body}=    Create Dictionary
    Run Keyword If    '${user_id}' !='*REMOVE*'    Set To Dictionary    ${body}    userId=${user_id}
    ${json_body}=    json.Dumps    ${body}
    ${resp}=    Delete    ${backoffice_api_url_SIT}/admin-service/v1/user    headers=${headers}    data=${json_body}    expected_status=any
    ${resp}=    Set Variable    ${resp.json()}
    [Return]    ${resp}


Delete Admin User Case Path
    [Documentation]    Delete Admin User Case Path
    [Arguments]    ${token}    ${user_id}
    &{headers}=    Create Dictionary    Content-Type=application/json
    Run Keyword If    '${token}' !='*REMOVE*'    Set To Dictionary    ${headers}    Authorization=Bearer ${token}
    &{body}=    Create Dictionary
    Run Keyword If    '${user_id}' !='*REMOVE*'    Set To Dictionary    ${body}    userId=${user_id}
    ${json_body}=    json.Dumps    ${body}
    ${resp}=    Delete    ${backoffice_api_url_SIT}/admin-service/v1/userrrrrr    headers=${headers}    data=${json_body}    expected_status=any
    [Return]    ${resp}


Delete Admin User Invalid Method
    [Documentation]    Delete Admin User Case Path
    [Arguments]    ${token}    ${user_id}
    &{headers}=    Create Dictionary    Content-Type=application/json
    Run Keyword If    '${token}' !='*REMOVE*'    Set To Dictionary    ${headers}    Authorization=Bearer ${token}
    &{body}=    Create Dictionary
    Run Keyword If    '${user_id}' !='*REMOVE*'    Set To Dictionary    ${body}    userId=${user_id}
    ${json_body}=    json.Dumps    ${body}
    ${resp}=    Patch    ${backoffice_api_url_SIT}/admin-service/v1/userrrrrr    headers=${headers}    data=${json_body}    expected_status=any
    [Return]    ${resp}

Query Backoffice User
    DB_CONNECT
    @{query_backoffice_user}    Query    SELECT * FROM backoffice_user
    Log Many     @{query_backoffice_user}
    Set Test Variable    @{query_backoffice_user}
    DB_CLOSE
    [return]    ${query_backoffice_user}

Call API GET Backoffice User
    [Documentation]    Call API GET User Success
    [Arguments]    ${token}
    &{headers}    Create Dictionary    Content-Type=application/json
    Run Keyword If    '${token}' !='*REMOVE*'    Set To Dictionary    ${headers}    Authorization=Bearer ${token}
    ${resp}    Get    ${backoffice_api_url_SIT}${admin_user_management_api}    headers=${headers}    expected_status=any
    ${resp}    Set Variable    ${resp.json()}
    [Return]    ${resp}

Call API GET Backoffice User Invalid Path
    [Documentation]    calling an API GET request to the Backoffice User with an invalid path.
    [Arguments]    ${token}    ${invalid_path}=Dummy
    &{headers}    Create Dictionary    Content-Type=application/json
    Run Keyword If    '${token}' !='*REMOVE*'    Set To Dictionary    ${headers}    Authorization=Bearer ${token}
    ${resp}    Get    ${backoffice_api_url_SIT}${admin_user_management_api}${invalid_path}    headers=${headers}    expected_status=any
    ${resp}    Set Variable    ${resp}
    [Return]    ${resp}

Edit Admin User
    [Documentation]    use for edit the details of an admin user in a backoffice system.
    [Arguments]    ${token}    ${role_id}    ${email}=${email_test_userapis}
    DB_CONNECT
    sleep    3
    @{query_admin_user}    Query    SELECT user_id FROM backoffice_user WHERE email = '${email}'
    Log Many     @{query_admin_user}
    ${user_id} =    Set Variable    ${query_admin_user[0][0]}
    Set Test Variable    ${user_id}
    DB_CLOSE
    &{headers}=    Create Dictionary    Content-Type=application/json
    Run Keyword If    '${token}' !='*REMOVE*'    Set To Dictionary    ${headers}    Authorization=Bearer ${token}
    &{body}=    Create Dictionary
    ${role_id}    Convert To Integer    ${role_id}
    Run Keyword If    '${user_id}' !='*REMOVE*'    Set To Dictionary    ${body}    userId=${user_id}
    Run Keyword If    '${role_id}' !='*REMOVE*'    Set To Dictionary    ${body}    roleId=${role_id}
    ${json_body}=    json.Dumps    ${body}
    ${resp}=    Put    ${backoffice_api_url_SIT}/admin-service/v1/user    headers=${headers}    data=${json_body}    expected_status=any
    ${resp}=    Set Variable    ${resp.json()}
    [Return]    ${resp}

Edit Admin User Case Invalid
    [Documentation]    editing an admin user with invalid input. It takes three arguments:  token,  user_id, and  role_id.
    [Arguments]    ${token}    ${user_id}    ${role_id}
    &{headers}=    Create Dictionary    Content-Type=application/json
    Run Keyword If    '${token}' !='*REMOVE*'    Set To Dictionary    ${headers}    Authorization=Bearer ${token}
    ${role_id}    Convert To Integer    ${role_id}
    &{body}=    Create Dictionary
    Run Keyword If    '${user_id}' !='*REMOVE*'    Set To Dictionary    ${body}    userId=${user_id}
    Run Keyword If    '${role_id}}' !='*REMOVE*'    Set To Dictionary    ${body}    roleId=${role_id}
    ${json_body}=    json.Dumps    ${body}
    ${resp}=    Put    ${backoffice_api_url_SIT}/admin-service/v1/user    headers=${headers}    data=${json_body}    expected_status=any
    ${resp}=    Set Variable    ${resp.json()}
    [Return]    ${resp}  


Edit Admin User Case Invalid Roleid
    [Documentation]    editing an admin user with an invalid role_id.
    [Arguments]    ${token}    ${user_id}    ${role_id}
    &{headers}=    Create Dictionary    Content-Type=application/json
    Run Keyword If    '${token}' !='*REMOVE*'    Set To Dictionary    ${headers}    Authorization=Bearer ${token}
    &{body}=    Create Dictionary
    Run Keyword If    '${user_id}' !='*REMOVE*'    Set To Dictionary    ${body}    userId=${user_id}
    Run Keyword If    '${role_id}' !='*REMOVE*'    Set To Dictionary    ${body}    roleId=${role_id}
    ${json_body}=    json.Dumps    ${body}
    ${resp}=    Put    ${backoffice_api_url_SIT}/admin-service/v1/user    headers=${headers}    data=${json_body}    expected_status=any
    ${resp}=    Set Variable    ${resp.json()}
    [Return]    ${resp}  

Create Admin User Success
    ${resp}    Create Admin User    ${user_management_session_token}    ${email_test_userapis}    6
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}
    sleep    3
    Query Admin User    ${email_test_userapis}

Delete Admin User Success
    ${resp}    Delete Admin User     ${user_management_session_token}
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}


# -------- Search Speaker User APIs ---------
Call API GET Search Speaker User With Query
    [Documentation]    calls an API to search for a speaker user with the given parameters.
    [Arguments]    ${token}    ${data_query}
    &{headers}    Create Dictionary    Content-Type=application/json
    Run Keyword If    '${token}' !='*REMOVE*'    Set To Dictionary    ${headers}    Authorization=Bearer ${token}
    ${path}    Set Variable    ${backoffice_api_url_SIT}${admin_search_speaker_user_api}?query=${data_query}
    ${resp}    Get    ${path}    headers=${headers}    expected_status=any
    ${resp}    Set Variable    ${resp.json()}
    [Return]    ${resp}

Call API GET Search Speaker User Without Query
    [Documentation]    calls an API to search for a speaker user without parameters.
    [Arguments]    ${token}
    &{headers}    Create Dictionary    Content-Type=application/json
    Run Keyword If    '${token}' !='*REMOVE*'    Set To Dictionary    ${headers}    Authorization=Bearer ${token}
    ${path}    Set Variable    ${backoffice_api_url_SIT}${admin_search_speaker_user_api}
    ${resp}    Get    ${path}    headers=${headers}    expected_status=any
    ${resp}    Set Variable    ${resp.json()}
    [Return]    ${resp}

Call API GET Search Speaker User With Limits
    [Documentation]    calls an API to search for a speaker user with the given parameters.
    [Arguments]    ${token}    ${limit}
    &{headers}    Create Dictionary    Content-Type=application/json
    Run Keyword If    '${token}' !='*REMOVE*'    Set To Dictionary    ${headers}    Authorization=Bearer ${token}
    ${path}    Set Variable    ${backoffice_api_url_SIT}${admin_search_speaker_user_api}?limit=${limit}
    ${resp}    Get    ${path}    headers=${headers}    expected_status=any
    ${resp}    Set Variable    ${resp.json()}
    [Return]    ${resp}

Call API GET Search Speaker User With Query And Limits
    [Documentation]    calls an API to search for a speaker user with the given parameters.
    [Arguments]    ${token}    ${data_query}    ${limit}
    &{headers}    Create Dictionary    Content-Type=application/json
    Run Keyword If    '${token}' !='*REMOVE*'    Set To Dictionary    ${headers}    Authorization=Bearer ${token}
    ${path}    Set Variable    ${backoffice_api_url_SIT}${admin_search_speaker_user_api}?query=${data_query}&limit=${limit}
    ${resp}    Get    ${path}    headers=${headers}    expected_status=any
    ${resp}    Set Variable    ${resp.json()}
    [Return]    ${resp}

Call API GET Search Speaker User Without Bearer
    [Documentation]    use for send a GET request to the specified API endpoint without including the Bearer token in the Authorization header.
    [Arguments]    ${token}    ${data_query}
    &{headers}    Create Dictionary    Content-Type=application/json
    Run Keyword If    '${token}' !='*REMOVE*'    Set To Dictionary    ${headers}    Authorization=${token}
    ${path}    Set Variable    ${backoffice_api_url_SIT}${admin_search_speaker_user_api}?query=${data_query}
    ${resp}    Get    ${path}    headers=${headers}    expected_status=any
    ${resp}    Set Variable    ${resp.json()}
    [Return]    ${resp}

Call API GET Search Speaker User With Invalid Method
    [Documentation]    use for send a Post request to the specified API endpoint with invalid method
    [Arguments]    ${token}    ${data_query}
    &{headers}    Create Dictionary    Content-Type=application/json
    Run Keyword If    '${token}' !='*REMOVE*'    Set To Dictionary    ${headers}    Authorization=Bearer ${token}
    ${path}    Set Variable    ${backoffice_api_url_SIT}${admin_search_speaker_user_api}?query=${data_query}
    ${resp}    POST    ${path}    headers=${headers}    expected_status=any
    [Return]    ${resp}

Call API GET Search Speaker User With Invalid Path
    [Documentation]    use for send a GET request to the specified API endpoint with an invalid path.
    [Arguments]    ${token}    ${data_query}
    &{headers}    Create Dictionary    Content-Type=application/json
    Run Keyword If    '${token}' !='*REMOVE*'    Set To Dictionary    ${headers}    Authorization=Bearer ${token}
    ${path}    Set Variable    ${backoffice_api_url_SIT}${admin_search_speaker_user_api}ds?query=${data_query}
    ${resp}    Get    ${path}    headers=${headers}    expected_status=any
    [Return]    ${resp}

Validate Name Of Fields In Search Speaker User APIs Is Completely
    [Documentation]    use for validate that the response from the API contains all the expected fields.
    [Arguments]    ${resp}
    Should Contain    ${resp['data'][0]}    employeeId
    Should Contain    ${resp['data'][0]}    firstName
    Should Contain    ${resp['data'][0]}    lastName
    Should Contain    ${resp['data'][0]}    email

Query User Lists Where String
    [Documentation]    use for query the database for a list of user based on a input.
    [Arguments]    ${data_query}
    ${string}=    Convert To Lower Case    ${data_query}
    DB_CONNECT
    @{query_user_list}    Query    SELECT employee_id, first_name, last_name, email FROM public.user WHERE employee_id LIKE '${string}%' or first_name LIKE '${string}%' or last_name LIKE '${string}%' or email like '${string}%' ORDER BY employee_id ASC LIMIT 10;
    Log Many     @{query_user_list}
    Set Test Variable    @{query_user_list}
    DB_CLOSE
    [return]    ${query_user_list}

Query User Lists Without String
    [Documentation]    use for query the database for a list of user based on a input.
    DB_CONNECT
    @{query_user_list}    Query    SELECT employee_id, first_name, last_name, email FROM public.user WHERE employee_id LIKE '%%' or first_name LIKE '%%' or last_name LIKE '%%' or email like '%%' ORDER BY employee_id ASC LIMIT 10;
    Log Many     @{query_user_list}
    Set Test Variable    @{query_user_list}
    DB_CLOSE
    [return]    ${query_user_list}

Query User Lists Without String And With Limits
    [Documentation]    use for query the database for a list of user based on a input.
    [Arguments]    ${limit}
    DB_CONNECT
    @{query_user_list}    Query    SELECT employee_id, first_name, last_name, email FROM public.user WHERE employee_id LIKE '%%' or first_name LIKE '%%' or last_name LIKE '%%' or email like '%%' ORDER BY employee_id ASC LIMIT ${limit};
    Log Many     @{query_user_list}
    Set Test Variable    @{query_user_list}
    DB_CLOSE
    [return]    ${query_user_list}

Query User Lists Where String And With Limits
    [Documentation]    use for query the database for a list of user based on a input.
    [Arguments]    ${data_query}    ${limit}
    ${string}=    Convert To Lower Case    ${data_query}
    DB_CONNECT
    @{query_user_list}    Query    SELECT employee_id, first_name, last_name, email FROM public.user WHERE employee_id LIKE '${string}%' or first_name LIKE '${string}%' or last_name LIKE '${string}%' or email like '${string}%' ORDER BY employee_id ASC LIMIT ${limit};
    Log Many     @{query_user_list}
    Set Test Variable    @{query_user_list}
    DB_CLOSE
    [return]    ${query_user_list}

Validate Type Of Speaker User Data In APIs
    [Documentation]    use for validate the data types of specific fields in the API response.
    [Arguments]    ${resp}
    ${speaker_employee_id}=    Verify Types    ${resp['data'][0]['employeeId']}
    ${speaker_firstname_id}=    Verify Types    ${resp['data'][0]['firstName']}
    ${speaker_lastname_id}=    Verify Types    ${resp['data'][0]['lastName']}
    ${speaker_email_id}=    Verify Types    ${resp['data'][0]['email']}
    #some data is true but program compare out of target
    Run Keyword And Ignore Error    Should Be Equal As Strings    ${speaker_employee_id}    STRING
    Should Be Equal As Strings    ${speaker_firstname_id}    STRING
    Should Be Equal As Strings    ${speaker_lastname_id}    STRING
    Should Be Equal As Strings    ${speaker_email_id}    STRING

Preapare Data In Database And Search Speaker User APIs With Limits
    [Documentation]    use for prepare data by comparing the data from the database and APIs response.
    [Arguments]    ${query_user_list}    ${resp}    ${limit}
    @{db_list}=	Create List  #data from api
    @{resp_list}=	Create List  #data from api
    
    #append resp to new list // convert to the same data for compare data [tuple to list]
    ${count_query_db}    Get Length    ${query_user_list}
    FOR    ${item}    IN RANGE    ${count_query_db}
        @{db_data_list}=	Create List  #data from api
        Append To List  ${db_data_list}    ${query_user_list[${item}][0]}
        Append To List  ${db_data_list}    ${query_user_list[${item}][1]}
        Append To List  ${db_data_list}    ${query_user_list[${item}][2]}
        Append To List  ${db_data_list}    ${query_user_list[${item}][3]}
        Append To List  ${db_list}    ${db_data_list}
    END

    #append resp to new list // convert to the same data for compare data
    ${count_query_api}    Get Length    ${resp['data']}
    FOR    ${item}    IN RANGE    ${count_query_api}
        @{resp_data_list}=	Create List  #data from api
        Append To List  ${resp_data_list}    ${resp['data'][${item}]['employeeId']}
        Append To List  ${resp_data_list}    ${resp['data'][${item}]['firstName']}
        Append To List  ${resp_data_list}    ${resp['data'][${item}]['lastName']}
        Append To List  ${resp_data_list}    ${resp['data'][${item}]['email']}
        Append To List  ${resp_list}    ${resp_data_list}
    END

    #compare data between 2 lists
    ${count_db_append_list}    Get Length    ${db_list}
    ${count_resp_append_list}    Get Length    ${resp_list}
    Should Be Equal As Integers    ${count_db_append_list}    ${count_resp_append_list}
    Lists Should Be Equal    ${db_list}    ${resp_list}

    #data from search should be <= 10 records
    Should Be True    ${count_db_append_list} <= ${limit}
    Should Be True    ${count_resp_append_list} <= ${limit}
