require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = []
    doc.css("div.roster-cards-container").each do |roster_card|
      roster_card.css(".student-card a").each do |student|
        name = student.css(".student-name").text
        location = student.css(".student-location").text
        profile_url = "#{student.attr('href')}"
        students << {name: name, location: location, profile_url: profile_url}
      end
    end
    students
  end

  def self.scrape_profile_page(student_page)
    page = Nokogiri::HTML(open(student_page))
    profile = {}

    links = page.css(".social-icon-container").children.css("a").map { |icon| icon.attribute('href').value}

    links.each do |link|
      if link.include?("linkedin")
        profile[:linkedin] = link
      elsif link.include?("github")
        profile[:github] = link
      elsif link.include?("blog")
        profile[:blog] = link
      else
        profile[:twitter] = link
      end
    end

    profile[:profile_quote] = page.css(".profile-quote").text if profile_page.css(".profile-quote")
    profile[:bio] = page.css("div.bio-content.content-holder div.description-holder p").text if profile_page.css("div.bio-content.content-holder div.description-holder p")

    profile
  end

end
