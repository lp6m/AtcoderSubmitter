### AtcoderSubmitter
#Atcoderに自動でコードを提出するスクリプト
スクレイピングのためのライブラリMechanizeを利用しているので`gem install mechanize`でライブラリをインストールしてください  

#使い方
config.ymlにユーザ名,パスワード,コンテストページのURL,使用言語の設定をする  
main.rb,config.yml,および提出するコードは同じディレクトリにないといけません  
`ruby main.rb 1 1.c` これで1問目に1.cのコードを提出します  

改変したら便利に使えるようになるかも.  