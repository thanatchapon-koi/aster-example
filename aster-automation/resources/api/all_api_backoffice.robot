*** Variables ***

${asset_id}
${session_id}
${airdrop_request_id}


#Airdrop APIs
${admin_airdrop_list_api}    /admin-service/v1/airdrop
${admin_airdrop_detail_by_airdrop_req_id_api}    /admin-service/v1/airdrop/${airdrop_request_id}
${admin_airdrop_approve_api}    /admin-service/v1/airdrop/approve
${admin_airdrop_approve_token_before_approve_airdrop_api}    /admin-service/v1/airdrop/approve-token    #not use this api
${admin_airdrop_reject_api}    /admin-service/v1/airdrop/reject

#Asset APIs
${admin_assets_management_api}    /admin-service/v1/assets
${admin_assets_detail_by_asset_id_api}    /admin-service/v1/assets/${asset_id}
${admin_assets_image_api}    /admin-service/v1/assets/image
${admin_assets_group_api}    /admin-service/v1/asset-group-categories

#Authentication APIs
${admin_authentication_api}    /admin-service/v1/login

#Banner APIs
${admin_banner_managenent_api}    /admin-service/v1/banner

#Campaign APIs
${admin_campaign_api}    /admin-service/v1/campaigns

#Event APIs
${admin_events_api}    /admin-service/v1/events

#Participation APIs
${admin_participation_api}    /admin-service/v1/participation
${admin_participation_detail_by_session_id_api}    /admin-service/v1/participation?session_id=
${admin_participation_list_management_api}    /admin-service/v1/participation/airdrop

#Redemption APIs
${admin_redeemtion_management_api}    /admin-service/v1/redemptions

#Session APIs
${admin_session_management_api}    /admin-service/v1/session
${admin_session_detail_by_session_id_api}    /admin-service/v1/session/${session_id}
${admin_session_detail_by_session_id_param_api}    /admin-service/v1/session?session_id=${session_id}

#User APIs
${admin_user_management_api}    /admin-service/v1/user
${admin_role_api}    /admin-service/v1/user/role
${admin_search_speaker_user_api}    /admin-service/v1/user/search
${admin_employee_management_api}    /admin-service/v1/employee-management