:: Win Script
aws deploy create-deployment ^
    --application-name %1 ^
    --deployment-group-name %2 ^
    --deployment-config-name %3 ^
    --s3-location bucket=%4,key=%5,bundleType=%6 ^
    --description "Release of %5" ^
    --no-ignore-application-stop-failures ^
    --auto-rollback-configuration enabled=true,events=DEPLOYMENT_FAILURE,DEPLOYMENT_STOP_ON_ALARM ^
    --file-exists-behavior OVERWRITE
