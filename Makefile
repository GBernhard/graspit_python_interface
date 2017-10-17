# https://github.com/swig/swig/blob/master/Lib/python/Makefile.in
# ---------------------------------------------------------------
# SWIG Python Makefile
#
# This file can be used to build various Python extensions with SWIG.
# By default this file is set up for dynamic loading, but it can
# be easily customized for static extensions by modifying various
# portions of the file.
#
#        SRCS       = C source files
#        CXXSRCS    = C++ source files
#        OBJCSRCS   = Objective-C source files
#        OBJS       = Additional .o files (compiled previously)
#        INTERFACE  = SWIG interface file
#        TARGET     = Name of target module or executable
#
# Many portions of this file were created by the SWIG configure
# script and should already reflect your machine.
#----------------------------------------------------------------

INCPATH       = -I/usr/include/ -I/usr/share/qt4/mkspecs/linux-g++-64 -I. -I/usr/include/qt4/QtCore -I/usr/include/qt4/QtGui -I/usr/include/qt4/Qt3Support -I/usr/include/qt4 -I$(GRASPIT)/include/graspit/ -I$(GRASPIT)/src -I$(GRASPIT)/src/Collision -I$(GRASPIT)/include -I$(GRASPIT)/include/graspit/math -I$(GRASPIT)/include/graspit/Planner -I$(GRASPIT)/include/graspit/EGPlanner -I$(GRASPIT)/ui -I$(GRASPIT)/ui/Planner -I$(GRASPIT)/ui/EGPlanner -I$(GRASPIT)/build/include/graspit/ui -I$(GRASPIT)/build/include/graspit/ui/Planner -I$(GRASPIT)/build/include/graspit/ui/EGPlanner -I$(GRASPIT)/include/graspit -I/usr/local/include/graspit/ui -I/usr/lib/x86_64-linux-gnu

DEFINES       = -DQT_NO_DEBUG -DQT_QT3SUPPORT_LIB -DQT3_SUPPORT -DQT_GUI_LIB -DQT_CORE_LIB -DQT_SHARED

SRCS          = 
CXXSRCS       = 
CPPSRCS       = graspit_python_interface.cpp #graspitCore.cpp
OBJCSRCS      =
OBJS          =
INTERFACE     = graspit_python_interface.i
WRAPFILE      = $(INTERFACE:.i=_wrap.cxx)
WRAPOBJ       = $(INTERFACE:.i=_wrap.o)
#TARGET        = @SO@ # Use this kind of target for dynamic loading
TARGET        = _graspit_python_interface.so  # Use this target for static linking

prefix        = #@prefix@
exec_prefix   = #@exec_prefix@

CC            = #@CC@
CXX           = c++
OBJC          = #@CC@ -Wno-import # -Wno-import needed for gcc
CFLAGS        = -fPIC $(DEFINES)
CXXFLAGS      = -fPIC $(DEFINES)
INCLUDES      = 
LIBS          = -lQt3Support -lQtGui -lQtCore

# SWIG Options
#     SWIG      = location of the SWIG executable
#     SWIGOPT   = SWIG compiler options
#     SWIGCC    = Compiler used to compile the wrapper file

SWIG          = swig
SWIGOPT       = -c++ -python -Wall -modern
SWIGCC        = c++ #$(CC)

# SWIG Library files.  Uncomment if rebuilding the Python interpreter
SWIGLIBS      = #-lembed.i

# Rules for creating .o files from source.

COBJS         = $(SRCS:.c=.o)
CXXOBJS       = $(CXXSRCS:.cxx=.o)
CPPOBJS       = $(CPPSRCS:.cpp=.o)
OBJCOBJS      = $(OBJCSRCS:.m=.o)
PYOBJS        = $(CXXSRCS:.cxx=.py) $(CPPSRCS:.cpp=.py) $(SRCS:.c=.py)
ALLOBJS       = $(COBJS) $(CXXOBJS) $(CPPOBJS) $(OBJCOBJS) $(OBJS)

# Command that will be used to build the final extension.
BUILD         = $(SWIGCC)

# Uncomment the following if you are using dynamic loading
CCSHARED      = -shared#@CCSHARED@
BUILD         = $(SWIGCC) $(CCSHARED)#@LDSHARED@

# Uncomment the following if you are using dynamic loading with C++ and
# need to provide additional link libraries (this is not always required).

DLL_LIBS      = -L/usr/local/lib/libgraspit.so -lgraspit #-ldl #-L/usr/local/lib/gcc-lib/sparc-sun-solaris2.5.1/2.7.2 \
	     -L/usr/local/lib -lg++ -lstdc++ -lgcc

# Python installation

PY_INCLUDE    = -I/usr/include/python2.7#-DHAVE_CONFIG_H @PYINCLUDE@
PY_LIB        = #@PYLIB@

# Build libraries (needed for static builds)

LIBM          = #@LIBM@
LIBC          = #@LIBC@
SYSLIBS       = #$(LIBM) $(LIBC) @LIBS@

# Build options

BUILD_LIBS    = $(LIBS) $(DLL_LIBS) # Dynamic loading

# Compilation rules for non-SWIG components

# http://www.ijon.de/comp/tutorials/makefile.html
# Diese Regel besagt, daß jede .o-Datei von der entsprechenden .c-Datei abhängt, und wie sie mit Hilfe des Compilers erzeugt werden kann.
#$<	die erste Abhängigkeit
#$@	Name des targets
#$+	eine Liste aller Abhängigkeiten
#$^	eine Liste aller Abhängigkeiten, wobei allerdings doppelt vorkommende Abhängigkeiten eliminiert wurden.

.SUFFIXES: .c .cxx .m .cpp

%.o: %.c #.c.o:
	# --- 0.1. --- Convert c to o -> %.o: %.c
	$(CC) $(CCSHARED) $(CFLAGS) $(INCLUDES) $(INCPATH) -c $<

%.o: %.cxx #.cxx.o:
	# --- 0.2. --- Convert cxx to o -> %.o: %.cxx with 
	$(CXX) $(CCSHARED) $(CXXFLAGS) $(INCLUDES) $(INCPATH) -c $<

%.o: %.cpp #.cpp.o:
	# --- 0.3. --- Convert cpp to o -> %.o: %.cpp
	$(CXX) $(CCSHARED) $(CXXFLAGS) $(INCLUDES) $(INCPATH) -c $<

%.o: %.m #.m.o:
	# --- 0.4. --- Convert m to o -> %.o: %.m
	$(OBJC) $(CCSHARED) $(CFLAGS) $(INCLUDES) $(INCPATH) -c $<


# ----------------------------------------------------------------------
# Rules for building the extension
# ----------------------------------------------------------------------

all: $(TARGET)

$(WRAPFILE) : $(INTERFACE)
	# --- 1. --- SWIG command for wrapping interface
	$(SWIG) $(SWIGOPT) $(INCPATH) -o $(WRAPFILE) $(SWIGLIBS) $(INTERFACE)

$(WRAPOBJ) : $(WRAPFILE)
	# --- 2. --- Convert the wrapper file into an object file
	$(SWIGCC) $(CFLAGS) -c $(WRAPFILE) $(INCLUDES) $(INCPATH) $(PY_INCLUDE)

$(TARGET): $(WRAPOBJ) $(ALLOBJS)
	# --- 3. --- Convert object file in library
	$(BUILD) $(WRAPOBJ) $(ALLOBJS) $(BUILD_LIBS) $(INCPATH) -o $(TARGET)

	# --- 4. --- Remove build files
	rm -f $(COBJS) $(CXXOBJS) $(CPPOBJS) $(OBJCOBJS) $(WRAPOBJ) $(WRAPFILE)

clean:
	rm -f $(COBJS) $(CXXOBJS) $(CPPOBJS) $(OBJCOBJS) $(WRAPOBJ) $(WRAPFILE) $(TARGET) $(PYOBJS)

print:
	echo COBJS: $(COBJS)
	echo CXXOBJS: $(CXXOBJS)
	echo CPPOBJS: $(CPPOBJS)
	echo OBJCOBJS: $(OBJCOBJS)
	echo PYOBJS: $(PYOBJS)
	echo ALLOBJS: $(ALLOBJS)