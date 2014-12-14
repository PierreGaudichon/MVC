MVC - Usage
===========


Introduction
------------

This file describe the usage of the MVC framework. In the first part, we will create an object, a magnet. And in the second part, we will use it.


Require, Exports
----------------

The **MVC** module exports what you need to create some objects.

 - A `Controller` and  `Model`, which must be extended before being used.
 - A `View` and its `jQueryView`, which, again, must be extended.
 - A `ConsoleView`, which is use on its own.

	{Controller, Model, jQueryView, ConsoleView} = require "MVC"

In each file, describing a MVC object, only the Controller is exported.

	module.exports.Magnet = Magnet =


Controller
----------

The Controller is the main object. It is the only one to be exported.

	class MagnetController extends Controller

The `Model`, `Views` properties are wrapped into functions to prevent them to be `undefined`. With that technique, you can savely put your Model and Views declaration below the Controller.

The `Model` attribute expose the model which is going to be used with this Controller.

		Model: -> MagnetModel

With the same idea, the Controller has several Views. You name them to be able to render them at differents times.

		Views: ->
			console: ConsoleView
			dom: MagnetView

`actions` are functions that can modify the Model. This property is wrapped into a function to keep track of the context (`this`).

		actions: ->

An action take two argument, the first `e` is the [jQuery event](http://api.jquery.com/category/events/event-object/) returned by the DOM (kinda).

`@attr` and `@render` are covered below (Usage section).

			flip: (e, rad = Math.PI/6) =>

				@attr.inc "orientation", rad
				@render()


The function to create the `MagnetController` object. Because `super()` is ugly.

		initialize: (d) ->
			@attr "orientation", Math.random() * Math.PI * 2


Model
-----

The model the Magnet is gonna use.

	class MagnetModel extends Model

Every properties tha magnet needs. Like `defaults` suggests every new Magnet will have an orientation of `0` (in rad) and be yellow.

		defaults:
			orientation: 0
			color: "#f1c40f" # yellow

The same as the controller.

		initialize: (d) ->

### Attr function

Die with errors. Accessibles in the controller and every view. Existance checked against `defaults`.

 - `@attr(name)`: get the value, if exists.
 - `@attr(name, val)`, set the value, if exists.
 - `@attr([names])`: get all values in a hash, if exists.
 - `@attr({names, vals})`: set all the values, if exists
 - `@attr.inc(name, val)`: increment `Number`, concat `String`, if `String` or `Number` and if exists.
 - `@attr.push(name, val)`: push at the end of the array, if an array.


Vi  - override
    - Model
    - Views
    - actions
    - initialize
  - use
    - render
    - attr
    - execute
  - constructor
    - contener
    - attr
    - render
    - init
- Model
  - override
    - defaults
    - initialize
- View
  - override
    - events
    - createElement
    - templateew
----

There is two differents kinds of views, `jQueryView` and `ConsoleView` (TODO :`CanvasView` or `SvGView`). A view depends on a `contener`, a jQuery object to be rendered inside, and an `element`, an other jQuery object which holds the actual view.

	class MagnetView extends jQueryView

`events` binds jQuery [events](http://www.w3.org/TR/DOM-Level-3-Events/#event-types-list) to selectors. The selector operate inside the `element`. The empty string target the `element` itself.

		events:
			"":
				"click": "flip"

Creates the `element`. Only fired on objet creation. The `k` argument is a [`Kup` instance](https://github.com/snd/kup) newly created.

		createElement: (k) ->
			k.div class: "magnet"

Templates populate the `element` when needed. As in `createElement`, the argument `k` is a Kup instance.

		template: (k) ->
			{orientation, color} = @attr ["orientation", "color"]
			@element.css
				"background-color": color
				"transform": "rotate(#{orientation}rad)"


Usage
-----

### Creation

	m = new Magnet

Each view has it's own contener. The key is the name of the view and the value a [selector](http://api.jquery.com/category/selectors/) or a jQuery object. If the view is a `jQueryView` and the contener isn't given, the view won't be created.

		contener:
			dom: "document"

Attributes for that Magnet.

		attr:
			color: "#c0392b" # red

If the views are rendered on creation.

		render: true

The init data pass into all `init` functions.

		init: null

### Methods

	m.render()
	m.attr()
	m.execute()
