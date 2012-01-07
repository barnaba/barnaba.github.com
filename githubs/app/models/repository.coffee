Spine = require('spine')

class Repository extends Spine.Model
  @configure 'Repository', 'name', 'url', 'pushed_at', 'fork'

module.exports = Repository
