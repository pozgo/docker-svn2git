### svn2git in a docker.

[![CircleCI Build Status](https://img.shields.io/circleci/project/pozgo/docker-svn2git/master.svg)](https://circleci.com/gh/pozgo/docker-svn2git)
[![GitHub Open Issues](https://img.shields.io/github/issues/pozgo/docker-svn2git.svg)](https://github.com/pozgo/docker-svn2git/issues)
[![GitHub Stars](https://img.shields.io/github/stars/pozgo/docker-svn2git.svg)](https://github.com/pozgo/docker-svn2git)
[![GitHub Forks](https://img.shields.io/github/forks/pozgo/docker-svn2git.svg)](https://github.com/pozgo/docker-svn2git)  
[![Stars on Docker Hub](https://img.shields.io/docker/stars/polinux/svn2git.svg)](https://hub.docker.com/r/polinux/svn2git)
[![Pulls on Docker Hub](https://img.shields.io/docker/pulls/polinux/svn2git.svg)](https://hub.docker.com/r/polinux/svn2git)  
[![](https://images.microbadger.com/badges/version/polinux/svn2git.svg)](http://microbadger.com/images/polinux/svn2git)
[![](https://images.microbadger.com/badges/license/polinux/svn2git.svg)](http://microbadger.com/images/polinux/svn2git)
[![](https://images.microbadger.com/badges/image/polinux/svn2git.svg)](http://microbadger.com/images/polinux/svn2git)

[Docker Image](https://registry.hub.docker.com/u/polinux/svn2git/) with svn2git. It's using tiny image provided by Alpine.  

[svn2git Project](https://github.com/nirvdrum/svn2git)  

Purpose of this image was to simplify the process of using svn2git.

### Usage

    docker run \
      -ti \
      --name svn2git \
      polinux/svn2git \
      svn2git <svn2git-commands>

Mount Volume into working directory

    docker run \
      -ti \
      --name svn2git \
      -v ${PWD}/workdir:/svn2git \
      polinux/svn2git \
      svn2git <svn2git-commands>

### Build

    docker build -t polinux/svn2git .

Usage (from svn2git repo)
-----

### Initial Conversion ###

There are several ways you can create a git repo from an existing
svn repo. The differentiating factor is the svn repo layout. Below is an
enumerated listing of the varying supported layouts and the proper way to
create a git repo from a svn repo in the specified layout.

1. The svn repo is in the standard layout of (trunk, branches, tags) at the
root level of the repo.

        $ svn2git http://svn.example.com/path/to/repo

2. The svn repo is NOT in standard layout and has only a trunk and tags at the
root level of the repo.

        $ svn2git http://svn.example.com/path/to/repo --trunk dev --tags rel --nobranches

3. The svn repo is NOT in standard layout and has only a trunk at the root
level of the repo.

        $ svn2git http://svn.example.com/path/to/repo --trunk trunk --nobranches --notags

4. The svn repo is NOT in standard layout and has no trunk, branches, or tags
at the root level of the repo. Instead the root level of the repo is
equivalent to the trunk and there are no tags or branches.

        $ svn2git http://svn.example.com/path/to/repo --rootistrunk

5. The svn repo is in the standard layout but you want to exclude the massive
doc directory and the backup files you once accidently added.

        $ svn2git http://svn.example.com/path/to/repo --exclude doc --exclude '.*~$'

6. The svn repo actually tracks several projects and you only want to migrate
one of them.

        $ svn2git http://svn.example.com/path/to/repo/nested_project --no-minimize-url

7. The svn repo is password protected.

        $ svn2git http://svn.example.com/path/to/repo --username <<user_with_perms>>

If this doesn't cooperate and you need to specify a password on the command-line:

        $ svn2git http://svn.example.com/path/to/repo --username <<user_with_perms>> --password <<password>>

8. You need to migrate starting at a specific svn revision number.

        $ svn2git http://svn.example.com/path/to/repo --revision <<starting_revision_number>>

9. You need to migrate starting at a specific svn revision number, ending at a specific revision number.

        $ svn2git http://svn.example.com/path/to/repo --revision <<starting_revision_number>>:<<ending_revision_number>>

10. Include metadata (git-svn-id) in git logs.

        $ svn2git http://svn.example.com/path/to/repo --metadata

The above will create a git repository in the current directory with the git
version of the svn repository. Hence, you need to make a directory that you
want your new git repo to exist in, change into it and then run one of the
above commands. Note that in the above cases the trunk, branches, tags options
are simply folder names relative to the provided repo path. For example if you
specified trunk=foo branches=bar and tags=foobar it would be referencing
http://svn.example.com/path/to/repo/foo as your trunk, and so on. However, in
case 4 it references the root of the repo as trunk.

### Repository Updates ###

As of svn2git 2.0 there is a new feature to pull in the latest changes from SVN into your
git repository created with svn2git.  This is a one way sync, but allows you to use svn2git
as a mirroring tool for your SVN repositories.

The command to call is:

        $ cd <EXISTING_REPO> && svn2git --rebase



Docker troubleshooting
======================

Use docker command to see if all required containers are up and running:
```
$ docker ps
```

Check logs of svn2git server container:
```
$ docker logs svn2git
```

Sometimes you might just want to review how things are deployed inside a running
 container, you can do this by executing a _bash shell_ through _docker's
 exec_ command:
```
docker exec -ti svn2git /bin/bash
```

History of an image and size of layers:
```
docker history --no-trunc=true polinux/svn2git | tr -s ' ' | tail -n+2 | awk -F " ago " '{print $2}'
```



## Author

Przemyslaw Ozgo (<linux@ozgo.info>)
