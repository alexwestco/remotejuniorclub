require 'open-uri'
require 'nokogiri'

$jobs = Array.new([])


def createJob(title, description, url)

	j = Job.where(title: title).take

	if j == nil
		j = Job.create(title: title, description: description, url: url)
	else
		j.title = title
		j.description = description
		j.url = url
		j.save
	end

	$jobs.push(j)

end

puts "---------POSTS---------"

Job.destroy_all
websites = ['https://twitter.com/authenticjobs','https://twitter.com/StackDevJobs', 'https://twitter.com/dribbblejobs', 'https://twitter.com/hasjob', 'https://twitter.com/jobmote', 'https://twitter.com/jobmote', 'https://twitter.com/Jobspresso', 'https://twitter.com/nofluffjobs', 'https://twitter.com/remote_ok', 'https://twitter.com/wfhio' ,'https://twitter.com/workingnomads', 'https://twitter.com/weworkremotely']

websites.each{|website|
	document = open(website)
	content = document.read

	parsed_content = Nokogiri::HTML(content)

	# Get the divisions
	posts = parsed_content.css('div#timeline').css('.tweet').css('.content').css('.card2').css('.js-macaw-cards-iframe-container')


	posts.each{|post|

		
		url = post['data-card-url']

		document_two = open('https://twitter.com'+post['data-full-card-iframe-url'])
		content_two = document_two.read

		parsed_content_two = Nokogiri::HTML(content_two)
		
		title = parsed_content_two.css('.SummaryCard-content').css('.TwitterCard-title').inner_html


		description = "DESCRIPTION: " + parsed_content_two.css('.SummaryCard-content').css('.tcu-resetMargin').inner_html


		createJob(title, description, url)
	}

}


