package test

import spinal.core._

import spinal.core.sim._
import nebula.nebulaRVIO

object nebula_inOrder_Verilog {
  def main(args: Array[String]) {
    // SpinalVerilog(new nebulaRVIO())
    SpinalConfig(
      mode = Verilog,
      targetDirectory = "hdl/formal/riscv-formal/cores/nebulaRVIO/"
      // targetDirectory = "core"
    ).generate(new nebulaRVIO())
  }
}
