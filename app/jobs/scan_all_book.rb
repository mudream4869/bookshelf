class ScanAllBook < ProgressJob::Base

  def perform
    update_stage("Scanning")
    @books = Book.select("*")
    update_progress_max(@books.length)

    now = DateTime.current

    puts "Scanning at " + now.to_s

    @books.each do |book|
      time_gap = 3.hour
      if book.last_update != nil and book.last_update + 2.week < now
        time_gap = 1.day
      end
      if (book.last_update == nil or book.last_update + 8.hour < now) and (book.last_scan == nil or book.last_scan + time_gap < now)
        @tag = nil
        if book.sitename == "zizaidu"
          @tag = scan_url_zizaidu(book.spoturl)
        elsif book.sitename == "hbooker"
          @tag = scan_url_hbooker(book.spoturl)
        elsif book.sitename == "sfacg"
          @tag = scan_url_sfacg(book.spoturl)
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

  def scan_url_qidian(url)
    require 'open-uri'
    require 'nokogiri'
    doc = Nokogiri::HTML(open(url))
    return doc.css('span[itemprop="dateModified"]').text.to_s
  end

  def scan_url_sfacg(url)
    require 'open-uri'
    require 'nokogiri'
    doc = Nokogiri::HTML(open(url))
    ret = doc.css('li').to_s
    return ret
  end


end
