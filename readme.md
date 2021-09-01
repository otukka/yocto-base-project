# STATUS = NOT WORKING
Due to some upstream deprecation issues this project is currently not usable. A conversion to a newer Xilinx release necessary for this this to work.



# Introduction
A template yocto layer project for a Xilinx RFSoC zcu111 evaluation board. This uses a docker container to build the project. Basic conf files are modified from meta-petalinux examples. An example application can be found in [Embedded-app](https://github.com/otukka/Embedded-app).

# Usage
Run the test file to see if everything works.
 >$ ./test.sh

This will ask for a sudo-password at the end because it installs the sdk to /opt. Modify test.sh if this is an unwanted behaviour.

# Notes
1. All sublayers are not used. This is due to copy-paste nature of this example from the xilinx-petalinux sample project. More refactoring is needed. 
2. The xsct is a large file and it is downloaded during docker image build. (size = 1.1 G)
