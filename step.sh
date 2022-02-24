#!/bin/bash
set -ex

app_url=$(curl -u "${browserstack_user_name}:${browserstack_access_key}" -X POST "https://api-cloud.browserstack.com/app-automate/upload" -F "file=@$file_to_upload_apk")

echo $app_url
  if [[ "$app_url" == *"app_url"* ]]
  then
    app_url=`echo $app_url | awk -F':' '{ print $2 ":" $3 }' | awk '{ print substr( $0, 2, length($0)-3 ) }'`
    #app_url=`awk '{ print substr( $0, 1, length($0)-1 ) }'`
    #app_url=${app_url%??}
    echo $app_url
    envman add --key BROWSERSTACK_APP_AUTOMATE_APK_URL --value "$app_url"
    exit 0
  else
    echo $app_url
    echo "Error uploading file to Browserstack"
    exit 1
  fi
