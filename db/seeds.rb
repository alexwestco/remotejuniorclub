require 'mechanize'
require 'google/apis/gmail_v1'
require 'googleauth'
require 'googleauth/stores/file_token_store'

require 'fileutils'

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
	URI = 'https://stackoverflow.com/jobs?l=remote&d=20&u=Km&sort=p'

	def initialize
		
	end

	def gather_jobs
		document = open(URI)
		content = document.read

		parsed_content = Nokogiri::HTML(content)

		# Get the divisions
		posts = parsed_content.css('div#content').css('.inner-content').css('.content').css('.-row').css('.main').css('.listResults').css('.-job-summary')

		posts.each do |post|
			#puts post.inner_html
		end

		puts posts[0].css('.-title').css('.job-link').inner_html
		puts posts[0].css('.-company').css('.-name').inner_html
		puts posts[0].css('.-title').inner_html
		puts posts.length
	end


end


class Gmail

	URI = "https://accounts.google.com/signin/v2/identifier?service=mail&passive=true&rm=false&continue=https%3A%2F%2Fmail.google.com%2Fmail%2F&ss=1&scc=1&ltmpl=default&ltmplcache=2&emr=1&osid=1&flowName=GlifWebSignIn&flowEntry=ServiceLogin"

	def initialize
		@agent = Mechanize.new
		@page = @agent.get(URI)
		login()

	end

	def login

		puts "Starting login..."

		@page = @agent.get("https://accounts.google.com/signin/v2/identifier?service=mail&passive=true&rm=false&continue=https%3A%2F%2Fmail.google.com%2Fmail%2F&ss=1&scc=1&ltmpl=default&ltmplcache=2&emr=1&osid=1&flowName=GlifWebSignIn&flowEntry=ServiceLogin")

		# Log in to Gmail
		#puts @page.uri
		form = @page.forms.first
		form.Email = 'remotejuniorclub@gmail.com'
		@page = @agent.submit form


		#puts @page.uri
		form = @page.forms.first
		form.field_with(:type => 'password').value = 'MLZeEgeX_dandin1994'
		@page = @agent.submit form

		#puts @page.uri

		puts "Logged in successfully!"

		gather_jobs()
		
	end

	def gather_jobs

		puts "In gather_jobs()"
		puts @page.uri

		document = open(@page.uri)
		content = document.read

		parsed_content = Nokogiri::HTML(content)
		puts parsed_content
		

		# Get the divisions
		emails = parsed_content.css("div#:3f.yW")

		puts emails

		#posts.each do |post|
			#puts post.inner_html
		#end

		#puts posts[0].css('.-title').css('.job-link').inner_html
		#puts posts[0].css('.-company').css('.-name').inner_html
		#puts posts[0].css('.-title').inner_html
		#puts posts.length
	end

end




class GmailAPI
	OOB_URI = 'urn:ietf:wg:oauth:2.0:oob'
	APPLICATION_NAME = 'Gmail API Ruby Quickstart'
	CLIENT_SECRETS_PATH = 'client_secret.json'
	CREDENTIALS_PATH = File.join(Dir.home, '.credentials',
	                             "gmail-ruby-quickstart.yaml")
	SCOPE = Google::Apis::GmailV1::AUTH_GMAIL_READONLY

	def initialize
		# Initialize the API
		service = Google::Apis::GmailV1::GmailService.new
		service.client_options.application_name = APPLICATION_NAME
		service.authorization = authorize

		# Show the user's labels
		user_id = 'me'
		result = service.list_user_labels(user_id)

		puts "Labels:"
		puts "No labels found" if result.labels.empty?
		result.labels.each { |label| puts "- #{label.name}" }


	end

	def authorize
	  FileUtils.mkdir_p(File.dirname(CREDENTIALS_PATH))

	  client_id = Google::Auth::ClientId.from_file(CLIENT_SECRETS_PATH)
	  token_store = Google::Auth::Stores::FileTokenStore.new(file: CREDENTIALS_PATH)
	  authorizer = Google::Auth::UserAuthorizer.new(
	    client_id, SCOPE, token_store)
	  user_id = 'default'
	  credentials = authorizer.get_credentials(user_id)
	  if credentials.nil?
	    url = authorizer.get_authorization_url(
	      base_url: OOB_URI)
	    puts "Open the following URL in the browser and enter the " +
	         "resulting code after authorization"
	    puts url
	    code = gets
	    credentials = authorizer.get_and_store_credentials_from_code(
	      user_id: user_id, code: code, base_url: OOB_URI)
	  end
	  credentials
	end

	
end



GmailAPI.new