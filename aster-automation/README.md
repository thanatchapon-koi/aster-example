# Aster-Automation README.md ver.1

### วิธีสร้างไฟล์ Service Grouping Keywords _(กรณียังไม่มี)_
>1. ไปที่ path: keywords/api
>2. สร้างไฟล์ .robot ขึ้นมา โดยตั้งชื่อจาก service name ดังนี้ service_apis.robot (ex. user_apis.robot)
Hint: สังเกตชื่อ service จากไฟล์เทสต์เคส Back-end - Aster Test Cases ว่า APIs เส้นนั้นอยู่ภายใต้ service grouping ไหน
>3. Import setting ตั้งต้น ดังนี้
```
*** Settings ***
Resource    ${CURDIR}/../../resources/imports.robot
Resource    ${CURDIR}/../../resources/testdata/common_configs.robot
Resource    ${CURDIR}/../../keywords/common/common_keywords.robot
```

### หลักการการเขียน *** Keywords ***
>1. สร้าง Keyword ใหม่ภายใต้ ไฟล์ Service Grouping โดยไปที่ path: keywords/api/(service_grouping_name)_apis.robot
>2. Keyword Name ตัวแรกของ “คำ” เป็นตัวพิมพ์ใหญ่เสมอ (ex. Get All Of Admin User Lists)
>3. Variable (ตัวแปร) เป็นตัวพิมพ์เล็กทั้งหมด และแทนช่องว่างด้วยเครื่องหมาย underscore (“_”) (ex. ${email}, ${recaptcha_token})

### วิธีสร้างแฟ้ม Test Cases _(กรณียังไม่มี)_
>1. ไปที่ path: testcases/WebAdmin (Back Office) หรือ path: testcases/WebAster
>2. สร้าง folder ขึ้นมา โดยตั้งชื่อจาก service name
>3. Noted: ชื่อ folder ให้ตั้งตาม service grouping โดยไม่มีช่องว่าง และตัวอักษรตัวแรกของคำเป็นตัวพิมพ์ใหญ่ (ex. BannerAPIs)
>4. Hint: สังเกตชื่อ service จากไฟล์เทสต์เคส Back-end - Aster Test Cases ว่า APIs เส้นนั้นอยู่ภายใต้ service grouping ไหน

### วิธีสร้างไฟล์ Test Cases _(กรณียังไม่มี)_
>1. ไปที่ path: testcases/WebAdmin/(service_name)
>2. สร้างไฟล์ .robot ขึ้นมา โดยตั้งชื่อจาก method ของ APIs (ex. DELETE admin user ->  delete_admin_user.robot)
>3. Import setting ตั้งต้น ดังนี้
```
*** Settings ***
Resource    ${CURDIR}/../../../resources/imports.robot
Resource    ${CURDIR}/../../../keywords/common/common_keywords.robot
Resource    ${CURDIR}/../../../resources/testdata/common_configs.robot
Resource    ${CURDIR}/../../../keywords/api/assert_response.robot
Resource    ${CURDIR}/../../../keywords/api/http_status_code.robot
```

### วิธีการเขียน *** Test Cases ***
>1. การตั้งชื่อ Testcase ให้ใช้ TestcaseID ตามไฟล์ Testcase (ex. "TC-09-001" )
>2. ระบุ Documentation เป็นชื่อ Testcase# aster-example
