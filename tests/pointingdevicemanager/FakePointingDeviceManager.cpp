/* -*- mode: c++ -*-
 *
 * pointing/input/FakePointingDeviceManager.cpp --
 *
 * Initial software
 * Authors: Izzatbek Mukhanov
 * Copyright © Inria
 *
 * http://libpointing.org/
 *
 * This software may be used and distributed according to the terms of
 * the GNU General Public License version 2 or any later version.
 *
 */

#include "FakePointingDeviceManager.h"

#include <pointing/utils/TimeStamp.h>
#include "FakeSystemPointingDevice.h"

using namespace pointing;

FakePointingDeviceManager *FakePointingDeviceManager::singleManager = 0;

FakePointingDeviceManager *FakePointingDeviceManager::get()
{
    if (singleManager == NULL)
        singleManager = new FakePointingDeviceManager();
    return singleManager;
}

void FakePointingDeviceManager::processMatching(PointingDeviceData*, SystemPointingDevice*) {}

void FakePointingDeviceManager::addDevice(const PointingDeviceDescriptor& desc)
{
    // PointingDeviceData is deleted inside PointingDeviceManager::unregisterDevice
    PointingDeviceData* pdd = new PointingDeviceData;
    pdd->desc = desc;
    registerDevice(desc.devURI.asString(), pdd);
}

void FakePointingDeviceManager::removeDevice(const PointingDeviceDescriptor& desc)
{
    unregisterDevice(desc.devURI.asString());
}

void FakePointingDeviceManager::callPointingCallbacks(std::string devURI, int dx, int dy, int buttons)
{
    TimeStamp::inttime timestamp = TimeStamp::createAsInt();

    auto it = devMap.find(devURI);
    if (it != devMap.end())
    {
        PointingDeviceData* pdd = it->second;
        for (SystemPointingDevice* device : pdd->pointingList)
        {
            FakeSystemPointingDevice* dev = static_cast<FakeSystemPointingDevice*>(device);
            dev->registerTimestamp(timestamp, dx, dy);
            if (dev->callback)
              dev->callback(dev->callback_context, timestamp, dx, dy, buttons);
        }
    }
}