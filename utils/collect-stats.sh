#!/bin/bash

STATS_DIR=statistics

rm -rf $STATS_DIR
mkdir $STATS_DIR

touch $STATS_DIR/index.html
echo "<html>" > $STATS_DIR/index.html
echo "<body>" >> $STATS_DIR/index.html
echo "<ul>" >> $STATS_DIR/index.html

# get supported products
products=$(echo -e "import ssg.constants\nprint(ssg.constants.product_directories)" | python | sed -s "s/'//g; s/,//g; s/\[//g; s/\]//g")
echo "Supported products: $products"

for product in $products
do
    if [ -d build/$product ]; then
        mkdir -p $STATS_DIR/$product
        if [ -f build/$product/product-statistics/statistics.html ]; then
          cp -rf build/$product/product-statistics $STATS_DIR/$product/product-statistics
          echo "<li><a href=\"$product/product-statistics/statistics.html\">Statistics for product: ${product}</a></li>" >> $STATS_DIR/index.html
        fi
        if [ -f build/$product/profile-statistics/statistics.html ]; then
          cp -rf build/$product/profile-statistics $STATS_DIR/$product/profile-statistics
          echo "<li><a href=\"$product/profile-statistics/statistics.html\">Profile statistics for product: ${product}</a></li>" >> $STATS_DIR/index.html
        fi
    fi
done
echo "</ul>" >> $STATS_DIR/index.html
echo "</body>" >> $STATS_DIR/index.html
echo "</html>" >> $STATS_DIR/index.html

pushd build/guides
touch index.html
echo "<html>" > index.html
echo "<header>" >> index.html
echo "<h1>Right Click to save the guide and open it locally</h1>" >> index.html
echo "</header>" >> index.html
echo "<body>" >> index.html
echo "<ul>" >> index.html
for guide in ssg-*.html
do
    echo "<li><a href=\"${guide}\" download=\"${guide}\">${guide}</a></li>" >> index.html
done
echo "</ul>" >> index.html
echo "</body>" >> index.html
echo "</html>" >> index.html
popd

cp -rf build/guides $STATS_DIR

pushd build/tables
touch index.html
echo "<html>" > index.html
echo "<header>" >> index.html
echo "<h1>Right Click to save the table and open it locally</h1>" >> index.html
echo "</header>" >> index.html
echo "<body>" >> index.html
echo "<ul>" >> index.html
for table in table-*.html
do
    echo "<li><a href=\"${table}\" download=\"${table}\">${table}</a></li>" >> index.html
done
echo "</ul>" >> index.html
echo "</body>" >> index.html
echo "</html>" >> index.html
popd

cp -rf build/tables $STATS_DIR