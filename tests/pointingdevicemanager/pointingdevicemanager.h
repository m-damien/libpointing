#ifndef POINTING_DEVICE_MANAGER_TEST_H
#define POINTING_DEVICE_MANAGER_TEST_H

#include <QObject>
#include <QtTest/QtTest>
#include <pointing/pointing.h>
#include <iostream>
#include "FakeSystemPointingDevice.h"
#include "FakePointingDeviceManager.h"

using namespace pointing;
using namespace std;

/**
 * As PointingDeviceManager is used only with SystemPointingDevices.
 * We will use instances of SystemPointingDevice and FakePointingDeviceManager.
 */
class PointingDeviceManagerTest : public QObject
{
  Q_OBJECT

  // Initialized at the end of this file.
  static int x;

  static void pointingCallback(void*, TimeStamp::inttime,
       int input_dx, int, int)
  {
    x += input_dx;
  }

private slots:

  void initManager()
  {
    FakePointingDeviceManager* manager = FakePointingDeviceManager::get();
    int size = manager->size();
    QCOMPARE(size, 0);
  }

  void deviceShouldMatch()
  {
    FakePointingDeviceManager* manager = FakePointingDeviceManager::get();
    // We will create a device with Fakeuri.
    FakeSystemPointingDevice* device = new FakeSystemPointingDevice("fakeuri");
    // Active should be false as there is no physical device in the manager matched with our Fake device.
    QCOMPARE(device->isActive(), false);
    // Now, we will add a fake physical device.
    PointingDeviceDescriptor desc;
    desc.devURI = "fakeuri";
    desc.vendor = "foo";
    desc.product = "bar";
    desc.vendorID = 111;
    desc.productID = 222;
    manager->addDevice(desc);
    // Our pointing device should become active.
    QCOMPARE(device->isActive(), true);
    QCOMPARE(device->getVendor(), desc.vendor);
    QCOMPARE(device->getProduct(), desc.product);
    QCOMPARE(device->getVendorID(), desc.vendorID);
    QCOMPARE(device->getProductID(), desc.productID);
    // Now delete the fake physical device.
    manager->removeDevice(desc);
    // Now our pointing device should become inactive again.
    QCOMPARE(device->isActive(), false);
    delete device;
  }

  void pointingCallbacksShouldBeCalled()
  {
    FakePointingDeviceManager* manager = FakePointingDeviceManager::get();
    FakeSystemPointingDevice* device = new FakeSystemPointingDevice("fakeuri");
    device->setPointingCallback(pointingCallback, NULL);
    // Let's create another pointing device with the same URI
    // to make sure that for both of them the callback function is called.
    FakeSystemPointingDevice* device2 = new FakeSystemPointingDevice("fakeuri");
    device2->setPointingCallback(pointingCallback, NULL);
    PointingDeviceDescriptor desc;
    desc.devURI = "fakeuri";
    manager->addDevice(desc);
    int dx = 55;
    x = 0;
    manager->callPointingCallbacks(desc.devURI.asString(), dx, 0, 0);
    // Now, x should be equal to 110, since the callback function should be called twice.
    QCOMPARE(x, 110);
    delete device;
    delete device2;
  }
};

int PointingDeviceManagerTest::x = 0;

#endif // POINTING_DEVICE_MANAGER_TEST_H

QTEST_MAIN(PointingDeviceManagerTest)