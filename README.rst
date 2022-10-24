Setup of a new machine
======================

Start with an update
--------------------

.. code-block:: sh

   sudo apt update
   sudo apt upgrade


Clone dotfiles repo
-------------------

.. code-block:: sh

    git clone https://github.com/pgerell/dotfiles.git
    for f in dotfiles/*; do ln -s -f  dotfiles/`basename $f` .`basename $f`; done
    

Install Fish
------------

.. code-block:: sh

    sudo apt-add-repository ppa:fish-shell/release-3
    sudo apt update
    sudo apt install fish
    
Oh-my-fish
..........

.. code-block:: sh

    curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
    
Set fish as default shell

.. code-block:: sh

    chsh -s /usr/bin/fish


Install Development Tools
-------------------------

.. code-block:: sh

    sudo apt install cmake ninja-build graphviz g++ -y
    

Building older versions of gcc
------------------------------

Installing dependencies
.......................

.. code-block:: sh

    sudo apt install libgmp-dev
    sudo apt install libmpfr-dev
    sudo apt install libmpc-dev
    

Building gcc-7.2
................

.. code-block:: sh

    # Download source
    wget https://ftp.gnu.org/gnu/gcc/gcc-7.2.0/gcc-7.2.0.tar.xz
    tar xvf gcc-7.2.0.tar.xz
    cd gcc-7.2.0/
    
    # Apply patches from:
    #   https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=4abc46b51af5751
    #   https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=71b55d45e4304f5
    
    mkdir build
    cd build
    ../configure --disable-multilib --prefix /opt/gcc-7.2 --enable-languages=c,c++,lto --disable-bootstrap
    make -j4
    sudo make install

Building gcc-4.9.3
..................

.. code-block:: sh

    # Download source
    wget https://ftp.gnu.org/gnu/gcc/gcc-4.9.3/gcc-4.9.3.tar.gz
    tar xvf gcc-4.9.3.tar.gz
    cd gcc-4.9.3/
    
    # Apply patches
    #   Add -std=gnu++11 in gcc/Makefile.in
    #   Add __attribute__ ((__gnu_inline__)) to signature of libc_name_p in gfns.gperf and gfns.h
    #   Replace struct ucontext with ucontext_t
    
    mkdir build
    cd build
    ../configure --disable-multilib --prefix /opt/gcc-4.9.3 --enable-languages=c,c++,lto --disable-bootstrap --disable-libsanitizer
    make -j4
    sudo make install
    
