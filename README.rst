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
    ./dotfiles/activate.sh
    

Configure shell + tools
-----------------------

Install fish+fisher+theme

.. code-block:: sh

    sudo apt-add-repository ppa:fish-shell/release-3
    sudo apt update
    sudo apt install fish
    curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
    fisher install oh-my-fish/theme-agnoster

Set fish as default shell

.. code-block:: sh

    chsh -s /usr/bin/fish

Install utilities

.. code-block:: sh

    sudo apt install fd-find bat fzf
    alias bat=batcat
    alias fd=fdfind
    
Install Certificate
-------------------

.. code-block:: sh

    sudo wget --no-check-certificate -P /usr/local/share/ca-certificates/ https://sirius.ydesign.se/wiki/pub/IT/InstallRootCert/yDesign_Root_CA.crt
    sudo update-ca-certificates

Install Development Tools
-------------------------

.. code-block:: sh

    sudo apt install cmake ninja-build graphviz g++ dos2unix python3.10-venv -y
    


Installing clang
----------------
    
.. code-block:: sh

    wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | sudo apt-key add -
    sudo add-apt-repository 'deb http://apt.llvm.org/jammy/ llvm-toolchain-jammy-15 main'
    sudo apt update
    sudo apt install clang-15 lld-15 clang-tools-15 libomp-15-dev
    sudo update-alternatives --install /usr/bin/clang clang /usr/bin/clang-15 1500
    sudo update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-15 1500
    sudo update-alternatives --install /usr/bin/lld lld /usr/bin/lld-15 1500

Build libarcher
...............

.. code-block:: sh

    git clone https://github.com/llvm/llvm-project.git
    cd llvm-project/
    git switch release/15.x
    mkdir build
    CC=clang CXX=clang++ cmake -G Ninja ../openmp
    sudo cp tools/archer/libarcher.so /usr/local/lib/libarcher.so



Building older versions of gcc
------------------------------

Installing dependencies
.......................

.. code-block:: sh

    sudo apt install libgmp-dev libmpfr-dev libmpc-dev
    

Building gcc-7.2
................

.. code-block:: sh

    # Download source
    wget https://ftp.gnu.org/gnu/gcc/gcc-7.2.0/gcc-7.2.0.tar.xz
    tar xf gcc-7.2.0.tar.xz
    cd gcc-7.2.0/

    # Build
    mkdir build
    cd build
    CXXFLAGS='-O2' ../configure --disable-multilib --prefix /opt/gcc-7.2 --enable-languages=c,c++,lto --disable-bootstrap --disable-libsanitizer
    make -j4
    sudo make install

Building gcc-4.9.3
..................

.. code-block:: sh

    # Download source
    wget https://ftp.gnu.org/gnu/gcc/gcc-4.9.3/gcc-4.9.3.tar.gz
    tar xf gcc-4.9.3.tar.gz
    cd gcc-4.9.3/
    
    # Patch source
    for f in (grep -Ir -l 'struct ucontext')
        sed -i 's/struct ucontext/ucontext_t/g' $f
    end
    for f in gcc/cp/cfns.gperf gcc/cp/cfns.h
        sed -i 's/const char \* libc_name_p/__attribute__ ((__gnu_inline__)) const char * libc_name_p/g' $f
    end

    # Build 
    mkdir build
    cd build
    CXXFLAGS='-std=gnu++11 -O2' ../configure --disable-multilib --prefix /opt/gcc-4.9.3 --enable-languages=c,c++,lto --disable-bootstrap --disable-libsanitizer
    make -j4
    sudo make install
    
Removing dependencies
.....................

.. code-block:: sh
    
    sudo apt remove libgmp-dev libmpfr-dev libmpc-dev

