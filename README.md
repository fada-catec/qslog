# QsLog - The simple Qt logger

QsLog is an easy to use logger that is based on Qt's QDebug class. Forked from: https://bitbucket.org/razvanpetru/qt-components/wiki/QsLog

There are two branches in this repo: **main** (default branch) and **color_out** (where each logging level have different out color)

## Features
* Six logging levels (from trace to fatal)
* Logging level threshold configurable at runtime.
* Minimum overhead when logging is turned off.
* Supports multiple destinations, comes with file and debug destinations.
* Thread-safe
* Supports logging of common Qt types out of the box.
* Small dependency: just drop it in your project directly.

# Installation guide on Ubuntu

## Dependencies

* Build essentials and cmake
```
sudo apt-get install build-essential cmake
```

* Qt5
```
sudo apt-get install qt5-default
```

## Compillation

On the qslog root folder: 

```
mkdir build && cd build 
```

```
cmake .. -DCMAKE_BUILD_TYPE=Release && make -j{n_proc}
```

## Installation
```
sudo make install
```

If you want to uninstall the package:

```
sudo make uninstall
```
