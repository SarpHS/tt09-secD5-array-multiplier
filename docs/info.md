<!---

This file is used to generate your project datasheet. Please fill in the information below and delete any unused
sections.

You can also include images in this folder and reference them in the markdown. Each image must be less than
512 kb in size, and the combined size of all images must be less than 1 MB.
-->

## How it works
![image](https://github.com/user-attachments/assets/d2ac8684-0a6e-4393-a208-2e1a7de33fc7)

Above is a diagram that represents a 4-bit multiplier, which takes in two 4-bit integers and outputs a single 8-bit integer.

This was created using a manual structural design. We utilized a 1-bit full adder module in our implementation.
* AND-Gates are utilized to multiply each bit of input `m` with each bit of input `q`.
* We align partial products diagonally to mimic that of manual binary multiplication.
* We use 1-bit Full Adders to add products and handle carries.
* The outputs of the Full Adders eventually went to the bits of our output `p` which is an 8-bit integer.

## How to test
Run the Verilog.

## External hardware
N/A
