# Ruby on rails
## auto loading file
[auto load](https://guides.rubyonrails.org/v5.2/autoloading_and_reloading_constants.html)
auto load files in : autoload_paths variable
 ### default autoload_paths:
    - All subdirectories of app in the application and engines present at boot time. For example, app/controllers. They do not need to be the default ones, any custom directories like app/workers belong automatically to autoload_paths.

    - Any existing second level directories called app/*/concerns in the application and engines.

    - The directory test/mailers/previews.
## naming conventions
### General ruby conventions
    - class name are CamelCase
    - methods and variables are snake_case
    - method with ? with return a boolean
    - method with ! suffix mean one of two things: either method oeprarates destructively in some fashion. or it will raise and exception instead of failing.
 - in document ::method_name denotes a class method, while #method_name denotes an instance method
### Database
    - database table use snake_case. Table name are plural
    - column name use snake_case. But are generaly in singular
### Model
    - model class name use CamelCase
    - model files fo in app/models/#{singular_model_name}.db