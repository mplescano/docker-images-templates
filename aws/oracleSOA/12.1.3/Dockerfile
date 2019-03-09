# LICENSE CDDL 1.0 + GPL 2.0
#
# ORACLE DOCKERFILES PROJECT
# --------------------------
# This is the Dockerfile for SOA Suite 12.1.3 Quick Start Distro
# 
# IMPORTANT
# ---------
# The resulting image of this Dockerfile DOES NOT contain a SOA Suite Domain.
# For that, look into the folder 'samples' for an example on how
# to create a domain on a new inherited image.
#
#   docker build --no-cache -t mplescano/oracle-soa:12.1.3.0 .
#   docker run -it --rm mplescano/oracle-soa:12.1.3.0 /bin/bash
#
# REQUIRED FILES TO BUILD THIS IMAGE
# ----------------------------------
# (1) fmw_12.1.3.0.0_soaqs_Disk1_1of1.zip
#     Download the Quick Start installer from http://www.oracle.com/technetwork/middleware/soasuite/downloads/index.html
#	  docker cp D:\Downloads\V37380-01_2of2.zip 735a33289353:/u01/temp
#     ./Disk1/runInstaller -nocheckForUpdates -ignoreSysPrereqs -novalidation -silent -jreloc /opt/jdk -invPtrLoc /u01/temp/oraInst.loc -responseFile /u01/temp/install.file
#	  docker cp D:\mplescano\proyectos\oracleSOA\buildimage\12.1.3\install.file 735a33289353:/u01/temp
#     docker cp D:\mplescano\proyectos\oracleSOA\buildimage\12.1.3\oraInst.loc 735a33289353:/u01/temp
#
#
# HOW TO BUILD THIS IMAGE
# ------------------w-----
# Put all downloaded files in the same directory as this Dockerfile
# Run: 
#      $ sudo docker build -t mplescano/oracle-soa:12.1.3.0 . 
#
# Pull base image
# ---------------
FROM mplescano/oracle-db-xe:11.2

# Maintainer
# ----------
MAINTAINER mplescano@

# Environment variables required for this build (do NOT change)
# -------------------------------------------------------------
#ENV CONFIG_JVM_ARGS -Djava.security.egd=file:/dev/./urandom

# SETUP FILESYSTEM AND ORACLE USER
# ------------------------------------------------------------

# Copy assets
ADD assets /assets
RUN /assets/setup.debian.sh

# Define default command to start bash. 
#it's executed when instantiating a container without arguments..
CMD /usr/sbin/startup.sh && /bin/bash