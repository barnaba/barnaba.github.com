Spine = require('spine')
$ = Spine.$

window.load = (data) ->
  repos = data['repositories']

  repos = repos.sort (a,b) ->
    new Date(a['pushed_at']) < new Date(b['pushed_at'])

  now = new Date
  week_ago = new Date(now.setDate(now.getDate() - 7))
  $.each repos, (key, value) ->
    pushed = new Date(value['pushed_at'])

    Repository.create
      name: value['name'],
      url: value['url'],
      pushed_at: value['pushed_at'],
      fork: value['fork']
      description: value['description']
      new : pushed > week_ago

class Repository extends Spine.Model
  @configure 'Repository', 'name', 'url', 'pushed_at', 'fork', 'description', 'new'

  @url = "https://github.com/api/v2/json/repos/show/barnaba"

  @fetch = () ->
    $.getScript 'https://github.com/api/v2/json/repos/show/barnaba?callback=load'

module.exports = Repository


