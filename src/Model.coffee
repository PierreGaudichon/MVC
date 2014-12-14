
{attr} = require "./attr"

module.exports.Model =
class Model

	defaults: {}
	attrs: {}

	constructor: (@controller, obj, init) ->
		@attrs = {}
		@setAll @defaults
		@setAll obj
		@initialize init

	initialize: ->

	attr: (name, val) ->
		attr @attrs, name, val
		for view in @controller.views
			view.uptodate = false
