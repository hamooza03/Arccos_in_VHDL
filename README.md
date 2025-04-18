## A Short description of the Circuits Function

## 🧠 Project Overview
This VHDL project implements a hardware-based approximation of the `arccos` function using a polynomial approximation method. The design runs on the DE1-SoC FPGA board, where:
- An **8-bit input** is taken from the board switches,
- The **approximated arccosine angle** is calculated,
- The **result is displayed** in decimal on four 7-segment displays.


## ⚙️ Features
- **Polynomial-based arccos approximation**
- **Binary-to-BCD conversion** for human-readable output
- **Ripple blanking** to suppress leading zeroes on displays
- Timing constraints and analysis included for synthesis on FPGA

## 📷 Example Output

Below is an example of the computed arccosine angle when the input is set to `128` (binary `10000000`) using the FPGA switches.

![Arccos Output Example](Images/Output_Example.png)


The result is displayed on the 3 of the 4 7-segment displays (HEX0 to HEX3) because of Ripple Blanking, showing a decimal value that corresponds to the approximated angle in degrees shifted by 10. In reality the number is 60.1 and not 601.


## ✏️ Authors
- [Hamza Abu Alkhair](https://github.com/hamooza03)
- [Omar Moussa](https://github.com/OmarCE11)
- [Hamza Al Farrash]
