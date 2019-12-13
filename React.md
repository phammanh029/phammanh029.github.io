# Useful link:
- https://juliangaramendy.dev/use-promise-subscription


# cast to const for react css not as type
flexDirection: 'column' as const


## state
 - do not change state directly
 - the only time you can change dirrectly in in constructor initial
 - state update may be combine, asynchronous
 - setState should be access dirrectly to old state througt this.state, instead, use function setState((state, props)=> newStateObj)
 - setState can update dependently prop => not necesssary for copy prev if it is not necesary
 - do not call setState in constructor
 - should be useSideEffect in componentDidMount => to sure that component already mounted
 - unSubscription in componentUnMount
 - avoid assign props into state
 - setState in componentDidMount => imediately trigger rerender
 - componentDidUpdate not call for first inital render but other
 
# life cycle
- shouldComponentUpdate not call when first render or forceUpdate is call
