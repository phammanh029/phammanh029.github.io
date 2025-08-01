# K8s notes

## Dotnet

For dotnet, the way GC works may cause issues with the memory usage of the application. To mitigate this, you can set the `DOTNET_GCDynamicAdaptationMode`  to `1` in the environment variables of the container. This will allow the garbage collector to adapt dynamically to the memory usage patterns of the application.