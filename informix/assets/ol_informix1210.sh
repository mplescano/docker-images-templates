#!/bin/bash
#
#
export INFORMIXDIR=/opt/informix
export INFORMIXSERVER=ol_informix1210
export ONCONFIG=onconfig.ol_informix1210
export INFORMIXSQLHOSTS=/opt/informix/etc/sqlhosts.ol_informix1210
export GL_USEGLU=1
export PATH=${INFORMIXDIR}/bin:${INFORMIXDIR}/extend/krakatoa/jre/bin:${PATH}
