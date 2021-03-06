# Hardware_Software_compass

The file "soc_system_Lucien_Ewan.qar" contains the entire project in a compressed file. Download this file to run the project in your computer.

This project is part of the Hardware/Software Platforms course given at the Faculty of Engineering of Mons in 2021.
https://web.umons.ac.be/fpms/fr/

The goal of this project is to read the data from a HMC6352 digital compass using a DE0-SoC Board. It's an example of how to handle an entire electronical project.

* Group Members: Drescigh Lucien (lucien.drescigh@student.umons.ac.be) and Gencsek Ewan (ewan.gencsek@student.umons.ac.be)
  
  
 
* Project title: Design of a I2C driver for a digital compass.

This project was implemented with "Quartus II" as software.



### I2C Driver

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

The test bench (I2C_M_TB.vhd) simulates the I2C sensor and the driver by plugging their respective entries together.

### Bloc

The bloc entity (in Bloc.vhd) contains 3 input registers (REG1 , REG2, REG3) and 1 output register (REG_OUT). Also, it contains a sda and a scl. The data read from the compass is to be written in REG_OUT. The input registers are unused in this case.


### Steps
## 1) Make file

We first need to create a file (main.c) to send the compiled project to the FPGA. This code was adapted from a led-driven display and only wants the output of the sensor to display it on the serial output of the FPGA DEO-nano-SoC card. We use the h2p_lw_regout_addr pointer to find the position in degrees.

## 2) Connect the FPGA to the network

To be able to communicate, the card and the PC must be connected to the network via aRJ45 cable, also known as Ethernet cable. The card must then be identified as a root user.

## 3) Transfer executable file to the FPGA

When the connection is established with the FPGA, we can send the the executable file. To do so, we need to open the command prompt and go to the file directory of the project, where the executable file is. Once all these manipulations are done, you can run the executable file with the command ./"executable file name". You should see the result of the C code that you wrote on the Putty prompt. 

### Setup and wiring

Pull-up resistors are used to avoid leaving a floating line in a circuit.

![alt text](https://github.com/CienDrs/Hardware_Software_compass/blob/main/setup.jpg?raw=true)
 

### Results

When we look at the oscilloscope, we can see that the driver calls for the address 42 (the address of the compass). He then performs a write operation (41) followed by a read operation (43). These 3 signals are correct. However, for a strange reason, the compass return the value ff. A hypothesis might be that the driver doesn't have enough time to read the value. An intermediary state could be added in the state machine of Bloc.vhd to set a delay and give enough time to read the values. 

![alt text](https://github.com/CienDrs/Hardware_Software_compass/blob/main/sbus_conf.png?raw=true)



