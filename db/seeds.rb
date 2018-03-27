require 'open-uri'
require 'nokogiri'


$jobs = Array.new([])

def createJob(title, company, url)
	puts title

	puts company

	puts url

	# Check if the job already exists in the database. We will pretend that names combined with companies are unique

	j = Job.where(title: title).take

	if j == nil
		j = Job.create(title: title, company: company, url: url)
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

puts parsed_content

# Get the divisions
posts = parsed_content.css('div#fighter-rankings').css('div#ranking-lists').css('.ranking-list')

divisions.each{|division|
	

}
