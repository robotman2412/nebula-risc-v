# Nebula RISC-V CPU

Nebula is a collaborative project aiming to be a Linux-capable CPU supporting the `RV64IMAFDCV_Zicsr_Zifencei` and virtal memory. It will support 32-bit or 64-bit, optionally multiply/divide (M), atomics (A), float (FD), compressed instructions (C) and vector instructions (V). Nebula will be superscalar in-order and may later become out-of-order.

# License

This work ("Nebula RISC-V") is licensed under [CERN-OHL-P](https://cern-ohl.web.cern.ch/) v2

If you create an FPGA bitstream, a compiled simulation, a tapeout or other compiled design with a Nebula-RISC-V core, the `marchid` CSR is all the necessary attribution. For this, the value of `marchid` must not be changed and it must be readable by software running in M-mode. It is recommended that any third-party releases of a modified Nebula-RISC-V CPU set the highest bit of `mimpid` to 1 to distinguish from official releases.
