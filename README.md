# 初期設定
'''
//①移動
$ cd ../mel_exam
//②ビルド
$ docker-compose build
//③起動
$ docker-compose up -d
//④DBセットアップ
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