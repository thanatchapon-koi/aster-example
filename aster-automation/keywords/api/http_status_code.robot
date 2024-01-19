*** Settings ***
Resource    ${CURDIR}/../../resources/imports.robot

*** Keywords ***
Assert Http Status Code Is 200 Ok
    [Documentation]    verify http status code is 200
    Status Should Be    200

Assert Http Status Code Is 204 Created
    [Documentation]    verify http status code is 204
     Status Should Be    204

Assert Http Status Code Is 400 Bad Request
    [Documentation]    verify http status code is 400
    Status Should Be    400

Assert Http Status Code Is 401 Unauthorized
    [Documentation]    verify http status code is 401
    Status Should Be    401

Assert Http Status Code Is 403 Dont Have Permission
    [Documentation]    verify http status code is 403
    Status Should Be    403

Assert Http Status Code Is 404 Not Found
    [Documentation]    verify http status code is 404
    Status Should Be    404

Assert Http Status Code Is 500 Internal Server Error
    [Documentation]    verify http status code is 500
    Status Should Be    500
