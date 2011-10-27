require 'rubygems'
require 'erb'
require 'ruby-debug'
require 'wrest'
require 'yaml'

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

class SiteConfig
  def initialize(path)
    config = YAML.load_file(path)
    config.each do |key, value| 
      instance_variable_set("@#{key}", value)
      self.class.__send__(:attr_accessor, key)
    end
  end
end

config = SiteConfig.new('site.yml')
  
projects = ('http://github.com/api/v2/json/repos/show/barnaba'.to_uri.get.deserialise)['repositories']
projects.sort! {|a, b| Date.parse(b['pushed_at']) - Date.parse(a['pushed_at'])}
projects = projects.select { |p| not config.ignored.include? p['name'] }

content = File.read('index.html.erb')
template = ERB.new(content)
File.open("index.html", 'w') { |f| f.puts(template.result) }
