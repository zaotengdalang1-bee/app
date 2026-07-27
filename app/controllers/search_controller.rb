class SearchController < ApplicationController
  def search
    require "open-uri"
    require "Nokogiri"


    url = params[:url]
   # URLを指定する
   # url="https://www.kobe-np.co.jp/news/richa/koutsuujiko/202605/0020340176.shtml"

   if url.present?
     # urlが存在する場合

     # htmlを取得する
     html=URI.open(url)

     # htmlをパースする
     doc=Nokogiri::HTML(html)

      # puts doc

      # xpathを使って要素を取得する

      # タイトルを取得する
      doc.xpath("//title").each do |title|
        @tITLE=title.text.strip
        @message1 = "#{@tITLE}"
      end

     # 日時を取得する   本文と被るのでコメントアウト

     @time=[] # 配列を初期化


     @time=doc.xpath('//time [@class="meta-time"]').first&.text&.strip

       # @tIME=time.text.strip

       # @time << time.text.strip

       @message2 = "#{@time}"

   end

     # 本文を取得する

     @messages = [] # 配列を初期化

     doc.xpath('//div[@class="article-body cXenseParse"]').each do |div|
      div.xpath(".//p").each do |p|
        @messages << p.text.strip
      end
    end
  end
end
# end
