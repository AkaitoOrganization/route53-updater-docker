# Route 53 updater for DDNS-like home network access.
#
FROM alpine:latest
LABEL maintainer="Chris Barrett <chris@codesaru.com>"

COPY requirements.txt /
RUN apk --update add py3-pip \
	&& pip install --no-cache-dir -r requirements.txt \
	&& rm -rf /var/cache/apk/* \
    && rm -f /requirements.txt

RUN addgroup -S route53 \
    && adduser -G route53 -S -D route53
USER route53:route53

COPY main.py /

CMD [ "/usr/bin/python3", "-u", "/main.py" ]
