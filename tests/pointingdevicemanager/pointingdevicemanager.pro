# tests/pointingdevice/pointingdevicemanager.pro --
#
# Initial software
# Authors: Izzat Mukhanov
# Copyright © INRIA

TEMPLATE  = app
CONFIG   += warn_on link_prl testcase
CONFIG   -= app_bundle

QT -= gui
QT += testlib

TARGET = pointingdevicemanager

POINTING = ../..
include($$POINTING/pointing/pointing.pri)

HEADERS += FakePointingDeviceManager.h \
           FakeSystemPointingDevice.h

SOURCES += FakePointingDeviceManager.cpp \
           FakeSystemPointingDevice.cpp

HEADERS   += pointingdevicemanager.h
