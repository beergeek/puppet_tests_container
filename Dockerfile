FROM alpine:3.7

# skip installing gem documentation
RUN mkdir -p /usr/local/etc \
	&& { \
		echo 'install: --no-document'; \
		echo 'update: --no-document'; \
	} >> /usr/local/etc/gemrc

RUN apk add git bash
RUN apk add ruby
RUN apk add make gcc ruby-dev libc-dev
RUN gem update --system  --no-ri --no-rdoc
RUN gem install onceover --no-rdoc --no-ri
RUN gem install puppet-lint --no-rdoc --no-ri
RUN apk del binutils-libs binutils isl libgomp libatomic libgcc mpfr3 mpc1 libstdc++ gcc musl-dev libc-dev make libgmpxx gmp-dev ruby-dev
COPY puppetfile.sh evil.sh lint.sh check_hiera.rb control_repo_test_all.sh /root/

WORKDIR /var/tmp

CMD [ "/bin/bash" ]
