require 'mechanize'
require 'yaml'

# コマンドライン引数が2個ないとエラー
if(ARGV.size < 2) then
	STDERR.puts("問題番号とファイル名を指定してください") 
	exit(0)
end

# 設定情報を読み込む
config = YAML.load_file("config.yml")
username = config["userid"]
password = config["password"]
language = config["language"]
url = config["url"]

agent = Mechanize.new
# Atcoderにログインする
page = agent.get(url+"login#")
form = page.forms[0]
form.field_with(:name => 'name').value = username
form.field_with(:name => 'password').value = password
form.submit

# 問題一覧を取得する
submit_urls = []
page = agent.get(url+"assignments")
page.links.each do |link|
	submit_urls.push(link.href.to_s) if(link.href.to_s.include?("submit?task_id="))
end

#指定の問題ページにコードを提出
if(ARGV[0].to_i > submit_urls.size) then
	STDERR.puts("指定の問題番号は存在しません")
	exit(0)
end

if(File.exist?(ARGV[1]) == false) then
	STDERR.puts("指定のファイルが存在しません")
	exit(0)
end

taskid = submit_urls[ARGV[0].to_i-1][16,submit_urls[ARGV[0].to_i-1].size]
page = agent.get(url+submit_urls[ARGV[0].to_i-1])
form = page.forms[0]
form.field_with(:name => 'language_id_'+taskid).value = language
f = open(ARGV[1])
form.field_with(:name => 'source_code').value = f.read
f.close
form.submit
