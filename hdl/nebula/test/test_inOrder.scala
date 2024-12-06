package nebula.test

import spinal.core._

import spinal.core.sim._
import nebula.nebulaRVIO
import nebula.test.risc_compile.loadRegInitZipped
import nebula.test.risc_compile.loadRegFinal

object nebula_inOrder_Verilog {
  def main(args: Array[String]) {
    SpinalVerilog(new nebulaRVIO())
  }
}

object risc_compile extends App {
  val source = scala.io.Source.fromFile("/home/mahir/fun/CPU/riscv-torture/output/test.S")

  def loadBinInit(filename: String)= {
    val source = scala.io.Source.fromFile(filename)
    try {
      source.getLines()
        .dropWhile(!_.contains("pseg_0:"))  // Skip until reg_init
        .drop(1)  // Skip the reg_init line
        .takeWhile(!_.contains("j reg_dump"))  // Take until reg_execute
        .filter(_.nonEmpty)  // Remove empty lines
        
    } finally {
      source.close()
    }
    // source.toSeq
  } 
  def loadRegFinal(filename: String) = {
    val source = scala.io.Source.fromFile(filename)
    try {
      source.getLines()
        .dropWhile(!_.contains("xreg_output_data:"))
        .drop(1)
        .takeWhile(!_.contains("Memory Blocks"))
        .filter(_.nonEmpty)
        .map(line => line.split("0x").last)
    }
    finally {
      source.close()
    }
  }
  def loadRegInitZipped(filename: String) = {
    val source = scala.io.Source.fromFile(filename)
    try {
      source.getLines()
        .dropWhile(!_.contains("xreg_init_data:"))
        .drop(1)
        .takeWhile(!_.contains("RVTEST_DATA_BEGIN"))
        .filter(_.nonEmpty)
        .map(line => line.split("0x").last)
    }
    finally {
      source.close()
    }
  }
  import scala.sys.process._
  import scala.io.Source
  import java.io.{File, PrintWriter}
  import java.nio.file.{Files, Paths}

  def compileProgram(filename: String): Array[String] = {
    val tempFile = "program.s"
    val objFile = "program.o"
    val binFile = "program.bin"
    
    val instructions = loadBinInit(filename).toSeq

    try {
      // Write all instructions to the temporary assembly file
      val writer = new PrintWriter(tempFile)
      writer.println(".text")
      instructions.foreach(writer.println)
      writer.close()

      // Assemble the program
      val assembleCommand = Seq("riscv64-unknown-elf-as", tempFile, "-o", objFile)
      if (assembleCommand.! != 0) throw new RuntimeException("Assembly failed.")

      // Extract raw binary using objcopy
      val objCopyCommand = Seq("riscv64-unknown-elf-objcopy", "-O", "binary", objFile, binFile)
      if (objCopyCommand.! != 0) throw new RuntimeException("Objcopy failed.")

      // Convert binary to hex format using hexdump
      val hexdumpCommand = Seq("hexdump", "-ve", "/4 \"%08x\\n\"", binFile)
      val hexOutput = hexdumpCommand.!!.trim.split("\n")

      hexOutput
    } finally {
      // Clean up temporary files
      Files.deleteIfExists(Paths.get(tempFile))
      Files.deleteIfExists(Paths.get(objFile))
      Files.deleteIfExists(Paths.get(binFile))
    }
  }
  val initinstr = loadBinInit("/home/mahir/fun/CPU/riscv-torture/output/test.S")


  // initinstr.foreach(e => println(e))
  val hexes = compileProgram("/home/mahir/fun/CPU/riscv-torture/output/test.S")
  // hexes.foreach(e => println(e))
  // initinstr.foreach(e => println(e))
  val initReg = loadRegInitZipped("/home/mahir/fun/CPU/riscv-torture/output/test.S")
  initReg.foreach(e => println(e))
  val endReg = loadRegFinal("/home/mahir/fun/CPU/riscv-torture/output/test.S")
  // endReg.foreach(e => println(e))
}

object test_in_order extends App {
  SimConfig.withWave.compile(new nebulaRVIO).doSim{ dut =>
    
    // val bins = risc_compile.compileProgram("/home/mahir/fun/CPU/riscv-torture/output/test.S").zipWithIndex
    // val initReges = loadRegInitZipped("/home/mahir/fun/CPU/riscv-torture/output/test.S")
    // val endReges = loadRegFinal("/home/mahir/fun/CPU/riscv-torture/output/test.S")
    dut.clockDomain.forkStimulus(10)
    // bins.foreach(e => dut.fetcher.mem.setBigInt(e._2, BigInt(e._1, 16)))
    // initReges.foreach(e => print(e))
    sleep(1)
    // initReges.zipWithIndex.foreach(e => dut.intregFile.reggy.mem.setBigInt(e._2, BigInt(e._1, 16)))
    // initReges.zipWithIndex.foreach(e => assert(dut.intregFile.reggy.mem.getBigInt(e._2) == BigInt(e._1,16), println(s"got ${dut.intregFile.reggy.mem.getBigInt(e._2)}, expected ${BigInt(e._1,16)}")))
    // initReges.zipWithIndex.foreach(e => println(s"got ${dut.intregFile.reggy.mem.getBigInt(e._2)}, expected ${BigInt(e._1,16)}"))
    // initReges.zipWithIndex.foreach(e => println(s"expected ${BigInt(e._1,16).toString()}"))

    // dut.intregFile.reggy.mem.setBigInt(1, 0x0)
    sleep(1)
    dut.clockDomain.waitSampling(5)
    // initReges.zipWithIndex.foreach(e => dut.intregFile.reggy.mem.setBigInt(e._2, BigInt(e._1, 16)))
    dut.clockDomain.waitSampling(2000)
    // for(x <- 0 to 31) {
    //   println(dut.intregFile.reggy.mem.getBigInt(x))
    // }
    
    // initReges.foreach(e => println(s"expected ${BigInt(e,16)}"))
    // val int = dut.test_signals_node(down(IS_INT))
    // print(int)
    // println(dut.fetcher.pcReg.toBigInt)
    // println(dut.io.is_alu.toBoolean)
    // println(dut.io.rs1.toBigInt)
    // println(dut.io.rs2.toBigInt)
    // println(dut.io.result.toBigInt)
    // println(dut.intregFile.reggy.mem.getBigInt(1))
    
    // println(dut.fetcher.mem.getBigInt(0))
    // println(dut.fetcher.mem.getBigInt(1))
    // println(dut.fetcher.mem.getBigInt(2))
    // println(dut.fetcher.mem.getBigInt(3))
    // println(dut.fetcher.mem.getBigInt(4))
    
    // endReges.zipWithIndex.foreach(e => assert(dut.intregFile.reggy.mem.getBigInt(e._2) == BigInt(e._1, 16),s"Failed: got ${dut.intregFile.reggy.mem.getBigInt(e._2)}, expected ${BigInt(e._1, 16)}"))
    
    // endReges.zipWithIndex.foreach(e => println(s"got x${e._2} ${dut.intregFile.reggy.mem.getBigInt(e._2)}, expected x${e._2} ${BigInt(e._1, 16)}"))
  
  }
}


object test_addi_seq extends App {
  SimConfig.withWave.compile(new nebulaRVIO).doSim{ dut =>
    dut.clockDomain.forkStimulus(10)

    import test.unit_tests.test_addi._
    
    var testIndex =0
  
    
    sequences.foreach(e => {
      for(i <- 0 to 31){dut.intregFile.reggy.mem.setBigInt(i, BigInt("0"))}
      e.zipWithIndex.foreach{e => dut.fetcher.mem.setBigInt(e._2, BigInt(e._1,16)); testIndex=e._2}
      dut.clockDomain.waitSampling(100)
      println(dut.intregFile.reggy.mem.getBigInt(5))
      // assert(dut.intregFile.reggy.mem.getBigInt(5) == 0, s"failed at test ${testIndex}")
      dut.clockDomain.assertReset()
      sleep(2)
      dut.clockDomain.deassertReset()
    })
    
    // for(i <- 0 to 31){dut.intregFile.reggy.mem.setBigInt(i, BigInt("0"))}
    // sequences(10).zipWithIndex.foreach(e => dut.fetcher.mem.setBigInt(e._2, BigInt(e._1, 16)))
    // // sequences(10).zipWithIndex.foreach(e => println(e._1))
    // dut.clockDomain.waitSampling(200)
    // println(dut.intregFile.reggy.mem.getBigInt(5))

    /// DO TO TEST 25
  }
}


object test_add_seq extends App {
  SimConfig.withWave.compile(new nebulaRVIO).doSim{ dut =>
    dut.clockDomain.forkStimulus(10)

    import test.unit_tests.add_test._
    
    sequences.foreach(e => e.zipWithIndex.foreach(e =>  {
      dut.fetcher.mem.setBigInt(e._2, BigInt(e._1,16))
      sleep(1)
      dut.clockDomain.waitSampling(50)
      assert(dut.intregFile.reggy.mem.getBigInt(5) == 0, s"failed at test ${e._2}")
      println(dut.intregFile.reggy.mem.getBigInt(5) == 0)
    }))

    /// DO TO TEST 25
  }
}

object test_sub_seq extends App {
  SimConfig.withWave.compile(new nebulaRVIO).doSim{ dut =>
    dut.clockDomain.forkStimulus(10)

    import test.unit_tests.sub_test._
    
    sequences.foreach(e => e.zipWithIndex.foreach(e =>  {
      dut.fetcher.mem.setBigInt(e._2, BigInt(e._1,16))
      sleep(1)
      dut.clockDomain.waitSampling(50)
      assert(dut.intregFile.reggy.mem.getBigInt(5) == 0, s"failed at test ${e._2}")
      println(dut.intregFile.reggy.mem.getBigInt(5) == 0)
    }))

    /// DO TO TEST 25
  }
}
