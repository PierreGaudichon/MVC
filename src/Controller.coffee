{Model} = require "./Model"
{View} = require "./View"



module.exports.Controller =
class Controller


	# @private
	# @abstract
	Model: -> Model


	# @private
	# @abstract
	Views: ->


	# @private
	# @abstract
	actions: ->


	# @private
	actionsExec: {}


	# contains the Model and Views instances
	model: "new Model"
	views: {}


	# @param attr {Object}
	# @param init {Object}
	# @param contener {jQuery}
	# @param render=false {Boolean}
	#
	# @return [Controller]
	# TODO : ConsoleView
	constructor: ({attr, init, contener, render}) ->
		@actionsExec = @actions()
		M = @Model()
		@model = new M @, o.attr, init

		V = @Views()
		@views = {}
		for name, view of V
			@views[name] = new view @, @model, init
			if o.contener? and o.contener[name]
				@views[name].setContener $ o.contener[name]

		if o.render? and o.render then @render()
		@initialize()


	# @abstract
	initialize: ->


	# Set some properties to the object
	#
	# @see Model
	attr: (name, val) ->
		@model.attr name, val


	# TODO : [name]
	render: (name) ->
		if name?
			@views[name].render()
		else
			v.render() for n, v of @views

	# TODO : throw errors
	execute: (act, e, arg) ->
		if @actionsExec[act]?
			@actionsExec[act] e, arg
