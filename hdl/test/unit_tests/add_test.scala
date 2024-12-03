package test.unit_tests

object add_test {
  import scala.collection.mutable.ArrayBuffer
  import compile_rv.compileProgram

  var test1 : ArrayBuffer[String] = ArrayBuffer[String]()
  test1 += "li	gp,2"
  test1 += "li	a1,0"
  test1 += "li	a2,0"
  test1 += "add	a4,a1,a2"
  test1 += "li	t2,0"
  test1 += "slt t0,	a4,t2"
                    
                    
  var test2 : ArrayBuffer[String] = ArrayBuffer[String]()
  test2 += "li	gp,3"
  test2 += "li	a1,1"
  test2 += "li	a2,1"
  test2 += "add	a4,a1,a2"
  test2 += "li	t2,2"
  test2 += "slt t0,	a4,t2"
                    
                    
  var test3 : ArrayBuffer[String] = ArrayBuffer[String]()
  test3 += "li	gp,4"
  test3 += "li	a1,3"
  test3 += "li	a2,7"
  test3 += "add	a4,a1,a2"
  test3 += "li	t2,10"
  test3 += "slt t0,	a4,t2"
                    
                    
  var test4 : ArrayBuffer[String] = ArrayBuffer[String]()
  test4 += "li	gp,5"
  test4 += "li	a1,0"
  test4 += "lui	a2,0xffff8"
  test4 += "add	a4,a1,a2"
  test4 += "lui	t2,0xffff8"
  test4 += "slt t0,	a4,t2"
                    
                    
  var test5 : ArrayBuffer[String] = ArrayBuffer[String]()
  test5 += "li	gp,6"
  test5 += "lui	a1,0x80000"
  test5 += "li	a2,0"
  test5 += "add	a4,a1,a2"
  test5 += "lui	t2,0x80000"
  test5 += "slt t0,	a4,t2"
                    
                    
  var test6 : ArrayBuffer[String] = ArrayBuffer[String]()
  test6 += "li	gp,7"
  test6 += "lui	a1,0x80000"
  test6 += "lui	a2,0xffff8"
  test6 += "add	a4,a1,a2"
  test6 += "lui	t2,0x7fff8"
  test6 += "slt t0,	a4,t2"
                    
                    
  var test7 : ArrayBuffer[String] = ArrayBuffer[String]()
  test7 += "li	gp,8"
  test7 += "li	a1,0"
  test7 += "lui	a2,0x8"
  test7 += "addi	a2,a2,-1 # 7"
  test7 += "add	a4,a1,a2"
  test7 += "lui	t2,0x8"
  test7 += "addi	t2,t2,-1 # 7"
  test7 += "slt t0,	a4,t2"
                    
                    
  var test8 : ArrayBuffer[String] = ArrayBuffer[String]()
  test8 += "li	gp,9"
  test8 += "lui	a1,0x80000"
  test8 += "addi	a1,a1,-1 # 7"
  test8 += "li	a2,0"
  test8 += "add	a4,a1,a2"
  test8 += "lui	t2,0x80000"
  test8 += "addi	t2,t2,-1 # 7"
  test8 += "slt t0,	a4,t2"
                    
  var test9 : ArrayBuffer[String] = ArrayBuffer[String]()
  test9 += "li	gp,10"
  test9 += "lui	a1,0x80000"
  test9 += "addi	a1,a1,-1 # 7"
  test9 += "lui	a2,0x8"
  test9 += "addi	a2,a2,-1 # 7"
  test9 += "add	a4,a1,a2"
  test9 += "lui	t2,0x80008"
  test9 += "addi	t2,t2,-2 # 8"
  test9 += "slt t0,	a4,t2"
                    
                    
  var test10 : ArrayBuffer[String] = ArrayBuffer[String]()
  test10 += "li	gp,11"
  test10 += "lui	a1,0x80000"
  test10 += "lui	a2,0x8"
  test10 += "addi	a2,a2,-1 # 7"
  test10 += "add	a4,a1,a2"
  test10 += "lui	t2,0x80008"
  test10 += "addi	t2,t2,-1 # 8"
  test10 += "slt t0,	a4,t2"
                    
                    
  var test11 : ArrayBuffer[String] = ArrayBuffer[String]()
  test11 += "li	gp,12"
  test11 += "lui	a1,0x80000"
  test11 += "addi	a1,a1,-1 # 7"
  test11 += "lui	a2,0xffff8"
  test11 += "add	a4,a1,a2"
  test11 += "lui	t2,0x7fff8"
  test11 += "addi	t2,t2,-1 # 7"
  test11 += "slt t0,	a4,t2"
                    
                    
  var test12 : ArrayBuffer[String] = ArrayBuffer[String]()
  test12 += "li	gp,13"
  test12 += "li	a1,0"
  test12 += "li	a2,-1"
  test12 += "add	a4,a1,a2"
  test12 += "li	t2,-1"
  test12 += "slt t0,	a4,t2"

  var test13 : ArrayBuffer[String] = ArrayBuffer[String]()
  test13 += "li	gp,14"
  test13 += "li	a1,-1"
  test13 += "li	a2,1"
  test13 += "add	a4,a1,a2"
  test13 += "li	t2,0"
  test13 += "slt t0,	a4,t2"
                    
                    
  var test14 : ArrayBuffer[String] = ArrayBuffer[String]()
  test14 += "li	gp,15"
  test14 += "li	a1,-1"
  test14 += "li	a2,-1"
  test14 += "add	a4,a1,a2"
  test14 += "li	t2,-2"
  test14 += "slt t0,	a4,t2"
                    
                    
  var test15 : ArrayBuffer[String] = ArrayBuffer[String]()
  test15 += "li	gp,16"
  test15 += "li	a1,1"
  test15 += "lui	a2,0x80000"
  test15 += "addi	a2,a2,-1 # 7"
  test15 += "add	a4,a1,a2"
  test15 += "lui	t2,0x80000"
  test15 += "slt t0,	a4,t2"
                    
                    
  var test16 : ArrayBuffer[String] = ArrayBuffer[String]()
  test16 += "li	gp,17"
  test16 += "li	a1,13"
  test16 += "li	a2,11"
  test16 += "add	a1,a1,a2"
  test16 += "li	t2,24"
  test16 += "slt t0,	a1,t2"
                    
                    
  var test17 : ArrayBuffer[String] = ArrayBuffer[String]()
  test17 += "li	gp,18"
  test17 += "li	a1,14"
  test17 += "li	a2,11"
  test17 += "add	a2,a1,a2"
  test17 += "li	t2,25"
  test17 += "slt t0,	a2,t2"
  
  val tests = ArrayBuffer(test1, test2, test3, test4, test5, test6, test7, test8, test9, test10, test11, test12, test13, test14, test15, test16, test17)

  val sequences = tests.map(e => compileProgram(e))
  // sequences.foreach(e => e.foreach(h => println(h)) )





}