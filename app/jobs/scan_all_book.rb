class ScanAllBook < ProgressJob::Base

  def perform
    update_stage("Scanning")
    @books = Book.select("*")
    update_progress_max(@books.length)

    now = DateTime.current

    puts "Scanning at " + now.to_s

    @books.each do |book|
      if book.last_scan == nil or book.last_scan + 1.second < now
        @tag = nil
        if book.sitename == "zizaidu"
          @tag = scan_url_zizaidu(book.spoturl)
        elsif book.sitename == "hbooker"
          @tag = scan_url_hbooker(book.spoturl)
        elsif book.sitename == "uu"
          @tag = scan_url_uu(book.spoturl)
        elsif book.sitename == "qidian"
          @tag = scan_url_qidian(book.spoturl)
        end

        if @tag != nil
          book.last_scan = now
          if @tag != book.scan_tag
            book.scan_tag = @tag
            book.last_update = now
            puts @tag
          end
          book.save
        end
      end
      update_progress
    end

  end
private

  def scan_url_zizaidu(url)
    require 'open-uri'
    require 'nokogiri'
    doc = Nokogiri::HTML(open(url))
    return doc.css('a').length.to_s
  end

  def scan_url_hbooker(url)
    require 'open-uri'
    require 'nokogiri'
    doc = Nokogiri::HTML(open(url))
    return doc.css('span.time-update').text.to_s
  end

  def scan_url_uu(url)
    require 'open-uri'
    require 'nokogiri'
    doc = Nokogiri::HTML(open(url))
    puts doc
    return doc.css('div.shijian').length
  end

  def scan_url_qidian(url)
    require 'open-uri'
    require 'nokogiri'
    doc = Nokogiri::HTML(open(url))
    return doc.css('span[itemprop="dateModified"]').text.to_s
  end


end
