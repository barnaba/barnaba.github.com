require('lib/setup')

Spine = require('spine')
Repository = require('models/repository')
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
    Repository.fetch()

  render: =>
    @list.render(Repository.all())


module.exports = App
    
