# Vuejs
References: [vue cheatsheet](https://dev.to/adnanbabakan/vue-cheat-sheet)
## expression (not statement)
 ```
 {{age + 5}}
 ```
 ## raw html
 ```
 <span v-html='html-data'></span>
 ```
 ## v-binding
 ```
 <span v-bind:class='myclass'></span>
 <span :class='myClass></span>
 ```
 ## concat binding
 ```
 <span :class="myProp + 'something'">
 ```
 ## conditional binding
 ```
 <button :disabled="true"/>
 <button :disabled="arr.length > 6"/>
 <button :class="{red: true, blue:false}"/> => class = red
 ```
 ## two way binding (v-model)
```
<input v-model='name'/>
```

## events (v-on:)
Events are called when a specific action is performed on an element.
access all javascript events
@ are short form for v-on
```
<button v-on:click='myhandler'/>
<button @click='myhandler'/>
```
### event modifiers
Event modifiers are used to alter some behaviour of the event or have a more control on it.

Modifiers are added following by a . after the event.

So this is the structure v-on:event.modifier or @event.modifier.

Modifiers can also be chained to be performed at the respective order, like: @event.modifier-one.modifier-two
```
<!-- the click event's propagation will be stopped -->
<a v-on:click.stop="doThis"></a>
<!-- the submit event will no longer reload the page -->
<form v-on:submit.prevent="onSubmit"></form>
<!-- use capture mode when adding the event listener -->
<!-- i.e. an event targeting an inner element is handled here before being handled by that element -->
<div v-on:click.capture="doThis">...</div>
<!-- the click event will be triggered at most once -->
<a v-on:click.once="doThis"></a>
<!-- only trigger handler if event.target is the element itself -->
<!-- i.e. not from a child element -->
<div v-on:click.self="doThat">...</div>
<!-- the scroll event's default behavior (scrolling) will happen -->
<!-- immediately, instead of waiting for `onScroll` to complete  -->
<!-- in case it contains `event.preventDefault()`                -->
<div v-on:scroll.passive="onScroll">...</div>
```
### key modifiers
Listening to keyboards event is easy but detecting which key is pressed would need the key code. Vue has some modifiers in order to listen to a specific key when using keyboard events.

These modifiers can be used with any key events such as keydown or keyup
```
<input @keydown.enter="() => alert('Hey there!')"></input>

<input @keydown.tab="() => alert('Hey there!')"></input>
<input @keydown.ctrl.shift="() => alert('Hey there!')"></input>


```
## dynamic arguments
```
<div v-bind:[myArg]='myData'>
<div v-on:[myEvent] = 'doSomething'>
```
## computed properties
using computed props : 

```
let app = new Vue({
    el: '#app',
    data: {
        programs: 'c++, java'
    },
    computed: {
        programsArr () {
            return this.programs.split(',');
        }
    }
})
```
## watcher (use wath props to listen for prop changed)
## conditional rendering
```
<span v-if='true'></span>
<span v-else></span>
```
## render but hidden (v-show)
noted that v-show not support in template
## list rendering
```
<li v-for='(item, index) in items'>
{{item}}

</li>
```

## object rendering
```
v-for-object='(value, names, index) in obj'
```
## life cycle
### beforeCreate
Called synchronously immediately after the instance has been initialized, before data observation and event/watcher setup.

### created
Called synchronously after the instance is created. At this stage, the instance has finished processing the options which means the following have been set up: data observation, computed properties, methods, watch/event callbacks. However, the mounting phase has not been started, and the $el property will not be available yet.
### beforeMount
Called right before the mounting begins: the render function is about to be called for the first time.

Note: This hook is not called during server-side rendering.
### Mounted
Called after the instance has been mounted, where el is replaced by the newly created vm.$el. If the root instance is mounted to an in-document element, vm.$el will also be in-document when mounted is called.

Note: This hook is not called during server-side rendering.
### Before update
Called when data changes, before the DOM is patched. This is a good place to access the existing DOM before an update, e.g. to remove manually added event listeners.

Note: This hook is not called during server-side rendering, because only the initial render is performed server-side.

### Update
Called after a data change causes the virtual DOM to be re-rendered and patched.

The component’s DOM will have been updated when this hook is called, so you can perform DOM-dependent operations here. However, in most cases you should avoid changing state inside the hook. To react to state changes, it’s usually better to use a computed property or watcher instead.

Note: This hook is not called during server-side rendering.
### Before destroy
Called right before a Vue instance is destroyed. At this stage the instance is still fully functional.

Note: This hook is not called during server-side rendering.

### destroyed
Called after a Vue instance has been destroyed. When this hook is called, all directives of the Vue instance have been unbound, all event listeners have been removed, and all child Vue instances have also been destroyed.

Note: This hook is not called during server-side rendering.
## Global component registration
```
import Vue from 'vue';

Vue.component('my-component', require('/path/to/your/component'));
```

## scope component registration
```
import Vue from 'vue';

const myComponent = require('/path/to/your/component');

let app = new Vue({
    components: {
        myComponent
    }
});
```
## lazy load component
This method is pretty cool since it will not bundle your component with your main entry file thus your website will be loaded faster and only the needed components will be required.
```
import Vue from 'vue';

const myComponent = () => import('./components/myComponent ');

let app = new Vue({
    components: {
        myComponent 
    }
});
```
Bonus Tip: This will extract your components named by numbers from 0 and so on. If you are using webpack you can use a magic comment in order to change your components' file names like below:
## Component props

```
Vue.component('blog-post', {
  props: ['postTitle'],
  template: '<h3>{{ postTitle }}</h3>'
})


<blog-post post-title="hello!"></blog-post>

```
*Note*: When defining props it is better to define it using camelCase but when using it, use it as kebab-case. Although it is possible to use kebab-case defined props as camelCase in Vue but IDEs might get confused about it.

Your single file components can also have props:
## Named Slot
```
<div class="container">
  <header>
    <slot name="header"></slot>
  </header>
  <main>
    <slot></slot>
  </main>
  <footer>
    <slot name="footer"></slot>
  </footer>
</div>

<base-layout>
  <template v-slot:header>
    <h1>Here might be a page title</h1>
  </template>

  <p>A paragraph for the main content.</p>
  <p>And another one.</p>

  <template v-slot:footer>
    <p>Here's some contact info</p>
  </template>
</base-layout>
```
The templates with v-slot:slot-name will be placed in their respective slots defined in the component and other ones will be placed in <slot></slot> which is unnamed.

Note: An unnamed slot is actually accessible with the name default like below:
```
<span>
  <slot v-bind:user="user">
    {{ user.lastName }}
  </slot>
</span>
```
and using as:
```
<current-user>
  <template v-slot:default="slotProps">
    {{ slotProps.user.firstName }}
  </template>
</current-user>
```

## Mixin
```
// define a mixin object
export const myMixin = {
  created: function () {
    this.hello()
  },
  methods: {
    hello: function () {
      console.log('Hello from mixin!')
    }
  }
}
```
```
<script>
    import { myMixin } from './myMixin.js';
    export default {
        mixins: [myMixin]
    }
</script>
```
## Global mixin
```
Vue.mixin({
    methods: {
        sayHi() {
            alert('Salam!');
        }
    }
})

const app = new Vue({
    el: '#app'
});
```
## Custom directives
```
<script>
    export default {
        directives: {
            focus: {
                inserted: function (el) {
                    el.focus()
                }
            }
        }
    }
</script>
```
The focus directive will be available as v-focus and can be used like this:
```
<input v-focus />
```

## filters
Filters are simply used to alter a value and return it.
They can be used in both mustaches and v-bind directive.

To define a filter in a component you can de as below:
```
<script>
    export default {
        filters: {
            capitalize: function(value) {
                if (!value) return '';
                value = value.toString();
                return value.charAt(0).toUpperCase() + value.slice(1);
            }
        }
    };
</script>
```
Then the capitalize filter can be used as below:
```
<span>{{ msg | capitalize }}</span>
```
## Vue-router
### router mode
 - history
## Force re-rendering
```
this.$forceUpdate()
```
Keep that in mind that $ is necessary to use this method in your Vue instance.
And you better be notified that this won't update any computed property but only force the view of your component to be re-rendered.
