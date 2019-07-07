# InNerd.io

InNerd.io is a tool to find more about software developers. 

# Configuration

## GITHUB_API_ACCESS_TOKEN

By default GitHub limits requests for unauthenticated clients. In order to avoid this we need to: 

```
$ export GITHUB_API_ACCESS_TOKEN=your-token
```

prior launching the app. The token can be generated in [GitHub > Settings > Developer Settings > Personal Access Settings](https://github.com/settings/tokens). 
Generate one for development, another for production.
