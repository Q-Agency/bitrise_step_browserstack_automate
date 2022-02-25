#!/bin/bash
set -ex

app_url_apk=$(curl -u "${browserstack_user_name}:${browserstack_access_key}" -X POST "https://api-cloud.browserstack.com/app-automate/upload" -F "file=@$file_to_upload_apk" -F "custom_id=${custom_id}")

echo $app_url
  if [[ "$app_url" == *"app_url"* ]]
  then
    app_url_apk=`echo $app_url_apk | awk -F':' '{ print $2 ":" $3 }' | awk '{ print substr( $0, 2, length($0)-3 ) }'`
    echo $app_url_apk
    envman add --key BROWSERSTACK_APP_AUTOMATE_APK_URL --value "$app_url_apk"
    exit 0
  else
    echo $app_url_apk
    echo "Error uploading file to Browserstack"
    exit 1
  fi
