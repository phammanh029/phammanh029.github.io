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


# react select for large list item
`class MenuList extends Component {
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
}`

`<Select {...opts} components={{ MenuList }}/>`
