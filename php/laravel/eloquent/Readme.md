# model
## fillable
use for mass assignment
## ward
use for remove from mass assignment

## model method vs property
```
// Category Model
public function posts()
{
    return $this->hasMany(Post::class);
}
// View. We can use
$category->posts->count();
// Or
$category->posts()->count();
```

for method: call every time
for property => call one time
```
$category->posts()->count(); => model -> relation -> query -> only count are return
$category->posts->count(); => model -> collection -> count collection (count return, keep collections)
```
## Service container for dependency injection

## using request
 - through injector
 ```
     public function update(\Illuminate\Http\Request $request, $id)
 ```
 - through helper
 ```
 request()
 ```
 - through Facade
 ```
 Request::
 ```
 ## helper and facade
 both work the same

## Tinker 
log query log
```
DB::listen(function ($query) { dump($query->sql); dump($query->bindings); dump($query->time); });
```