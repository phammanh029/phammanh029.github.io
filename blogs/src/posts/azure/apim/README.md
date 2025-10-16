# API management

# Blogs

https://azure.github.io/apim-lab/

## Data compression

```
<policies>
    <inbound>
        <set-variable name="gzipresponse" value="@(context.Request.Headers.GetValueOrDefault("Accept-Encoding", "null").Contains("gzip"))" />
    </inbound>
    <backend>
        <forward-request />
    </backend>
    <outbound>
        <choose>
            <when condition="@(context.Variables.GetValueOrDefault<bool>("gzipresponse"))">
                <set-header name="Content-Encoding" exists-action="override">
                    <value>gzip</value>
                </set-header>
            </when>
        </choose>
    </outbound>
</policies>
```

Rate limit by jwt token:
```
<rate-limit-by-key
                    calls="100"
                    renewal-period="60"
                    counter-key="@(context.Request.Headers.GetValueOrDefault("Authorization","").AsJwt()?.Subject)" />
```