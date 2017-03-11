/* -*- mode: c++ -*-
 *
 * pointing/input/FakeSystemPointingDevice.cpp --
 *
 * Initial software
 * Authors: Izzat Mukhanov
 * Copyright © Inria
 *
 * http://libpointing.org/
 *
 * This software may be used and distributed according to the terms of
 * the GNU General Public License version 2 or any later version.
 *
 */

#include "FakeSystemPointingDevice.h"
#include "FakePointingDeviceManager.h"

using namespace pointing;

FakeSystemPointingDevice::FakeSystemPointingDevice(URI uri) : SystemPointingDevice(uri)
{
  FakePointingDeviceManager *man = FakePointingDeviceManager::get();
  man->addPointingDevice(this);
}

FakeSystemPointingDevice::~FakeSystemPointingDevice()
{
  FakePointingDeviceManager::get()->removePointingDevice(this);
}

void callPointingCallbacks()
{
  
}