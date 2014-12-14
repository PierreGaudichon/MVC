{pick, isArray, isString, isNumber, isPlainObject} = require "lodash"

attr = (coll, n, v) ->
	if isString(n) and v?
		setOne coll, n, v
	else if isString(n) and not v?
		getOne coll, n
	else if isArray(n)
		getSome coll, n, v
	else if isPlainObject(n)
		setSome coll, n, v
	else
		throw new Error "Attr - (#{n}) can't be resolved."


attr.inc = (coll, n, v) ->
	if isString(n)
		incrementOne coll, n, v
	else if isArray(n)
		isPlainObject coll, n, v
	else
		throw new Error "Attr.inc - (#{n}) can't be resolved."


getOne = (coll, n) ->
	if coll[n]?
		coll[n]
	else
		throw new Error "No #{n} in collection. Can't get."


setOne = (coll, n, v) ->
	if coll[n]?
		coll[n] = v
	else
		throw new Error "No #{n} in collection. Can't set."
	null


getSome = (coll, names) ->
	pick coll, names


setSome = (coll, hash) ->
	for n, v of hash
		setOne coll, n, v


incrementOne = (coll, name, val) ->
	g = getOne coll, name
	if isArray g
		g.push val
	else if isString(g) or isNumber(g)
		g += val
	else
		throw new Error "#{n} is not an Array, Number or String. "
	setOne coll, name, g


incrementSome = (coll, names, val) ->
	for name in names
		incrementOne coll, name, val


module.exports =
	attr: attr
	_: {attr, getOne, setOne, getSome, setSome, incrementOne, incrementSome}

