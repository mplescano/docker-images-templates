#!/bin/bash
#
#
su - informix -c ". /opt/informix/ol_informix1210.sh && cp -rf \${INFORMIXSQLHOSTS}.std \${INFORMIXSQLHOSTS}" &&
# update sqlhosts with docker hostname
su - informix -c ". /opt/informix/ol_informix1210.sh && sed -i s/%hostname%/`hostname`/ \${INFORMIXSQLHOSTS}" &&
su - informix -c ". /opt/informix/ol_informix1210.sh && chmod 440 \${INFORMIXSQLHOSTS}" &&
su - informix -c ". /opt/informix/ol_informix1210.sh && oninit"