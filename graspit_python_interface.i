// graspit_python_interface.i Graspit-Python-Interface
%module graspit_python_interface

//// include if function head with (int argc, char **argv) present
//%include <argcargv.i>
//%apply (int ARGC, char **ARGV) { (size_t argc, const char **argv) } 

%{
#include "graspit_python_interface.h"
//// include if direct acces of GraspitCore necessary
//#include <graspit/graspitCore.h>
%}

//// include if function head with (int argc, char **argv) present
//%inline %{
//int mainc(size_t argc, const char **argv) { return (int)argc; }
//const char* mainv(size_t argc, const char **argv, int idx) { return argv[idx]; }
//%} 

%include "graspit_python_interface.h"

//// include if direct acces of GraspitCore necessary
//%include <graspit/graspitCore.h>
