Spine = require('spine')
List = require('spine/lib/list')
Repository = require("models/repository")
$ = Spine.$

class Repositories extends Spine.Controller
  el : $('#projects')

  elements:
    '#items': 'items'

  constructor: ->
    super
    @list = new List
      el: @items
      template: require('views/item')

    Repository.bind('refresh change', @render)

  render: =>
    @list.render(Repository.all())
    
module.exports = Repositories
