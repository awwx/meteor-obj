# obj

Easily create plain objects with computed keys.

```
> obj("a" + 1, "one", "a" + 2, "two")
{a1: one, a2: two}
```

Mongo has a powerful and expressive query and update language based on
JSON.  For example, the following selects all documents where the
`memos` field contains an array whose first element is a subdocument
which has a field named `by` with the value "shipping":

```
Inventory.find({"memos.0.by": "shipping"})
```

However, in JavaScript the `{...}` syntax doesn’t allow expressions to
be used as keys.  If you wanted to use a variable `i` for the array
index instead of a literal `0`, you couldn’t say:

```
{"memos." + i + ".by": "shipping"}
```

because this is a syntax error in JavaScript.

Instead, you’d need to construct an object to pass to `find`:

```
var o = {};
o["memos." + i + ".by"] = "shipping";
Inventory.find(o);
```

This can more easily be done with `obj`:

```
Inventory.find(obj("memos." + i + ".by", "shipping"))
```

The argument list mirrors how you would want to be able to use `{...}`
if you could.  Thus

```
{k1: v1, k2: v2, k3: v3}
```

is the same as

```
obj("k1", v1, "k2", v2, "k3", v3)
```

with also allowing the keys to be expressions if needed.

As an added convenience, `obj` also accepts objects as arguments, and
their properties are copied onto the result.  Thus saying
`obj(o1, o2, o3)` is similar to using Underscore’s
[extend](http://underscorejs.org/#extend) with an empty source object
like this: `_.extend({}, o1, o2, o3)`.

This allows properties to be copied from a source object and then
extended / overridden with specific properties:

```
obj(config, "safe", true)
```

or for defaults to be specified first:

```
obj("mode", "local", config)
```


## API

### obj

**obj([object | key, value]...)** &nbsp; *Anywhere*

`obj` constructs and returns a new object.

It iterates through the arguments.  If the current argument is a
string, it and the next argument is added to the result as a property.

If the curent argument is an object, its properties are added to the
result.

Later properies override earlier ones.

A `null` or `undefined` argument is treated like an empty object (that
is, it is skipped).  This allows an “object” variable to be passed to
`obj`, but to permit it to be `null` or `undefined`.


## Special Treatment of `undefined` Property Values

Objects with properties that have a value of `undefined` are not valid
JSON, and `undefined` is not an [EJSON-compatible
value](http://docs.meteor.com/#ejson).  When stringified, properties
with an `undefined` value are omitted:

```
> EJSON.stringify({a: 1, b: undefined, c: 2})
"{a: 1, c: 2}"
```

This can cause confusion because A) a value sent from the client to
the server or vice versa will arrive as a different object than the
one sent, and B) two object that look the same when stringified will
not compare as equal with `EJSON.equals`.

To avoid this confusion, input properties with a value of `undefined`
are treated specially: rather than the key being added to the result,
instead the key isn’t added at all, or it is deleted if it is already
present.

What this means in practice is that if you stringify and then parse
the object returned by `obj` (as what happens if the object is sent
between the client and server back), you’ll get the same object as the
original object:

```
> obj("a", 1, "b", undefined, "c", 2)
{a: 1, c: 2}
> EJSON.parse(EJSON.stringify(obj("a", 1, "b", undefined, "c", 2)))
{a: 1, c: 2}
```


## Donate

If you find this package is valuable to you, an easy and effective way
to say “thank you” is to donate through
[Gittip](https://www.gittip.com/awwx/).  A weekly contribution of
25&cent; corresponds to $13 a year.

[Gittip](https://www.gittip.com/about/faq.html) is a platform for
sustainable crowd-funding.

Help build an ecosystem of well maintained, quality Meteor packages by
joining the
[Gittip Meteor Community](https://www.gittip.com/for/meteor/).