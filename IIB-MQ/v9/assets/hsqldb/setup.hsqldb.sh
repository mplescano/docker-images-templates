#!/bin/bash
#
#
#driver class org.hsqldb.jdbc.JDBCDriver* org.hsqldb.jdbcDriver
#info datasource XA org.hsqldb.jdbc.pool.JDBCXADataSource
cd /assets/hsqldb && \
	unzip ./hsqldb-2.3.4.zip && \
  	useradd --create-home --home-dir /opt/hsqldb hsqldb && \
    mv /assets/hsqldb/hsqldb-2.3.4/hsqldb /opt/hsqldb/2.3.4 && \
    ln -s /opt/hsqldb/2.3.4 /opt/hsqldb/current && \
    cp -f /assets/hsqldb/server.properties /opt/hsqldb/current/data && \
    cp -f /assets/hsqldb/hsqldb.init /etc/init.d/hsqldb && \
    chown -R hsqldb:hsqldb /opt/hsqldb/* && \
    update-rc.d hsqldb defaults &&

rm -rf /assets/hsqldb