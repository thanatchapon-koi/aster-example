*** Settings ***
Resource    ${CURDIR}/../../../resources/imports.robot
Resource    ${CURDIR}/../../../keywords/common/common_keywords.robot
Resource    ${CURDIR}/../../../keywords/api/asset_apis.robot


*** Test Cases ***

TC-01-001
    [Documentation]    Submit upload whitelist success
    ...    In case of:
    ...    - valid assets_id
    
    ${resp}    Post Submit Upload Whitelist    ${admin_session_token}    493    630176    employee_id    0
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}
    sleep    1
    ${resp}    GET Show Whitelist User Success    ${admin_session_token}    493
    Assert Http Status Code Is 200 Ok   
    Assert Response Status Object With 2000 Success    ${resp}
    Should Be Equal As Strings    ${resp['data'][0]['refId']}    630176
    Should Be Equal As Strings    ${resp['data'][0]['status']}   whitelist
    ${resp}    Delete Whitelist User    ${admin_session_token}    493



TC-01-002
    [Documentation]    Submit upload whitelist success
    ...    In case of:
    ...    s- (refId) employee_id มีข้อมูลในระบบ

    ${resp}    Post Submit Upload Whitelist    ${admin_session_token}    493    630176    employee_id    0
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}
    sleep    1
    ${resp}    GET Show Whitelist User Success    ${admin_session_token}    493
    Assert Http Status Code Is 200 Ok   
    Assert Response Status Object With 2000 Success    ${resp}
    Should Be Equal As Strings    ${resp['data'][0]['refId']}    630176
    Should Be Equal As Strings    ${resp['data'][0]['status']}   whitelist
    ${resp}    Delete Whitelist User    ${admin_session_token}    493


TC-01-003
    [Documentation]    Submit upload whitelist success
    ...    In case of:
    ...    - (refId) walletAddress มีข้อมูลในระบบ

    ${resp}    Post Submit Upload Whitelist    ${admin_session_token}    493    0x81122F39D43a9076A4dc6e55193E43032Bc3C8c6    wallet_address    0
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}
    sleep    1
    ${resp}    GET Show Whitelist User Success    ${admin_session_token}    493
    Assert Http Status Code Is 200 Ok   
    Assert Response Status Object With 2000 Success    ${resp}
    Should Be Equal As Strings    ${resp['data'][0]['refId']}    0x81122F39D43a9076A4dc6e55193E43032Bc3C8c6
    Should Be Equal As Strings    ${resp['data'][0]['status']}    whitelist
    ${resp}    Delete Whitelist User    ${admin_session_token}    493


TC-01-004
    [Documentation]    Submit upload whitelist success
    ...    In case of:
    ...    - (refId) email มีข้อมูลในระบบ

    ${resp}    Post Submit Upload Whitelist    ${admin_session_token}    493    kingkan.n@infinitaskt.com    email    0
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}
    sleep    1
    ${resp}    GET Show Whitelist User Success    ${admin_session_token}    493
    Assert Http Status Code Is 200 Ok   
    Assert Response Status Object With 2000 Success    ${resp}
    Should Be Equal As Strings    ${resp['data'][0]['refId']}    kingkan.n@infinitaskt.com
    Should Be Equal As Strings    ${resp['data'][0]['status']}    whitelist
    ${resp}    Delete Whitelist User    ${admin_session_token}    493


TC-01-005
    [Documentation]    Submit upload whitelist success
    ...    In case of:
    ...    - (refId) employee_id ไม่มีข้อมูลในระบบ

    ${resp}    Post Submit Upload Whitelist    ${admin_session_token}    493    347655    employee_id    0
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}
    sleep    1
    ${resp}    GET Show Whitelist User Success    ${admin_session_token}    493
    Assert Http Status Code Is 200 Ok   
    Assert Response Status Object With 2000 Success    ${resp}
    Should Be Equal As Strings    ${resp['data'][0]['refId']}    347655
    Should Be Equal As Strings    ${resp['data'][0]['status']}    User Not Found
    ${resp}    Delete Whitelist User    ${admin_session_token}    493



TC-01-006
    [Documentation]    Submit upload whitelist success
    ...    In case of:
    ...    - (refId) walletAddress ไม่มีข้อมูลในระบบ

    ${resp}    Post Submit Upload Whitelist    ${admin_session_token}    493    0x88122F39D43a9076A4dc6e55193E43032Bc3C8c6    wallet_address    0
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}
    sleep    1
    ${resp}    GET Show Whitelist User Success    ${admin_session_token}    493
    Assert Http Status Code Is 200 Ok   
    Assert Response Status Object With 2000 Success    ${resp}
    Should Be Equal As Strings    ${resp['data'][0]['refId']}    0x88122F39D43a9076A4dc6e55193E43032Bc3C8c6
    Should Be Equal As Strings    ${resp['data'][0]['status']}    User Not Found
    ${resp}    Delete Whitelist User    ${admin_session_token}    493


TC-01-007
    [Documentation]    Submit upload whitelist success
    ...    In case of:
    ...    - (refId) email ไม่มีข้อมูลในระบบ

    ${resp}    Post Submit Upload Whitelist    ${admin_session_token}    493    kingkan@infinitaskt.com    email    0
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}
    sleep    1
    ${resp}    GET Show Whitelist User Success    ${admin_session_token}    493
    Assert Http Status Code Is 200 Ok   
    Assert Response Status Object With 2000 Success    ${resp}
    Should Be Equal As Strings    ${resp['data'][0]['refId']}    kingkan@infinitaskt.com
    Should Be Equal As Strings    ${resp['data'][0]['status']}    User Not Found
    ${resp}    Delete Whitelist User    ${admin_session_token}    493



TC-01-008
    [Documentation]    Submit upload whitelist success
    ...    In case of:
    ...    - (refType) refType ถูกต้องตามที่ระบุใน refId

    ${resp}    Post Submit Upload Whitelist    ${admin_session_token}    493    630176    employee_id    0
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}
    sleep    1
    ${resp}    GET Show Whitelist User Success    ${admin_session_token}    493
    Assert Http Status Code Is 200 Ok   
    Assert Response Status Object With 2000 Success    ${resp}
    Should Be Equal As Strings    ${resp['data'][0]['refId']}    630176
    Should Be Equal As Strings    ${resp['data'][0]['status']}    whitelist
    ${resp}    Delete Whitelist User    ${admin_session_token}    493



    
TC-01-009
    [Documentation]    Submit upload whitelist success
    ...    In case of:
    ...    - valid templateIndex (int)

    ${resp}    Post Submit Upload Whitelist    ${admin_session_token}    493    630176    employee_id    0
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}
    sleep    1
    ${resp}    GET Show Whitelist User Success    ${admin_session_token}    493
    Assert Http Status Code Is 200 Ok   
    Assert Response Status Object With 2000 Success    ${resp}
    Should Be Equal As Strings    ${resp['data'][0]['refId']}    630176
    Should Be Equal As Strings    ${resp['data'][0]['status']}    whitelist
    ${resp}    Delete Whitelist User    ${admin_session_token}    493


TC-01-010
    [Documentation]    Submit upload whitelist success
    ...    In case of:
    ...    - (body) มีชุดข้อมูลซ้ำ

    ${resp}    Post Submit Upload Whitelist Mutilist    ${admin_session_token}    493    630176    employee_id    0    630176    employee_id    0
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}
    sleep    1
    ${resp}    GET Show Whitelist User Success    ${admin_session_token}    493
    Assert Http Status Code Is 200 Ok   
    Assert Response Status Object With 2000 Success    ${resp}
    Should Be Equal As Strings    ${resp['data'][0]['refId']}    630176
    Should Be Equal As Strings    ${resp['data'][0]['status']}    whitelist
    ${resp}    Delete Whitelist User    ${admin_session_token}    493
    ${resp}    GET Show Whitelist User Success    ${admin_session_token}    493
    Assert Http Status Code Is 200 Ok   
    Assert Response Status Object With 2000 Success    ${resp}
    Should Be Equal As Strings    ${resp['data'][0]['refId']}    630176
    Should Be Equal As Strings    ${resp['data'][0]['status']}   whitelist
    ${resp}    Delete Whitelist User    ${admin_session_token}    493


TC-01-011
    [Documentation]    Submit upload whitelist success
    ...    In case of:
    ...    - (body) ไม่มีชุดข้อมูลซ้ำ

    ${resp}    Post Submit Upload Whitelist Mutilist    ${admin_session_token}    493    630176    employee_id    0    999002    employee_id    0
    Assert Http Status Code Is 200 Ok
    Assert Response Status Object With 2000 Success    ${resp}
    sleep    1
    ${resp}    GET Show Whitelist User Success    ${admin_session_token}    493
    Assert Http Status Code Is 200 Ok   
    Assert Response Status Object With 2000 Success    ${resp}
    Should Be Equal As Strings    ${resp['data'][0]['refId']}   630176
    Should Be Equal As Strings    ${resp['data'][0]['status']}   whitelist
    ${resp}    Delete Whitelist User    ${admin_session_token}    493
    ${resp}    GET Show Whitelist User Success    ${admin_session_token}    493
    Assert Http Status Code Is 200 Ok   
    Assert Response Status Object With 2000 Success    ${resp}
    Should Be Equal As Strings    ${resp['data'][0]['refId']}   999002
    Should Be Equal As Strings    ${resp['data'][0]['status']}   User Not Found
    ${resp}    Delete Whitelist User    ${admin_session_token}    493


TC-02-001
    [Documentation]    Submit upload whitelist fail
    ...    ...    In case of:
    ...    ...    - other role (except nft manager, admin)
    ${resp}    Post Submit Upload Whitelist    ${user_management_session_token}    493    kingkan@infinitaskt.com    email    0
    Assert Http Status Code Is 403 Dont Have Permission
    Assert Response Status Object With 4030 User Doesn't Have Permission    ${resp}
    Should Be Equal As Strings    ${resp['error']}    User doesn't have permission to do this action. 


TC-03-001
    [Documentation]    Submit upload whitelist fail
    ...    In case of:
    ...    - invalid assets_id (assets_id not found)
    ${resp}    Post Submit Upload Whitelist    ${admin_session_token}    065    kingkan@infinitaskt.com    email    0
    Assert Http Status Code Is 404 Not Found
    Assert Response Status Object With 4040 Invalid Parameter Request    ${resp}
    Should Be Equal As Strings    ${resp['error']}    asset not found


TC-03-002
    [Documentation]    Submit upload whitelist fail
    ...    In case of:
    ...    - invalid assets_id (input (space) to path)

    ${resp}    Post Submit Upload Whitelist    ${admin_session_token}    \    kingkan@infinitaskt.com    email    0
    Assert Http Status Code Is 400 Bad Request
    Assert Response Status Object With 4002 Invalid Parameter Request    ${resp}
    Should Be Equal As Strings    ${resp['error']}    strconv.Atoi: parsing "": invalid syntax


TC-03-003
    [Documentation]    Submit upload whitelist fail
    ...    In case of:
    ...    - assets_id not send

    ${resp}    Post Submit Upload Whitelist    ${admin_session_token}    ${EMPTY}    kingkan@infinitaskt.com    email    0
    Assert Http Status Code Is 400 Bad Request
    Assert Response Status Object With 4002 Invalid Parameter Request    ${resp}
    Should Be Equal As Strings    ${resp['error']}    strconv.Atoi: parsing "": invalid syntax


TC-03-004
    [Documentation]    Submit upload whitelist fail
    ...    In case of:
    ...    - invalid assets_id (input string)

    ${resp}    Post Submit Upload Whitelist    ${admin_session_token}    test    kingkan@infinitaskt.com    email    0
    Assert Http Status Code Is 400 Bad Request
    Assert Response Status Object With 4002 Invalid Parameter Request    ${resp}
    Should Be Equal As Strings    ${resp['error']}    strconv.Atoi: parsing \"test\": invalid syntax


TC-04-001
    [Documentation]    Submit upload whitelist fail
    ...    In case of:
    ...    - invalid type of input refId (input string)

    ${resp}    Post Submit Upload Whitelist    ${admin_session_token}    493    Kingkan    employee_id    0
    Assert Http Status Code Is 400 Bad Request
    Assert Response Status Object With 4002 Invalid Parameter Request    ${resp}
    Should Be Equal As Strings    ${resp['error']}    ref_type: employee_id but ref_id format is incorrect


TC-04-002
    [Documentation]    Submit upload whitelist fail
    ...    In case of:
    ...    - invalid type of input refType (input int)

    ${refType}    Convert To Integer    111
    ${resp}    Post Submit Upload Whitelist    ${admin_session_token}    493    630176    ${refType}    0
    Assert Http Status Code Is 400 Bad Request
    Assert Response Status Object With 4002 Invalid Parameter Request    ${resp}
    Should Be Equal As Strings    ${resp['error']}    json: cannot unmarshal number into Go struct field whitelistdata.whitelistData.refType of type string


TC-04-003
    [Documentation]    Submit upload whitelist fail
    ...    In case of:
    ...    - invalid type of input templateIndex (input string)

    ${resp}    Post Submit Upload Whitelist Invalid    ${admin_session_token}    493    630176    employee_id    test
    Assert Http Status Code Is 400 Bad Request
    Assert Response Status Object With 4002 Invalid Parameter Request    ${resp}
    Should Be Equal As Strings    ${resp['error']}    json: cannot unmarshal string into Go struct field whitelistdata.whitelistData.templateIndex of type int


TC-04-004
    [Documentation]    Submit upload whitelist fail
    ...    In case of:
    ...    - input null value to refId ("refId": null)

    ${resp}    Post Submit Upload Whitelist    ${admin_session_token}    493    ${EMPTY}    employee_id    0
    Assert Http Status Code Is 400 Bad Request
    Assert Response Status Object With 4002 Invalid Parameter Request    ${resp}
    Should Be Equal As Strings    ${resp['error']}    ref_Id can not be null


TC-04-005
    [Documentation]    Submit upload whitelist fail
    ...    In case of:
    ...    - input null value to refType ("refType": null)

    ${resp}    Post Submit Upload Whitelist    ${admin_session_token}    493    630176    ${EMPTY}    0
    Assert Http Status Code Is 400 Bad Request
    Assert Response Status Object With 4002 Invalid Parameter Request    ${resp}
    Should Be Equal As Strings    ${resp['error']}    ref_type can not be null or must be one of: employee_id, wallet_address, email


TC-04-006
    [Documentation]    Submit upload whitelist fail
    ...    In case of:
    ...    - input null value to templateIndex ("templateIndex": null)

    ${resp}    Post Submit Upload Whitelist Invalid    ${admin_session_token}    493    630176    employee_id    *REMOVE*
    Assert Http Status Code Is 400 Bad Request
    Assert Response Status Object With 4002 Invalid Parameter Request    ${resp}
    Should Be Equal As Strings    ${resp['error']}    templateIndex can not be null


TC-04-007
    [Documentation]    Submit upload whitelist fail
    ...    In case of:
    ...    - input empty value to refId ("refId": "")

    ${resp}    Post Submit Upload Whitelist    ${admin_session_token}    493    ${EMPTY}    employee_id    0
    Assert Http Status Code Is 400 Bad Request
    Assert Response Status Object With 4002 Invalid Parameter Request    ${resp}
    Should Be Equal As Strings    ${resp['error']}    ref_Id can not be null


TC-04-008
    [Documentation]    Submit upload whitelist fail
    ...    In case of:
    ...    - input empty value to refType ("refType": "")

    ${resp}    Post Submit Upload Whitelist    ${admin_session_token}    493    630176    ${EMPTY}    0
    Assert Http Status Code Is 400 Bad Request
    Assert Response Status Object With 4002 Invalid Parameter Request    ${resp}
    Should Be Equal As Strings    ${resp['error']}    ref_type can not be null or must be one of: employee_id, wallet_address, email


TC-04-009
    [Documentation]    Submit upload whitelist fail
    ...    In case of:
    ...    - input empty value to templateIndex ("templateIndex": "")

    ${resp}    Post Submit Upload Whitelist Invalid    ${admin_session_token}    493    630176    employee_id    ${EMPTY}
    Assert Http Status Code Is 400 Bad Request
    Assert Response Status Object With 4002 Invalid Parameter Request    ${resp}
    Should Be Equal As Strings    ${resp['error']}    json: cannot unmarshal string into Go struct field whitelistdata.whitelistData.templateIndex of type int



TC-04-010
    [Documentation]    Submit upload whitelist fail
    ...    In case of:
    ...    - invalid name of refId or refId not send

    ${resp}    Post Submit Upload Whitelist    ${admin_session_token}    493    *REMOVE*    employee_id    0
    Assert Http Status Code Is 400 Bad Request
    Assert Response Status Object With 4002 Invalid Parameter Request    ${resp}
    Should Be Equal As Strings    ${resp['error']}    ref_Id can not be null


TC-04-011
    [Documentation]    Submit upload whitelist fail
    ...    In case of:
    ...    - invalid name of refType or refType not send

    ${resp}    Post Submit Upload Whitelist    ${admin_session_token}    493    630176    *REMOVE*    0
    Assert Http Status Code Is 400 Bad Request
    Assert Response Status Object With 4002 Invalid Parameter Request    ${resp}
    Should Be Equal As Strings    ${resp['error']}    ref_type can not be null or must be one of: employee_id, wallet_address, email

    

 TC-04-012
     [Documentation]    Submit upload whitelist fail
     ...    In case of:
     ...    - invalid name of templateIndex or templateIndex not send

    ${resp}    Post Submit Upload Whitelist Invalid    ${admin_session_token}    493    630176    employee_id    *REMOVE*
    Assert Http Status Code Is 400 Bad Request
    Assert Response Status Object With 4002 Invalid Parameter Request    ${resp}
    Should Be Equal As Strings    ${resp['error']}    templateIndex can not be null
 



TC-04-013
    [Documentation]    Submit upload whitelist fail
    ...    In case of:
    ...    - invalid refType (refType not match with refId)

    ${resp}    Post Submit Upload Whitelist    ${admin_session_token}    493    630176    email    0
    Assert Http Status Code Is 400 Bad Request
    Assert Response Status Object With 4002 Invalid Parameter Request    ${resp}
    Should Be Equal As Strings    ${resp['error']}    ref_type: email but ref_id format is incorrect


TC-04-014
    [Documentation]    Submit upload whitelist fail
    ...    In case of:
    ...    - body not send

    ${resp}    Post Submit Upload Whitelist Not Send Data    ${admin_session_token}    493
    Assert Http Status Code Is 400 Bad Request
    Assert Response Status Object With 4002 Invalid Parameter Request    ${resp}
    Should Be Equal As Strings    ${resp['error']}    Request body cannot be empty



TC-05-001
    [Documentation]    Submit upload whitelist fail
    ...    In case of:
    ...    - invalid session token

    ${resp}    Post Submit Upload Whitelist    ${admin_session_token}1211    493    630176    employee_id    0
    Assert Http Status Code Is 401 Unauthorized
    Assert Response Status Object With 4012 Unauthorized   ${resp}
    Should Be Equal As Strings    ${resp['error']}    signature is invalid


TC-05-002
    [Documentation]    Submit upload whitelist fail
    ...    In case of:
    ...    - session token expired

    ${resp}    Post Submit Upload Whitelist    ${admin_session_token_exp}    493    630176    employee_id    0
    Assert Http Status Code Is 401 Unauthorized
    Assert Response Status Object With 4012 Unauthorized   ${resp}
    Should Contain    ${resp['error']}    token is expired by


TC-05-003
    [Documentation]    Submit upload whitelist fail
    ...    In case of:
    ...    - session token is an empty

    ${resp}    Post Submit Upload Whitelist    ${EMPTY}    493    630176    employee_id    0
    Assert Http Status Code Is 401 Unauthorized
    Assert Response Status Object With 4011 Unauthorized    ${resp}
    Should Be Equal As Strings    ${resp['error']}    Unable to parse token. Token might be empty string or null



TC-05-005
    [Documentation]    Submit upload whitelist fail
    ...    In case of:
    ...    - session token is not send

    ${resp}    Post Submit Upload Whitelist    *REMOVE*    493    630176    employee_id    0
    Assert Http Status Code Is 401 Unauthorized
    Assert Response Status Object With 4011 Unauthorized    ${resp}
    Should Be Equal As Strings    ${resp['error']}    Unable to parse token. Token might be empty string or null




    


    



    
    
