Tinytest.add "obj", (test) ->
  test.equal(obj(), {})
  test.throws((-> obj("one")), /missing value argument/)
  test.equal(obj("one", 1, "two", 2), {one: 1, two: 2})
  test.equal(obj("one", 1, "undef", undefined), {one: 1})
  test.equal(obj("undef", 1, "undef", undefined), {})
  test.equal(obj("one", 1, null, "two", 2), {one: 1, two: 2})
  test.equal(obj("one", 1, undefined, "two", 2), {one: 1, two: 2})
  test.throws((-> obj(3)), /invalid type/)
  test.throws((-> obj(true)), /invalid type/)
  test.throws((-> obj(->)), /invalid type/)
  test.equal(obj({}), {})
  test.equal(obj("undef", 1, {undef: undefined}), {})
  test.equal(
    obj("one", 1, {two: 2, three: 3}, "four", 4),
    {one: 1, two: 2, three: 3, four: 4}
  )
  test.equal(
    obj({one: 9}, "one", 8, {one: 1}),
    {one: 1}
  )
