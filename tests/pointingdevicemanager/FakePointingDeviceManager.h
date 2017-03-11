/* -*- mode: c++ -*-
 *
 * pointing/tests/pointingdevicemanager/FakePointingDeviceManager.h --
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
#ifndef FakePointingDeviceManager_h
#define FakePointingDeviceManager_h

#include <pointing/input/PointingDeviceManager.h>

namespace pointing
{
  /**
   * @brief The FakePointingDeviceManager class is a concrete PointingDeviceManager
   * used for testing and prototyping purposes.
   */
  class FakePointingDeviceManager : public PointingDeviceManager
  {
    friend class FakeSystemPointingDevice;

    void processMatching(PointingDeviceData* pdd, SystemPointingDevice* device) override;

    static FakePointingDeviceManager* singleManager;

  public:
    /**
     * Adds fake physical pointing device and calls DeviceUpdateCallback callback with wasAdded = true.
     * @param desc Parameter that should contain the fake URI and optional description parameters.
     */
    void addDevice(const PointingDeviceDescriptor& desc);

    /**
     * Removes fake physical pointing device and calls DeviceUpdateCallback callback with wasAdded = false.
     * @param desc Parameter that should contain the fake URI and optional description parameters.
     */
    void removeDevice(const PointingDeviceDescriptor& desc);

    /**
     * @return singleton FakePointingDeviceManager object.
     */
    static FakePointingDeviceManager* get();

    /**
     * This method fakes a pointing callback.
     * @param devURI Must correspond to one of the device devURIs listed in FakePointingDeviceManager.
     */
    void callPointingCallbacks(std::string devURI, int dx, int dy, int buttons);

  };
}

#endif