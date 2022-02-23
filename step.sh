#!/bin/bash
set -ex

app_url=$(curl -u "${browserstack_user_name}:${browserstack_access_key}" -X POST "https://api-cloud.browserstack.com/app-automate/upload" -F "file=@$file_to_upload")

echo $app_url
  if [[ "$app_url" == *"app_url"* ]]
  then
    app_url=`echo $app_url | awk -F':' '{ print $2 ":" $3 }' | awk '{ print substr( $0, 2, length($0)-3 ) }'`
    #app_url=`awk '{ print substr( $0, 1, length($0)-1 ) }'`
    #app_url=${app_url%??}
    echo $app_url
    envman add --key BROWSERSTACK_APP_AUTOMATE_URL --value "$app_url"
    exit 0
  else
    echo $app_url
    echo "Error uploading file to Browserstack"
    exit 1
  fi
  
  
  
# #!/bin/bash

# if [ -z "$browserstack_username" ]; then
#   echo "Please provide your Browserstack Username"
#   exit 1
# fi

# if [ -z "$browserstack_access_key" ]; then
#   echo "Please provide your Browserstack Access Key"
#   exit 1
# fi

# if [ -z "$apk_ipa_filepath" ]; then
#   echo "Please provide the path for the IPA or APK that you wish to upload."
#   echo "For IPA it is usually \$BITRISE_IPA_PATH"
#   echo "For APK it is usually \$BITRISE_APK_PATH"
#   exit 1
# fi

# curl -u "$browserstack_username:$browserstack_access_key" -X POST https://api-cloud.browserstack.com/app-live/upload -F "file=@$apk_ipa_filepath"
