# Dockerfile for testing Puppet control repos

All tests use `/var/tmp` as the root for testing, so map a valume containing your control repo to that directory.

```shell
docker run -it -v $(pwd):/var/tmp --name test --rm beergeek/puppet5.5.2:0.1.0
```
