require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students = []
    doc = Nokogiri::HTML open(index_url)
    #profile_url: doc.css(".student-card")[0].css("a").attribute("href").value
    #name: doc.css(".student-card")[0].css("a h4").text
    #location: doc.css(".student-card")[0].css("a p").text
    doc.css(".student-card").each{|student|
      students << {profile_url: student.css("a").attribute("href").value, name: student.css("a h4").text, location: student.css("a p").text}
    }
    return students
  end

  def self.scrape_profile_page(profile_url)
   doc = Nokogiri::HTML open(profile_url)
   #quote: doc.css(".vitals-text-container div").text
   #bio: doc.css(".details-container div.bio-block.details-block div div.description-holder p").text
   #twitter: doc.css(".social-icon-container a")[0].attribute("href").value
   #linkedin: doc.css(".social-icon-container a")[1].attribute("href").value
   #github: doc.css(".social-icon-container a")[2].attribute("href").value
   #blog: doc.css(".social-icon-container a")[3].attribute("href").value
   hash = {profile_quote: doc.css(".vitals-text-container div").text, bio: doc.css(".details-container div.bio-block.details-block div div.description-holder p").text}
   if doc.css(".social-icon-container a") != nil
     hash [:twitter] = doc.css(".social-icon-container a")[0].attribute("href").value
     hash [:linkedin] = doc.css(".social-icon-container a")[1].attribute("href").value
     binding.pry
     hash [:github] = doc.css(".social-icon-container a")[2].attribute("href").value
     hash [:blog] = doc.css(".social-icon-container a")[3].attribute("href").value
   end

   return hash
 end

end
