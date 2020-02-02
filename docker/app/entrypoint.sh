#!/bin/bash

chmod -R 777 /work/surveycloud/bootstrap/chache
chmod -R 777 /work/surveycloud/storage
# cd /work/surveycloud/ && composer install

# 今後エラーになるようならdockerコンテナ作成時にnode_moduleを一旦削除する
# remove node_modules
# RUN rm -rf /work/surveycloud/node_modules

# npm install

echo "<?php phpinfo();" > /work/surveycloud/public/info.php # とりあえずphpが起動するかテスト
/usr/sbin/httpd -DFOREGROUND