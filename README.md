# Dockerfile for testing Puppet control repos
This image is for testing Puppet control repos. The format of the repo must adhere to the [best practises](https://github.com/puppetlabs/best-practices/blob/master/control-repo-contents.md). The control repo must be initialised for [Onceover](https://github.com/dylanratcliffe/onceover) testing.

All tests use `/var/tmp` as the root for testing, so map a volume containing your control repo to that directory.

The following tests are perform:

* Puppetfile checks (`/root/puppetfile.sh`)
* Hiera checks for keys matching `['variables','profile','puppet_enterprise','pe_r10k']` (`/root/check_hiera.rb`)
* Security checks for the `file()` function and deprecation checks fo the `create_resources()` function (`/root/evil.sh`)
* Linting of Roles and Profiles (`/root/lint.sh`)
* Oncever tests (runs `onceover run spec`)

All these tests are done via `/root/control_repo_test_all.sh`. To run all test perform:

```
docker run -it -v $(pwd):/var/tmp --name test --rm \ 
beergeek1679/puppet_cntl_repo_tester:0.1.0
```

Each script can be run individually if required, such as:

```
docker run -it -v $(pwd):/var/tmp --name test --rm \
beergeek1679/puppet_cntl_repo_tester:0.1.0 /root/puppetfile.sh
```

If you have a test `Puppetfile` you can still use this image via:

```
docker run -it -v $(pwd):/var/tmp --name test --rm \
beergeek1679/puppet_cntl_repo_tester:0.1.0 onceover run spec \
--puppetfile spec/Puppetfile_ext
```

