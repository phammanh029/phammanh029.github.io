# ESlint

## common error

### Parsing error: Unexpected token ...

```
"parserOptions": {
        "ecmaVersion": 8,
        "ecmaFeatures": {
          "experimentalObjectRestSpread": true
        }
      },
npm i babel-eslint --save-dev
```

### Parsing error: Unexpected token = (for arrow function)

```
npm i babel-eslint --save-dev
```
add to your eslint
```
"parser": "babel-eslint" // to .eslintrc file
```
### Definition for rule 'no-import-assign' was not found
```
npm i eslint-plugin-import
```

add to your eslint

````
"plugins": [
          "import"
      ],
      ```
````
### Definition for rule 'no-dupe-else-if' was not found

### is missing in props validation
```
IxClickOut.propTypes = {
    children: PropTypes.any,
    onClickOut: PropTypes.func,
};
```
or 
```
import PropTypes from 'prop-types';
```