# Ramda
## useWith: call each transformation function with each param coresponse, if args more than number of transform function => pass it directly
```
useWith(f, [g, h])(x, y, z) => f(g(x), h(y), z)
```
## converge: call each transformation function with params
```
converge(f, [g, h])(x, y, z) => f(g(x, y, z), h(x, y, z))
```

## either: return short circuit f(x) || g(x)
```
either(f, g)(x) => f(x) || g(x)
```
## or: return or operator 
```
or(x, y) => x || y
```
## flip: call function f with swap 2 first parameters
```
flip(f)(a, b, c, d) => f(b, a, c, d) (swap 2 first parameters)
```
## unapply
```
unapply(f)(a, b, c) => f([a, b, c])
```
## apply
```
apply(f, [a, b, c]) => f(a, b, c)
```
## complement
```
complement(f)(a) => !f(a)
```
## not
```
not(a) => !a
```

## nthArg
```
nthArg(2)(a, b, c) => b
```

## compose
```
compose(f, g)(x) => f(g(x))
```
## pipe
```
pipe(f, g) (x) => g(f(x))
```
## zip
```
zip([a, b], [c, d]) => [[a, c], [b, d]]
```
## zipObj
```
zipObj([a, b], [c, d]) => {a: c, b: d}
```
## zipWith zip with function, truncate length to shorter list
```
zipWith(f, [a, b], [c, d, e]) => [f(a, c), f(b, d)]
```

## partial
```
f(a, b, c, d) => f.lengh === 4
partial(f, [a, b])(x, y) => f(a, b)(x, y)
f(a,b).length === 2
```
## curry
```
curry = f => (a) => g => f(a)
```
```
f(a, b, c, d)
curry(f)(a, b)(c)(d) => f(a,b)(c)(d)
curry(f).length === 4
```
## curryN: curry function with specify number or arity

## construct: return curry of constructor type
```
class A{
    constructor(a, b);
};
const curryConstruct = construct(A);
const instance = curryConstruct(a, b);
```
## find
```
find(f)(items) => items.find(f)
```
## when
```
when(f, g)(x) => f(x)? g(x) : x 
```
