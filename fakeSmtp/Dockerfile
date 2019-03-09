# 
# docker build -t mplescano/fakesmtp:2.0 .
# docker run -it -p 2025:2025 --rm mplescano/fakesmtp:2.0
FROM mplescano/java-debian:7.80.15.jdk

MAINTAINER mplescano@

ADD assets /assets

RUN /assets/setup.debian.sh

EXPOSE 2025

VOLUME /var/mail

# Port	Properties
# 25	Standard. Support Insecure SMTP and SMTP over TLS. * Linux could already take this port in default dist.
# 80	Open on most firewalls* because this port is used for talking to web servers to get web pages. Supports insecure SMTP and SMTP over TLS
# 465	Standard port for SMTP over SSL. (How is SSL different from TLS?)
# 587	Standard port open on most firewalls. Supports insecure SMTP and SMTP over TLS. Also performs sender IP address masking and outbound email processing (e.g. automatic email encryption and other services).
# 2025	Nonstandard port open on most firewalls. Supports insecure SMTP and SMTP over TLS
# 6025	Nonstandard port open on most firewalls. Supports insecure SMTP and SMTP over TLS. Also performs sender IP address masking and outbound email processing (e.g. automatic email encryption and other services).
# 6465	Nonstandard port open on most firewalls. Supports SMTP over SSL. Also performs sender IP address masking and outbound email processing.

ENTRYPOINT ["/opt/java/bin/java", "-jar", "/opt/fakeSMTP/2.0/fakeSMTP.jar", "--background", "--output-dir", "/var/mail", "--port", "2025", "--start-server"]