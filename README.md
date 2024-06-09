# Cobra RISC-V

Cobra aims to be a Linux-capable CPU supporting the `RV64IMAFDC_Zicsr_Zifencei` and virtal memory. It will support 32-bit or 64-bit, optionally multiply/divide (M), atomics (A), float (FD) and compressed instructions (C). Cobra will have single in-order issue, out-of-order execution and in-order writeback.

# History

Cobra is the successor to [Boa³²](https://github.com/robotman2412/boa-risc-v), my previous RISC-V CPU. It aims to improve on feature set, performance and the use of standard memory busses (as opposed to Boa's custom memory bus).

# License

This work ("Cobra RISC-V") is licensed under [CERN-OHL-P](https://cern-ohl.web.cern.ch/) v2

If you create an FPGA bitstream, a compiled simulation, a tapeout or other compiled design with a Cobra-RISC-V core, the `marchid` CSR is all the necessary attribution. For this, the value of `marchid` must not be changed and it must be readable by software running in M-mode. It is recommended that any third-party releases of a modified Cobra-RISC-V CPU set the highest bit of `mimpid` to 1 to distinguish from official releases.
