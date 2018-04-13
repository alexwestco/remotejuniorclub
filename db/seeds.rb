require 'mechanize'

class Angellist
	URI = 'https://angel.co/login'

	def initialize
		@agent = Mechanize.new
		@page = @agent.get(URI)
		@agent.user_agent_alias = 'Windows Chrome'
	end

	def login

		# Log in to angel.co
		puts @page.uri
		form = @page.form_with :action => '/login'
		form.field_with(:id => 'user_email').value = 'alexcs02356@gmail.com'
		form.field_with(:id => 'user_password').value = '*super_secret_password*'

		@page = @agent.submit form
		gather_jobs()

	end

	def gather_jobs
		# Click on the Jobs tab (angel.co is good at detecting bots so we can't just throw in a url)	
		puts @page.uri

		@page = @agent.click(@page.link_with(:text => 'Jobs'))

		puts @page.uri

		number_of_jobs = @page.css('div#root').css('.page').css('.container').css('div#startups_content').css('.label-container')
		puts number_of_jobs.inner_html

	end

end


class StackOverflow
	URI = 'https://stackoverflow.com/jobs?sort=i&l=Remote&d=20&u=Km'

	def initialize
		
	end

	def gather_jobs
		document = open(URI)
		content = document.read

		parsed_content = Nokogiri::HTML(content)

		# Get the divisions
		posts = parsed_content.css('div#content').css('.inner-content').css('.content').css('.-row').css('.main').css('.listResults')

		i = 0
		posts.each{|post|

			puts post.inner_html

			#document_two = open('https://twitter.com'+post['data-full-card-iframe-url'])
			#content_two = document_two.read

			#parsed_content_two = Nokogiri::HTML(content_two)
			
			#title = parsed_content_two.css('.SummaryCard-content').css('.TwitterCard-title').inner_html


			#description = "DESCRIPTION: " + parsed_content_two.css('.SummaryCard-content').css('.tcu-resetMargin').inner_html

			#if website == 'https://twitter.com/authenticjobs'

				#if tweet_text.include? "Junior"
					#if tweet_text.include? "<s>#</s><b>remote</b>"
						#createJob(title, description, url)
					#end
				#end
				
			#end
		end

	end


end

StackOverflow.new.gather_jobs