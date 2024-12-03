package test.unit_tests


object compile_rv {
import scala.collection.mutable.ArrayBuffer
  def compileProgram(test: ArrayBuffer[String]): Array[String] = {
    import scala.sys.process._
    import java.io.{PrintWriter, File}
    import java.nio.file.{Files, Paths}
    
    
    val tempFile = "program.s"
    val objFile = "program.o"
    val binFile = "program.bin"
    
    val instructions = test

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

}

object test_addi {
    import compile_rv.compileProgram
    import scala.collection.mutable.ArrayBuffer
  var test1 : ArrayBuffer[String] = ArrayBuffer[String]()
      test1 += "li	gp,2"
      test1 += "li	a3,0"
      test1 += "mv	a4,a3"
      test1 += "li	t2,0"
      test1 += "slt t0,	a4,t2"

  var test2  : ArrayBuffer[String] = ArrayBuffer[String]()
      test2 += "li	gp,2"
      test2 += "li	a3,0"
      test2 += "mv	a4,a3"
      test2 += "li	t2,0"
      test2 += "slt t0,	a4,t2"

  var test3  : ArrayBuffer[String] = ArrayBuffer[String]()
      test3 += "li	gp,3"
      test3 += "li	a3,1"
      test3 += "addi	a4,a3,1"
      test3 += "li	t2,2"
      test3 += "slt t0,	a4,t2"

  var test4  : ArrayBuffer[String] = ArrayBuffer[String]()
      test4 += "li	gp,4"
      test4 += "li	a3,3"
      test4 += "addi	a4,a3,7"
      test4 += "li	t2,10"
      test4 += "slt t0,	a4,t2"
                                  
                                  
  var test5  : ArrayBuffer[String] = ArrayBuffer[String]()
      test5 += "li	gp,5"
      test5 += "li	a3,0"
      test5 += "addi	a4,a3,-2048"
      test5 += "li	t2,-2048"
      test5 += "slt t0,	a4,t2"
                                    
                                    
  var test6  : ArrayBuffer[String] = ArrayBuffer[String]()
      test6 += "li	gp,6"
      test6 += "lui	a3,0x80000"
      test6 += "mv	a4,a3"
      test6 += "lui	t2,0x80000"
      test6 += "slt t0,	a4,t2"
                                     
                                     
  var test7  : ArrayBuffer[String] = ArrayBuffer[String]()
      test7 += "li	gp,7"
      test7 += "lui	a3,0x80000"
      test7 += "addi	a4,a3,-2048"
      test7 += "lui	t2,0x80000"
      test7 += "addi	t2,t2,-2048"
      test7 += "slt t0,	a4,t2"
                                     
  var test8  : ArrayBuffer[String] = ArrayBuffer[String]()
      test8 += "li	gp,9"
      test8 += "lui	a3,0x80000"
      test8 += "addi	a3,a3,-1"
      test8 += "mv	a4,a3"
      test8 += "lui	t2,0x80000"
      test8 += "addi	t2,t2,-1"
      test8 += "slt t0,	a4,t2"
                                     
                                     
  var test9  : ArrayBuffer[String] = ArrayBuffer[String]()
      test9 += "li	gp,10"
      test9 += "lui	a3,0x80000"
      test9 += "addi	a3,a3,-1"
      test9 += "addi	a4,a3,2047"
      test9 += "lui	t2,0x80000"
      test9 += "addi	t2,t2,2046"
      test9 += "slt t0,	a4,t2"
                                     
                                     
  var test10  : ArrayBuffer[String] = ArrayBuffer[String]()
      test10 += "li	gp,11"
      test10 += "lui	a3,0x80000"
      test10 += "addi	a4,a3,2047"
      test10 += "lui	t2,0x80000"
      test10 += "addi	t2,t2,2047"
      test10 += "slt t0,	a4,t2"
                                     
                                     
  var test11  : ArrayBuffer[String] = ArrayBuffer[String]()
      test11 += "li	gp,12"
      test11 += "lui	a3,0x80000"
      test11 += "addi	a3,a3,-1"
      test11 += "addi	a4,a3,-2048"
      test11 += "lui	t2,0x7ffff"
      test11 += "addi	t2,t2,2047"
      test11 += "slt t0,	a4,t2"
                                     
                                     
  var test12  : ArrayBuffer[String] = ArrayBuffer[String]()
      test12 += "li	gp,13"
      test12 += "li	a3,0"
      test12 += "addi	a4,a3,-1"
      test12 += "li	t2,-1"
      test12 += "slt t0,	a4,t2"
                                     
                                     
  var test13  : ArrayBuffer[String] = ArrayBuffer[String]()
      test13+= "li	gp,14"
      test13+= "li	a3,-1"
      test13+= "addi	a4,a3,1"
      test13+= "li	t2,0"
      test13+= "slt t0,	a4,t2"
                                     
                                     
  var test14 : ArrayBuffer[String] = ArrayBuffer[String]()
      test14+= "li	gp,15"
      test14+= "li	a3,-1"
      test14+= "addi	a4,a3,-1"
      test14+= "li	t2,-2"
      test14+= "slt t0,	a4,t2"
                                     
                                     
  var test15 : ArrayBuffer[String] = ArrayBuffer[String]()
      test15+= "li	gp,16"
      test15+= "lui	a3,0x80000"
      test15+= "addi	a3,a3,-1"
      test15+= "addi	a4,a3,1"
      test15+= "lui	t2,0x80000"
      test15+= "slt t0,	a4,t2"
                                     
                                     
  var test16 : ArrayBuffer[String] = ArrayBuffer[String]()
      test16+= "li	gp,17"
      test16+= "li	a1,13"
      test16+= "addi	a1,a1,11"
      test16+= "li	t2,24"
      test16+= "slt t0,	a1,t2"
                                     
                                     
  var test17 : ArrayBuffer[String] = ArrayBuffer[String]()
      test17+= "li	gp,18"
      test17+= "li	tp,0"
      test17+= "li	ra,13"
      test17+= "addi	a4,ra,11"
      test17+= "mv	t1,a4"
      test17+= "addi tp,tp,1"
      test17+= "li	t0,2"
      test17+= "bne tp,t0,FFEC"
      test17+= "li	t2,24"
      test17+= "slt t0,	t1,t2"
                                     
                                     
  var test18 : ArrayBuffer[String] = ArrayBuffer[String]()
      test18+= "li	gp,19"
      test18+= "li	tp,0"
      test18+= "li	ra,13"
      test18+= "addi	a4,ra,10"
      test18+= "nop"
      test18+= "mv	t1,a4"
      test18+= "addi tp,tp,1"
      test18+= "li	t0,2"
      test18+= "bne tp,t0,80000320 "
      test18+= "li	t2,23"
      test18+= "slt t0,	t1,t2"
                                     
                                     
  var test19 : ArrayBuffer[String] = ArrayBuffer[String]()
      test19+= "li	gp,20"
      test19+= "li	tp,0"
      test19+= "li	ra,13"
      test19+= "addi	a4,ra,9"
      test19+= "nop"
      test19+= "nop"
      test19+= "mv	t1,a4"
      test19+= "addi	tp,tp,1"
      test19+= "li	t0,2"
      test19+= "bne	tp,t0,FFE4"
      test19+= "li	t2,22"
      test19+= "slt t0,	t1,t2"
                                     
                                     
  var test20 : ArrayBuffer[String] = ArrayBuffer[String]()
      test20+= "li	gp,21"
      test20+= "li	tp,0"
      test20+= "li	ra,13"
      test20+= "addi	a4,ra,11"
      test20+= "addi	tp,tp,1"
      test20+= "li	t0,2"
      test20+= "bne	tp,t0,FFF0"
      test20+= "li	t2,24"
      test20+= "slt t0,	a4,t2"
                                     
                                     
  var test21 : ArrayBuffer[String] = ArrayBuffer[String]()
      test21 += "li	gp,22"
      test21 += "li	tp,0"
      test21 += "li	ra,13"
      test21 += "nop"
      test21 += "addi	a4,ra,10"
      test21 += "addi	tp,tp,1"
      test21 += "li	t0,2"
      test21 += "bne	tp,t0,800003a0"
      test21 += "li	t2,23"
      test21 += "slt t0,	a4,t2"
                                     
                                     
  var test22  : ArrayBuffer[String] = ArrayBuffer[String]()
      test22 += "li	gp,23"
      test22 += "li	tp,0"
      test22 += "li	ra,13"
      test22 += "nop"
      test22 += "nop"
      test22 += "addi	a4,ra,9"
      test22 += "addi	tp,tp,1"
      test22 += "li	t0,2"
      test22 += "bne	tp,t0,800003c8"
      test22 += "li	t2,22"
      test22 += "slt t0,	a4,t2"
                                     
                                     
  var test23  : ArrayBuffer[String] = ArrayBuffer[String]()
      test23 += "li	gp,24"
      test23 += "li	ra,32"
      test23 += "li	t2,32"
      test23 += "slt t0,	ra,t2"
                                     
                                     
  var test24  : ArrayBuffer[String] = ArrayBuffer[String]()
      test24 += "li	gp,25"
      test24 += "li	ra,33"
      test24 += "addi	zero,ra,50"
      test24 += "li	t2,0"
      test24 += "slt t0,	zero,t2"

  var test25  : ArrayBuffer[String] = ArrayBuffer[String]()
      test25 += "li	gp,8"
      test25 += "li	a3,0"
      test25 += "addi	a4,a3,2047"
      test25 += "li	t2,2047"
      test25 += "slt t0,	a4,t2"

  val tests = ArrayBuffer(test1, test2, test3, test4, test5, test6, test7, test8, test9, test10, test11, test12, test13, test14, test15, test16)

  val sequences = tests.map(e => compileProgram(e))
  
//   sequences.foreach(e => e.foreach(h => println(h)) )
}
