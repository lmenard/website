#!/bin/bash

current_dir=$(pwd)

# -------------------------------------------------------
# GIT ---------------------------------------------------
# -------------------------------------------------------

# Download from GitHub master to 'latest' folder
rm -rf latest
git clone git://github.com/geonetwork/core-geonetwork.git latest
cd latest
git submodule update --init
./git-all checkout master
cd ..
#rm -rf `find latest -type d -name .svn`

# Create folder for 2.10.x branch and checkout v2.10.2
rm -rf 210x
cp -R latest 210x
cd 210x
./git-all checkout -b 2.10.2 remotes/origin/2.10.x
cd ..
#rm -rf `find 210x -type d -name .svn`

# Create folder for 2.6.x branch and checkout v2.6.4
#rm -rf 26x
#cp -R latest 26x
#cd 26x
#./git-all checkout -b 2.6.4 remotes/origin/2.6.x
#cd ..

# -------------------------------------------------------
# Trunk documentation -----------------------------------
# -------------------------------------------------------

# Build javadoc for trunk
cd latest/web
#mvn install
mvn javadoc:javadoc

cd ../jeeves
#mvn install
mvn javadoc:javadoc

# Build website docs for trunk
cd ../docs
mvn install

# -------------------------------------------------------
# 2.10.x documentation ----------------------------------
# -------------------------------------------------------

# Build javadoc for 2.10.x tag
cd $current_dir/210x/web
#mvn install
mvn javadoc:javadoc

cd ../jeeves
#mvn install
mvn javadoc:javadoc

# Build website docs for 2.10.x tag
cd ../docs
mvn install

# -------------------------------------------------------
# 2.6.x documentation ----------------------------------
# -------------------------------------------------------

# Build javadoc for 2.6.x tag
#cd $current_dir/26x/web
#mvn javadoc:javadoc

#cd ../jeeves
#mvn javadoc:javadoc

# Build website docs for 2.6.x tag
#cd ../docs
#mvn install

# -------------------------------------------------------
# geonetwork-opensource website -------------------------
# -------------------------------------------------------

# Build geonetwork-opensource website
# -------------------------------------------------------
cd $current_dir/docsrc
make clean
make html

# Copy GeoNetwork docs to website folder (trunk)
# -------------------------------------------------------
mkdir -p $current_dir/docsrc/build/html/manuals/trunk/eng/developer/apidocs/geonetwork
mkdir -p $current_dir/docsrc/build/html/manuals/trunk/eng/developer/apidocs/jeeves
mkdir $current_dir/docsrc/build/html/manuals/trunk/eng/users

mkdir $current_dir/docsrc/build/html/manuals/trunk/eng/widgets
mkdir $current_dir/docsrc/build/html/manuals/trunk/fra
mkdir $current_dir/docsrc/build/html/manuals/trunk/fra/users

# ... Users
cd $current_dir/latest/docs/eng/users/build
cp -R html/* $current_dir/docsrc/build/html/manuals/trunk/eng/users
cp -R latex/GeoNetworkUserManual.pdf $current_dir/docsrc/build/html/manuals/trunk/eng/users
cd $current_dir/latest/docs/fra/users/build
cp -R html/* $current_dir/docsrc/build/html/manuals/trunk/fra/users

# ... Developer
cd $current_dir/latest/docs/eng/developer/build
cp -R html/* $current_dir/docsrc/build/html/manuals/trunk/eng/developer
cp -R latex/GeoNetworkDeveloperManual.pdf $current_dir/docsrc/build/html/manuals/trunk/eng/developer

# ... Widgets
cd $current_dir/latest/docs/widgets/build
cp -R html/* $current_dir/docsrc/build/html/manuals/trunk/eng/widgets

#javadoc
cd $current_dir/latest/web/target/site
cp -R apidocs/* $current_dir/docsrc/build/html/manuals/trunk/eng/developer/apidocs/geonetwork

cd $current_dir/latest/jeeves/target/site
cp -R apidocs/* $current_dir/docsrc/build/html/manuals/trunk/eng/developer/apidocs/jeeves

# Copy docs to website folder (2.10.x)
# -------------------------------------------------------
mkdir -p $current_dir/docsrc/build/html/manuals/2.10.2/eng/developer/apidocs/geonetwork
mkdir -p $current_dir/docsrc/build/html/manuals/2.10.2/eng/developer/apidocs/jeeves
mkdir $current_dir/docsrc/build/html/manuals/2.10.2/eng/users
mkdir $current_dir/docsrc/build/html/manuals/2.10.2/eng/widgets
mkdir $current_dir/docsrc/build/html/manuals/2.10.2/fra
mkdir $current_dir/docsrc/build/html/manuals/2.10.2/fra/users

# ... Users
cd $current_dir/210x/docs/eng/users/build
cp -R html/* $current_dir/docsrc/build/html/manuals/2.10.2/eng/users
cp -R latex/GeoNetworkUserManual.pdf $current_dir/docsrc/build/html/manuals/2.10.2/eng/users
cd $current_dir/210x/docs/fra/users/build
cp -R html/* $current_dir/docsrc/build/html/manuals/2.10.2/fra/users
cp -R latex/GeoNetworkUserManual.pdf $current_dir/docsrc/build/html/manuals/2.10.2/fra/users

# ... Developer
cd $current_dir/210x/docs/eng/developer/build
cp -R html/* $current_dir/docsrc/build/html/manuals/2.10.2/eng/developer
cp -R latex/GeoNetworkDeveloperManual.pdf $current_dir/docsrc/build/html/manuals/2.10.2/eng/developer

# ... Widgets
cd $current_dir/210x/docs/widgets/build
cp -R html/* $current_dir/docsrc/build/html/manuals/2.10.2/eng/widgets

#javadoc
cd $current_dir/210x/web/target/site
cp -R apidocs/* $current_dir/docsrc/build/html/manuals/2.10.2/eng/developer/apidocs/geonetwork
cd $current_dir/210x/jeeves/target/site
cp -R apidocs/* $current_dir/docsrc/build/html/manuals/2.10.2/eng/developer/apidocs/jeeves

# Copy docs to website folder (2.6.4)
# -------------------------------------------------------
#mkdir -p $current_dir/docsrc/build/html/manuals/2.6.4/eng/developer/apidocs/geonetwork
#mkdir -p $current_dir/docsrc/build/html/manuals/2.6.4/eng/developer/apidocs/jeeves
#mkdir $current_dir/docsrc/build/html/manuals/2.6.4/eng/users

# ... Users
#cd $current_dir/26x/docs/eng/users/build
#cp -R html/* $current_dir/docsrc/build/html/manuals/2.6.4/eng/users
#cp -R latex/GeoNetworkUserManual.pdf $current_dir/docsrc/build/html/manuals/2.6.4/eng/users

# ... Developer
#cd $current_dir/26x/docs/eng/developer/build
#cp -R html/* $current_dir/docsrc/build/html/manuals/2.6.4/eng/developer
#cp -R latex/GeoNetworkDeveloperManual.pdf $current_dir/docsrc/build/html/manuals/2.6.4/eng/developer

#javadoc
#cd $current_dir/26x/web/target/site
#cp -R apidocs/* $current_dir/docsrc/build/html/manuals/2.6.4/eng/developer/apidocs/geonetwork
#cd $current_dir/26x/jeeves/target/site
#cp -R apidocs/* $current_dir/docsrc/build/html/manuals/2.6.4/eng/developer/apidocs/jeeves

