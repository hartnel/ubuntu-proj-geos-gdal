ARG BASE_IMAGE=ubuntu:20.04

FROM $BASE_IMAGE


RUN apt-get update -y

#install wget
RUN apt install wget -y
# Setting up Postgis Requirements 
# https://docs.djangoproject.com/en/3.2/ref/contrib/gis/install/geolibs/
RUN apt-get install binutils libproj-dev gdal-bin -y

# https:// and http:// removed for wget to work

# Install GEOS (needed by postgis)

ENV GEOS_VERSION=3.9.1

RUN wget download.osgeo.org/geos/geos-$GEOS_VERSION.tar.bz2
RUN tar xjf geos-$GEOS_VERSION.tar.bz2

RUN apt-get install build-essential -y

RUN cd geos-$GEOS_VERSION; ./configure; make; make install


#PROJ needs sqlite3 binaries
RUN apt-get -y install libsqlite3-dev sqlite3
# Install PROJ (needed by postgis)

ENV PROJ_VERSION=8.0.0
ENV PKG_CONFIG_VERSION=0.29

RUN wget download.osgeo.org/proj/proj-$PROJ_VERSION.tar.gz
RUN tar xzf proj-$PROJ_VERSION.tar.gz

#libtiff

RUN apt-get install -y libtiff-tools libtiff5-dev

#pkconfig

RUN apt-get install pkg-config -y

#curl

RUN apt install -y curl libcurl4-gnutls-dev

RUN cd proj-$PROJ_VERSION/data; tar xzf ../../proj-data-X.Y.tar.gz;  cd ..; ./configure; make; make install

# Install GDAL (needed by postgis)

ENV GDAL_VERSION=2.3.1

RUN wget download.osgeo.org/gdal/$GDAL_VERSION/gdal-$GDAL_VERSION.tar.gz
RUN tar xzf gdal-$GDAL_VERSION.tar.gz
RUN cd gdal-$GDAL_VERSION; ./configure; make; make install

