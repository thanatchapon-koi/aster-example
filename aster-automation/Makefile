timestamp = `date +'%Y%m%d_%H%M%S'`

get_backoffice_user_list:
	robot -d ./results \
	--log get_backoffice_user_list_log_$(timestamp).html \
	--report get_backoffice_user_list_report_$(timestamp).html \
	--output get_backoffice_user_list_output_$(timestamp).html \
	./testcases/WebAdmin/UserAPIs/get_backoffice_user_list.robot