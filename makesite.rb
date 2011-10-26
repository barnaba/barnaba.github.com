require 'rubygems'
require 'mechanize'
require 'erb'
require 'ruby-debug'

class Project
  attr_accessor :url, :title, :description, :is_fork, :anchor

  def initialize(elem)
    link = elem.search('h3 a').first
    @url, @title = 'http://github.com' + link.attributes['href'], link.text
    @anchor = "<a href=\"#{@url}\">#{@title}</a>"
    @description = elem.search('.description').first ? elem.search('.description').first.text : ""
    @is_fork = !(elem.attributes['class'].text =~ /fork/).nil?
  end

  def to_s
    puts [@url, @title, @description, @is_fork].join " | "
  end
end
  
agent = Mechanize.new
page = agent.get('http://github.com/barnaba')
projects = page.search('.public').map { |elem| Project.new(elem) }
projects = projects.select { |p| p.title != 'barnaba.github.com' }

content = File.read('index.html.erb')
template = ERB.new(content)
File.open("index.html", 'w') { |f| f.puts(template.result) }
