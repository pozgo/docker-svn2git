FROM alpine:3.5

RUN \
  apk add --update git git-svn perl-git-svn git-perl subversion ruby && \
  rm -rf /var/cache/apk/* && \
  gem install svn2git --no-ri --no-rdoc
