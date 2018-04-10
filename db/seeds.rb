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


def scrape(website)

	document = open(website)
	content = document.read

	parsed_content = Nokogiri::HTML(content)

	# Get the divisions
	posts = parsed_content.css('div#timeline').css('.tweet').css('.content').css('.card2').css('.js-macaw-cards-iframe-container')
	tweet_texts = parsed_content.css('div#timeline').css('.tweet').css('.content').css('.js-tweet-text-container').css('.tweet-text')

	i = 0
	posts.each{|post|

		tweet_text = tweet_texts[i].inner_html

		url = post['data-card-url']

		document_two = open('https://twitter.com'+post['data-full-card-iframe-url'])
		content_two = document_two.read

		parsed_content_two = Nokogiri::HTML(content_two)
		
		title = parsed_content_two.css('.SummaryCard-content').css('.TwitterCard-title').inner_html


		description = "DESCRIPTION: " + parsed_content_two.css('.SummaryCard-content').css('.tcu-resetMargin').inner_html

		if website == 'https://twitter.com/authenticjobs'

			if tweet_text.include? "Junior"
				if tweet_text.include? "<s>#</s><b>remote</b>"
					createJob(title, description, url)
				end
			end
			

		elsif website == 'https://twitter.com/StackDevJobs'

			if tweet_text.include? "Junior"

				if tweet_text.include? "(Remote)"
					createJob(title, description, url)
					break
				end

				if tweet_text.include? "[Remote]"
					createJob(title, description, url)
					break
				end
				
			end

		elsif website == 'https://twitter.com/dribbblejobs'

			if tweet_text.include? "Junior"

				if tweet_text.include? "anywhere"
					createJob(title, description, url)
					break
				end

			end

		elsif website == 'https://twitter.com/hasjob'

			if tweet_text.include? "Junior"

				if tweet_text.include? "<s>#</s><b>Anywhere</b>"
					createJob(title, description, url)
					break
				end

			end

		elsif website == 'https://twitter.com/Jobspresso'

			if tweet_text.include? "Junior"
				createJob(title, description, url)
				break
			end

		elsif website == 'https://twitter.com/nofluffjobs'

			if tweet_text.include? "Junior"
				if tweet_text.include? "Fully remote job"
					createJob(title, description, url)
					break
				end
			end

		elsif website == 'https://twitter.com/remote_ok'

			if tweet_text.include? "Junior"
				createJob(title, description, url)
				break
			end

		elsif website == 'https://twitter.com/wfhio'

			if tweet_text.include? "Junior"
				
				if tweet_text.include? "[Anywhere]"
					createJob(title, description, url)
					break
				end
				
				if tweet_text.include? "[Anywhere*]"
					createJob(title, description, url)
					break
				end
				
			end

		end

		i = i + 1

		
	}

end



Job.destroy_all
all_websites = ['https://twitter.com/authenticjobs','https://twitter.com/StackDevJobs', 'https://twitter.com/dribbblejobs', 'https://twitter.com/hasjob', 'https://twitter.com/jobmote', 'https://twitter.com/Jobspresso', 'https://twitter.com/nofluffjobs', 'https://twitter.com/remote_ok', 'https://twitter.com/wfhio' ,'https://twitter.com/workingnomads', 'https://twitter.com/weworkremotely']
websites=['https://twitter.com/authenticjobs','https://twitter.com/StackDevJobs', 'https://twitter.com/dribbblejobs', 'https://twitter.com/hasjob', 'https://twitter.com/jobmote', 'https://twitter.com/Jobspresso', 'https://twitter.com/nofluffjobs', 'https://twitter.com/remote_ok', 'https://twitter.com/wfhio', 'https://twitter.com/workingnomads', 'https://twitter.com/weworkremotely']
websites.each{|website|
	scrape(website)
}


