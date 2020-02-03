#!/bin/bash

chmod -R 777 ${ENV_DOUCMENT_ROOT}/${ENV_SRC_DIRECTORY}/bootstrap/cache
chmod -R 777 ${ENV_DOUCMENT_ROOT}/${ENV_SRC_DIRECTORY}/storage
# cd /work/surveycloud/ && composer install

# 今後エラーになるようならdockerコンテナ作成時にnode_moduleを一旦削除する
# remove node_modules
# RUN rm -rf /work/surveycloud/node_modules

# npm install

echo "<?php phpinfo();" > ${ENV_DOUCMENT_ROOT}/${ENV_SRC_DIRECTORY}/public/info.php # とりあえずphpが起動するかテスト
/usr/sbin/httpd -DFOREGROUND