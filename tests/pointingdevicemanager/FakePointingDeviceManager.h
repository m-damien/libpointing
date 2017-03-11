/* -*- mode: c++ -*-
 *
 * pointing/input/FakePointingDeviceManager.h --
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
     * TODO
     */
    void addDevice(const PointingDeviceDescriptor& desc);

    /**
     * TODO
     */
    void removeDevice(const PointingDeviceDescriptor& desc);

    /**
     * TODO
     */
    static FakePointingDeviceManager* get();

    void callPointingCallbacks(std::string devURI, int dx, int dy, int buttons);

  };
}

#endif