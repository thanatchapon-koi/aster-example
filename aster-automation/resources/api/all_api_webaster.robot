*** Variables ***
${get_nonce_api}    /authentication-service/v1/authen/get-nonce
${request_faucet_api}    /faucet-service/v1/faucet/request
${campaign_detail_api}    /gamification-service/v1/campaign/detail/{campaign_id}
${all_campaign_api}    /gamification-service/v1/campaign/list
${prediction_history_api}    /gamification-service/v1/game/prediction/{game_id}
${reward_redeem_history_api}    /gamification-service/v1/reward/history
${user_info_api}    /registration-service/v1/user
${check_exist_address_api}    /registration-service/v1/user/{address}
${display_archievement_badge_api}    /registration-service/v1/user/assets
${upload_pcture_profile_api}    /registration-service/v1/user/picture
${team_role_detail_api}    /registration-service/v1/user/team-role