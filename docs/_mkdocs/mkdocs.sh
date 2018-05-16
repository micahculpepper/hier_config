#!/bin/sh

# Automatically create code documentation
sphinx-apidoc -f -o hier_config ../../hier_config

# Remove exisitng code table of contents
rm hier_config.rst

# Create a new code table of contents
cat > hier_config.rst << EOF
.. _hier_config:

=============================================
Hierarchical Configuration Code Documentation
=============================================

.. toctree::
   :maxdepth: 1

EOF

for i in `ls hier_config`; do
  echo "   hier_config/$i" >> hier_config.rst
done

# Create the html files
make clean
make dirhtml

# Sync generated documentation to viewable path
rsync -avz --exclude .env "${PWD}/_build/dirhtml/" "../../docs"
