require 'open-uri'
require 'nokogiri'

$jobs = Array.new([])

def createJob(title, company, url)
	puts title

	puts company

	puts url

	j = Job.where(title: title).take

	if j == nil
		j = Job.create(title: title, url: url)
	else
		j.title = title
		j.company = company
		j.url = url
		j.save
	end

	$jobs.push(j)

end

puts "---------POSTS---------"

document = open('https://twitter.com/authenticjobs')
content = document.read

parsed_content = Nokogiri::HTML(content)

# Get the divisions
posts = parsed_content.css('div#timeline').css('.tweet').css('.content').css('.card2').css('.js-macaw-cards-iframe-container')

puts posts.length


posts.each{|post|

	puts 'LINK: ' + post['data-card-url']
	puts ''
	puts 'extra info link: https://twitter.com' + post['data-full-card-iframe-url']
	puts ''

	document_two = open('https://twitter.com'+post['data-full-card-iframe-url'])
	content_two = document_two.read

	parsed_content_two = Nokogiri::HTML(content_two)
	
	title = "TITLE: " + parsed_content_two.css('.SummaryCard-content').css('.TwitterCard-title').inner_html

	puts title
	puts ''

	desc = "DESCRIPTION: " + parsed_content_two.css('.SummaryCard-content').css('.tcu-resetMargin').inner_html

	puts desc
	puts ''

	puts ''


}


