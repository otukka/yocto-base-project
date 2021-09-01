# Introduction
Sample custom yocto layer project for Xilinx RFSoC. This uses docker container to build the project. Basic conf files modified from meta-petalinux. Example application can be found in [Embedded-app](https://github.com/otukka/Embedded-app).

# Usage
Run the test file to test if everything works.
 >$ ./test.sh

This will ask for a sudo-password at the end because it installs sdk to /opt/

# Note
All sublayers are not used. This is due to copy-paste nature of this example from the xilinx-petalinux sample project. More refactoring is needed. 