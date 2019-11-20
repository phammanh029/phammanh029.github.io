# usign media query in react styles component
const styles = {
  drawerWidth: {
    width: '50%',
    ['@media (min-width:780px)']: { // eslint-disable-line no-useless-computed-key
      width: '80%'
    }
  }
}
