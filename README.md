# can-test
CAN bus and CAN adapter test utitilities.

## CAN bus loopback test

Loopback test for CAN can be done on a computer that has two CAN ports. Setup a CAN
bus between the two ports. Have a 120 ohm termination resistor at each end.
See Lab test cable on details on cabling.

In the loopback setup, messages sent out via can0 will be received by can1 and vice versa.

## Lab test cable

For a lab test cable you need
* 2 DB9 connectors
* 1 meter cable
* 2 pcs 120 ohm resistors

Connect Pin 2 to Pin 2 and Pin 7 to Pin 7.

* Pin 2 = CAN_L
* Pin 7 = CAN_H

Connect termination resistor (120 ohm) at each end between Pin 2 and Pin 7. In practice,
a single termination resistor works just as fine in a short one meter Lab test cable.

<https://tekeye.uk/automotive/can-bus-cable-wiring>

## test-sequence.sh

Depedencies: can-utils (canplayer)

Setup: Connect can0 to can1 with a Lab test cable.

To run the test sequence, run

    ./test-sequence.sh

The test sequence will take a couple of minutes to finish. The result will be
"Test OK" or "Test FAILED"
