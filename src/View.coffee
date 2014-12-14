Kup = require "kup"
{isArray} = require "lodash"

module.exports.View =
class View

	# the rendered view is uptodate with the model
	uptodate: false
	contener: "jQuery"
	element: "jQuery"

	#events: "sel": click: "act"
	events: {}

	constructor: (@controller, @model, init) ->
		@uptodate = false

		k = new Kup
		@createElement k
		@element = $ k.htmlOut

		for sel, evts of @events
			for evt, act of evts
				act = [act] unless isArray act
				for a in act
					do(sel, a) =>
						@element.on evt, sel, (e) =>
							@controller.execute a, e, null

		@initialize init


	initialize: (d) ->


	createElement: (k) ->

	# Todo : remove element from old contener

	setContener: (@contener) ->
		@contener.append @element

	props: (name) -> @model.props name

	template: (k) ->

	render: ->
		unless @uptodate
			@uptodate = true
			k = new Kup()
			@template k
			@element.html k.htmlOut

	fill: ->
		@contener.empty()
		@render()
		@element.appendTo @contener
