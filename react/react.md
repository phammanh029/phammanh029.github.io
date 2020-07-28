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

# usign media query in react styles component
const styles = {
  drawerWidth: {
    width: '50%',
    ['@media (min-width:780px)']: { // eslint-disable-line no-useless-computed-key
      width: '80%'
    }
  }
}


 # update from props 
 useEffect if prop changed

# react-select update default value by capture defaultValue changed

# react select for large list item
```
class MenuList extends Component {
    render() {
        const { options, children, maxHeight, getValue } = this.props;
        const [value] = getValue();
        const initialOffset = options.indexOf(value) * height;
        // console.log(maxHeight);
        return (
            <List
                height={Math.min(maxHeight, height * children.length)}
                itemCount={children.length}
                itemSize={height}
                initialScrollOffset={initialOffset}
            >
                {({ index, style }) => <div style={style}>{children[index]}</div>}
            </List>
        );
    }
}

<Select {...opts} components={{ MenuList }}/>
```


# React.memo
memorize result of the component and only rerender if props  changed

# useEffect
clearTimeout by return a function that excute clearTimeout
```
useEffect(()=> {
    const timer = setTimeout(...);
    return ()=> { clearTimeout(timer)};
})
```

# using react router along with function component connect cause history is undefined
```
import { withRouter } from 'react-router';
export default withRouter(connect(null, {logoutUser})(NavBar));
```