Prerequisites.
==============

To install ALPSCore, the following is needed:

#) Reasonably new C++ compiler: gcc >= 4.2, Intel >= 10.0,  Clang >= 3.2

#) CMake >= 2.8.12

#) HDF5 library

#) Boost >= 1.54 

Obtaining ALPSCore.
===================

The ALPSCore package can be obtained by following methods:

1. Cloning Git repository at https://github.com/ALPSCore/ALPSCore.git::

     $ git clone https://github.com/ALPSCore/ALPSCore.git

2. Downloading a release tarball from
   https://github.com/ALPSCore/ALPSCore/archive/v0.3.1.tar.gz , e.g: ::

    $ echo 'file(DOWNLOAD https://github.com/ALPSCore/ALPSCore/archive/v0.3.1.tar.gz ./ALPSCore.tar.gz SHOW_PROGRESS)' \
         | cmake -P /dev/stdin 

.. FIXME: URL depends on the release; downloaded archive name depends on the downloader!

3. In a near future, OS-specific packages will be available for download.

The installation procedure.
===========================

.. FIXME: depends on the shell used!

The ALPSCore library uses CMake as its build system. The only
supported builds are out-of-source. 

1. First of all, unpack the tarball and change into the created
   directory: ::

        $ tar -xzf ALPSCore.tar.gz
        $ cd ALPSCore*/

2. Then create a build directory and change to it: ::

        $ mkdir build
        $ cd build

3. Next, generate the ALPSCore build. The simplest build with reasonable
   defaults is generated by: ::

        $ cmake .. -DCMAKE_INSTALL_PREFIX=/where/to/install/ALPSCore

   Troubleshooting:

     a. If your build generation seems to pick up the wrong Boost library,
        the following may help: ::

          $ cmake .. -DBOOST_ROOT=/path/to/boost \
                     -DBOOST_NO_SYSTEM_PATHS=ON \
                     -DBoost_NO_BOOST_CMAKE=ON

     b. To point CMake to the correct location of HDF5 library, add
        ``-DHDF5_ROOT=/path/to/hdf5`` to CMake invocation.

4. Once the build tree successfully generated, perform the build: ::

        $ make

..
   FIXME: More advanced options must be described:
   1. Location of HDF5: using HDF5_DIR environment
   2. Location of Boost: using Boost_DIR environment
   3. Avoiding picking up the wrong Boost
   4. Setting ALPSCore behavior.

.. FIXME: Recommend NOT to use -j with a large number: the build is memory-hungry.

5. Run the testing: ::

        $ make test

6. and install ALPSCore: ::

        $ make install

The ALPScore will be installed in the directory specified in step 3
(``/where/to/install/ALPSCore`` in this example).

How to use ALPSCore
===================

To use ALPSCore, your project must utilize CMake build system. Add the
following lines to your project's ``CMakeLists.txt``: ::

        # Not strictly necessary, but will create executables that are
        # aware of ALPSCore location
        SET(CMAKE_INSTALL_RPATH_USE_LINK_PATH TRUE)
        
        # Request the ALPSCore package:
        find_package(ALPSCore)
        # (optionally, components can be also listed, like this:) 
        # find_package(ALPSCore accumulators params)
        
        # Use ALPSCore_LIBRARIES variable to link to ALPSCore 
        target_link_libraries(your_project_target ${ALPSCore_LIBRARIES})

