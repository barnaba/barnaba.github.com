require('lib/setup')

Spine = require('spine')
Repository = require('models/repository')
#Repositories = require('controllers/repositories')
List = require('spine/lib/list')
Repository = require("models/repository")
$ = Spine.$

class App extends Spine.Controller
  el: $ '#projects'

  elements:
    '#items' : 'items'

  constructor: ->
    super
    @list = new List
      el: @items
      template: require('views/item')

    Repository.bind('refresh change', @render)

    asd = Repository.create
      name: "lol"
      url: "lol"
    asd = Repository.create
      name: "troll"
      url: "lol"

  render: =>
    @list.render(Repository.all())


module.exports = App
    
