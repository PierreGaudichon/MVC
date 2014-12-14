{Controller, Model, View} = require "MVC"




module.exports.{{NAME}} =
class {{NAME}}Controller extends Controller

	Model: -> {{NAME}}Model
	Views: ->
		main: {{NAME}}View

	actions: ->

	initialize: (d) ->




class {{NAME}}Model extends Model

	defaults:

	initialize: (d) ->




class {{NAME}}View extends View

	events:

	createElement: (k) ->

	template: (k) ->



