[toc]

## proxy config 

+ website:https://goproxy.io/

### Go version >= 1.13, current latest:1.14
```
go env -w GO111MODULE=on
go env -w GOPROXY="https://goproxy.io,direct"

# Set environment variable allow bypassing the proxy for selected modules (optional)
go env -w GOPRIVATE="*.corp.example.com"
```
