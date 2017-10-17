#include "graspit_python_interface.h"

#include <iostream>
#include <graspit/graspitApp.h>
#include "graspit/graspitCore.h"
#include "mainWindow.h"
#include "world.h"

#include <qapplication.h>
#include <Inventor/Qt/SoQt.h>

GraspitPythonInterface::GraspitPythonInterface(){
    std::cout << "GraspitPythonInterface: initialize" << std::endl;
};

GraspitPythonInterface::~GraspitPythonInterface(){
    std::cout << "GraspitPythonInterface: destroy" << std::endl;
};

int GraspitPythonInterface::startGraspit(){
    std::cout << "GraspitPythonInterface: start GraspIt!" << std::endl;

    int y = 1;
    char c = 'c';

    char *ptr1 = &c;
    char *ptr2 = new char;

    int argc = y;
    char **argv = &ptr2;
    bool headless = TRUE;

    std::cout << "GraspitPythonInterface: start GraspItApp" << std::endl;
    
    GraspItApp app(argc, argv);
    if (!headless) {
      if (app.splashEnabled()) {
        app.showSplash();
        QApplication::setOverrideCursor(Qt::waitCursor);
      }
    }

    std::cout << "GraspitPythonInterface: start GraspitCore" << std::endl;
    
    GraspitCore core(argc, argv);
    
    QObject::connect(qApp, SIGNAL(lastWindowClosed()), qApp, SLOT(quit()));
  
    if (!headless)
    {
      app.setMainWidget(core.getMainWindow()->mWindow);
      if (app.splashEnabled()) {
        app.closeSplash();
        QApplication::restoreOverrideCursor();
      }
    }
  
    if (!core.terminalFailure()) {
      core.startMainLoop();
    }

    int exitCode = core.getExitCode();

    return exitCode;
};
