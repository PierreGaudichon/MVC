{_, attr} = require "../src/attr"
{getOne, setOne, getSome, setSome, incrementOne, incrementSome} = _

coll =
	a: "foo"
	b: "bar"
	n: 0
	t: ["a", "b", "c"]

describe "One", ->

	it "should return the value", ->
		expect getOne coll, "a"
			.toEqual "foo"
		expect getOne coll, "a"
			.not.toEqual "bar"

	it "should set the value", ->
		setOne coll, "a", "0"
		expect getOne coll, "a"
			.toEqual "0"
		expect getOne coll, "a"
			.not.toEqual "foo"
		setOne coll, "a", "foo"


describe "Some", ->

	it "should return the value", ->
		expect getSome coll, ["a"]
			.toEqual a: "foo"
		expect getSome coll, ["a"]
			.not.toEqual a: "bar"
		expect getSome coll, ["a", "b"]
			.toEqual a: "foo", b: "bar"

	it "should set the value", ->
		setSome coll, a: "0", b: "1"
		expect getOne coll, "a"
			.toEqual "0"
		expect getOne coll, "b"
			.toEqual "1"
		setSome coll, a: "foo", b: "bar"


describe "IncrementOne", ->

	it "should add one", ->
		incrementOne coll, "n", 1
		expect getOne coll, "n"
			.toEqual 1
		setOne coll, "n", 0

	it "should concat", ->
		incrementOne coll, "a", "a"
		expect getOne coll, "a"
			.toEqual "fooa"
		setOne coll, "a", "foo"

	it "should push", ->
		incrementOne coll, "t", "lol"
		expect getOne coll, "t"
			.toEqual ["a", "b", "c", "lol"]
		setOne coll, "t", ["a", "b", "c"]


describe "IncrementSome", ->

	it "should increment some", ->
		incrementSome coll, ["a", "n", "t"], 1
		expect getSome coll, ["a", "n", "t"]
			.toEqual
				a: "foo1"
				n: 1
				t: ["a", "b", "c", 1]
		setSome coll,
			a: "foo"
			n: 0
			t: ["a", "n", "t"]

describe "attr", ->

	it "should get the value", ->
		expect attr coll, "a"
			.toEqual "foo"

	it "should set the value", ->
		setOne coll, "a", "b"
		expect attr coll, "a"
			.toEqual "b"
		setOne coll, "a", "foo"

	it "should get some values", ->
		expect attr coll, ["a", "b"]
			.toEqual
				a: "foo"
				b: "bar"

	it "should set some values", ->
		attr coll, a: "0", b: "1"
		expect attr coll, ["a", "b"]
			.toEqual
				a: "0"
				b: "1"
		attr coll, a: "foo", b: "bar"
