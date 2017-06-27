# 初期設定
'''
//①ビルド
$ docker-compose build
//②起動
$ docker-compose up -d
//③DBセットアップ
$ docker-compose run mel-exam ruby db_setup.rb
'''

# サーバー起動
'''
$ docker-compose run mel-exam ruby ruby/greeter_server.rb
'''

#クライアント起動
'''
$ docker-compose run mel-exam ruby ruby/greeter_client.rb
'''