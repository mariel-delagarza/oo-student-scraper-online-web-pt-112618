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

  def self.scrape_profile_page(profile_url)
    page = Nokogiri::HTML(open(profile_url))
    profile = {}

    links = profile_page.css(".social-icon-container").children.css("a").map{ |social| social.attribute('href').value}

    links.each do |link|
      if link.include?("linkedin")
        student[:linkedin] = link
      if link.include?("github")
        student[:github] = link
      if link.include?("blog")
    github
    blog
    profile_quote
    bio
    end
    profile
  end

end
