require 'rubygems'
require 'mechanize'
require 'ruby-debug'
  
agent = Mechanize.new
page = agent.get('http://github.com/barnaba')
projects = page.search('.public')
project_list =  []
once = true
projects.each do |project|
  p = project.search('h3 a').first
  name, href = p.text, p.attributes['href']
  next if name == "barnaba.github.com"
  project_link = ''
  project_link += " <a href=\"http://github.com#{href}\">#{name}</a>"

  if once 
    once = false
    project_link += ' <span class="label success">New</span>'
  end

  if project.attributes['class'].text =~ /fork/
    project_link += ' <span class="label warning">Fork</span>'
  end

  description = project.search('.description').first
  unless description.nil?
    project_link += " <span class=\"description\">#{description.text}</span>"
  end

  project_list << "<li> #{project_link} </li>"
end

puts <<doc
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN"
    "http://www.w3.org/TR/html4/strict.dtd">
<html lang="en">
  <head>
    <meta http-equiv="content-type" content="text/html; charset=utf-8">
    <title>barnaba</title>
    <link rel="stylesheet" href="http://twitter.github.com/bootstrap/1.3.0/bootstrap.min.css">
    <style type="text/css">
    body {
      padding-top : 10%;
    }
    #linkspam {
      text-align: right;
      list-style-type: none;
      margin-right: 1em;
    }

    #linkspam li {
      background-position: 100% .4em;
      padding-right: .6em;
    }
    </style>
  </head>
  <body>
    <div class="container">
        <div class="span-one-third">
        <ul id="linkspam">
          <li><a rel="author" href="https://profiles.google.com/BarnabaTurek"> <img src="http://www.google.com/images/icons/ui/gprofile_button-44.png" width="36" height="36"> </a></li>
          <li><a rel="author" href="http://www.reddit.com/r/barnaba"> <img src="http://www.reddit.com/static/blog_snoo.gif" width="36" height="49"> </a></li>
          <li><a href="http://www.twitter.com/barnex"><img src="http://twitter-badges.s3.amazonaws.com/t_logo-c.png" alt="Follow barnex on Twitter"/></a></li>
        </ul>
        </div>
      <div class="row">
        <div class="span-one-third">
          <h1 class="centered">Barnaba Turek</h1>
          <h2> <a href="http://github.com/barnaba">My projects</a> </h1>
          <ul>
          #{project_list.join("\n")}
          </ul>
        </div>
      </div>
    </div>
  </body>
</html>
doc

