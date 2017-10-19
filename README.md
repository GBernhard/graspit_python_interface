# graspit_python_interface
Build a shared library of GraspIt! to use it as a module in Python.

This interface enables the use of GraspIt! as a Python module. You can find the GraspIt! code in the repository https://github.com/graspit-simulator/graspit

When building this Interface, it includes the previous built shared library of GraspIt!. No changes in the GraspIt! code are necessary. Additional methods may be added in graspit_python_interface.cpp.

This is for development purpose.

 --- Installation ---

1. Prerequisites: 
- Swig: This interface was built and tested with swig version 3.0.
- Python: This interface was used in Python Version 2.7. The Python environment is defined in PY_INCLUDE in the Makefile. The header files and static libraries for python dev must be installed.
- Make: This interface was built using Make utility.
- Ubuntu: This interface was built on Ubuntu 16.04
- GraspIt!: While building, the shared library of GraspIt! is linked. It is necessary, to build GraspIt! before using this interface. For installing GraspIt! see the installation instructions at http://graspit-simulator.github.io/.

2. Building the interface:
- Install necessary prerequisites.
- Adapt the include paths in the Makefile, so it matches your local environment.
- Build the Interface by running make in this directory ($ make)

 --- Remove ---
 
By executing the command "$ make clean" you remove the files created by make.

 --- Using the interface ---

After building, you can use the interface as an common python package:

import graspit_python_interface

interface = graspit_python_interface.GraspitPythonInterface()

interface.startGraspit()
