#!/bin/bash
export GH_CHK_IN_APP_ID=$1
export GH_CHK_IN_INSTALLATION_ID=$2
echo "$3" >> /temp.private-key.pem
export GH_CHK_IN_PRIVATE_KEY_FILE=/temp.private-key.pem

name=$DRONE_STAGE_NAME
head_sha=$DRONE_COMMIT_SHA
details_url=$DRONE_SYSTEM_PROTO://$DRONE_SYSTEM_HOSTNAME/$DRONE_REPO/$DRONE_STAGE_NUMBER/$DRONE_STEP_NUMBER
stage_status="completed" # Can be 'queued', 'in_progress' or 'completed'
repo=$DRONE_REPO
started_at=$(date -d @$DRONE_BUILD_STARTED +'%Y-%m-%dT%H:%M:%SZ')
completed_at=$(date -d @$DRONE_BUILD_FINISHED +'%Y-%m-%dT%H:%M:%SZ')
conclusion=$DRONE_BUILD_STATUS
title="Drone Status: $conclusion"
summary="Commit: [$(echo $DRONE_COMMIT | awk '{print substr($0,1,7)}')]($DRONE_COMMIT_LINK)\n> $DRONE_COMMIT_MESSAGE\n- **Triggered on:** $DRONE_BUILD_EVENT\n- **Author:** $DRONE_COMMIT_AUTHOR <$DRONE_COMMIT_AUTHOR_EMAIL>\n- **Failed Steps:** $DRONE_FAILED_STEPS"
output='{"title":"'$title'","summary":"'$summary'","text":"Made with ♡ by @joxcat, using https://github.com/webknjaz/check-in."}'

check-in \
  --repo-slug=$repo \
  --name=$name \
  --details-url=$details_url \
  --status=$stage_status \
  --conclusion=$conclusion \
  --started-at=$started_at \
  --completed-at=$completed_at \
  --user-agent="Joxcat's Drone CICD" \
  --output="$output" \
  post-check --head-sha="$head_sha"