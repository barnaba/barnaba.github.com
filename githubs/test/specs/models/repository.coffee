describe 'Repository', ->
  Repository = null
  
  beforeEach ->
    class Repository extends Spine.Model
      @configure 'Repository'
  
  it 'can noop', ->
    