require 'webrick' #gem でインストールした「webrick」を呼び出し
server = WEBrick::HTTPServer.new({ #webrickのインスタンスを作成、serverという名前のローカル変数へ
  :DocumentRoot => '.',#ドメインの設定
  :CGIInterpreter => WEBrick::HTTPServlet::CGIHandler::Ruby,#このプログラムの翻訳は誰でどこです
  :Port => '3000',#情報の出入り口を設定（ポート）
  #初期値の設定
})
['INT', 'TERM'].each {|signal|
  Signal.trap(signal){ server.shutdown }
}
server.mount('/',WEBrick::HTTPServlet::ERBHandler,'new.html.erb')
server.mount('/test', WEBrick::HTTPServlet::ERBHandler, 'test.html.erb')
#Webサーバを起動した状態で(DocumentRootの値)/testというURLを送信すると,同じ階層にある,test.html.erbファイルを表示
#→./testというURLが送られる
server.mount('/indicate.cgi', WEBrick::HTTPServlet::CGIHandler, 'indicate.rb') #form内の値をindicateに送信
server.mount('/goya.cgi', WEBrick::HTTPServlet::CGIHandler, 'goya.rb')
server.start #サーバの起動
