ARG BASE_IMAGE=python:3.7

FROM $BASE_IMAGE

ENV PYTHONUNBUFFERED 1
ENV GEOS_VERSION=3.9.1
ENV PROJ_VERSION=8.0.0
ENV PKG_CONFIG_VERSION=0.29
ENV GDAL_VERSION=2.3.1



#Install dependances
RUN apt-get update -y && apt-get -y install binutils libproj-dev gdal-bin wget build-essential libsqlite3-dev sqlite3 libtiff-tools libtiff5-dev pkg-config curl libcurl4-gnutls-dev


#Install GEOS

RUN wget download.osgeo.org/geos/geos-$GEOS_VERSION.tar.bz2 && tar xjf geos-$GEOS_VERSION.tar.bz2 && cd geos-$GEOS_VERSION; ./configure; make; make install

# Install PROJ (needed by postgis)



RUN wget download.osgeo.org/proj/proj-$PROJ_VERSION.tar.gz && tar xzf proj-$PROJ_VERSION.tar.gz && cd proj-$PROJ_VERSION/data; tar xzf ../../proj-data-X.Y.tar.gz;  cd ..; ./configure; make; make install

# Install GDAL (needed by postgis)

RUN wget download.osgeo.org/gdal/$GDAL_VERSION/gdal-$GDAL_VERSION.tar.gz && tar xzf gdal-$GDAL_VERSION.tar.gz && cd gdal-$GDAL_VERSION; ./configure; make; make install

