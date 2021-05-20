# Hardware_Software_compass


This project is part of the Hardware/Software Platforms course given at the Faculty of Engineering of Mons in 2021.
https://web.umons.ac.be/fpms/fr/

The goal of this project is to read the data from a HMC6352 digital compass using a DE0-SoC Board. It's an example of how to handle an entire electronical project.

* Group Members: Drescigh Lucien and Gencsek Ewan
  lucien.drescigh@student.umons.ac.be
  ewan.gencsek@student.umons.ac.be
  

* Project title: Design of a I2C driver for a digital compass.

This project was implemented with "Quartus II" as software.



###I2C Driver

The file I2C_M uses most of the components we use in this project:

* clk: the device's clock. It must be connected to the DE0-nano SoC card.
* ena: must be set to '1' to enable the device.
* addr: the target slave's address (in this case: the compass).
* rw: the read/write data variable. In this case, it is forced to '0' since we will only read the data.
* busy: makes sure the state machine finished its current task before starting another one.
* sda: serial data outpu of the I2C_M bus.
* scl: serial clock output of the I2C_M bus. 

The state machine is shown on the figure below:

![alt text](https://github.com/CienDrs/Hardware_Software_compass/blob/main/state%20machine.jpeg?raw=true)


### Test bench for the compass

The test bench simulates the I2C sensor and the driver by plugging their respective entries together.


