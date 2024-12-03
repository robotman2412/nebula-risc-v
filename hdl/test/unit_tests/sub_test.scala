package test.unit_tests


object sub_test {
  import scala.collection.mutable.ArrayBuffer
  import compile_rv.compileProgram
  
  var test2 : ArrayBuffer[String] = ArrayBuffer("li	gp,2", "li	a1,0", "li	a2,0", "sub	a4,a1,a2", "li	t2,0", "slt t0,	a4,t2")
  var test3 : ArrayBuffer[String] = ArrayBuffer("li	gp,3", "li	a1,1", "li	a2,1", "sub	a4,a1,a2", "li	t2,0", "slt t0,	a4,t2")
  var test4 : ArrayBuffer[String] = ArrayBuffer("li	gp,4", "li	a1,3", "li	a2,7", "sub	a4,a1,a2", "li	t2,-4", "slt t0,	a4,t2")
  var test5 : ArrayBuffer[String] = ArrayBuffer("li	gp,5", "li	a1,0", "lui	a2,0xffff8", "sub	a4,a1,a2", "lui	t2,0x8", "slt t0,	a4,t2")
  var test6 : ArrayBuffer[String] = ArrayBuffer("li	gp,6", "lui	a1,0x80000", "li	a2,0", "sub	a4,a1,a2", "lui	t2,0x80000", "slt t0,	a4,t2")
  var test7 : ArrayBuffer[String] = ArrayBuffer("li	gp,7", "lui	a1,0x80000", "lui	a2,0xffff8", "sub	a4,a1,a2", "lui	t2,0x80008", "slt t0,	a4,t2")
  var test8 : ArrayBuffer[String] = ArrayBuffer("li	gp,8", "li	a1,0", "lui	a2,0x8", "addi	a2,a2,-1 # 7fff <_start-0x7fff8001>", "sub	a4,a1,a2", "lui	t2,0xffff8", "addi	t2,t2,1 # ffff8001 <_end+0x7fff6001>", "slt t0,	a4,t2")
  var test9 : ArrayBuffer[String] = ArrayBuffer("li	gp,9", "lui	a1,0x80000", "addi	a1,a1,-1 # 7fffffff <_start-0x1>", "li	a2,0", "sub	a4,a1,a2", "lui	t2,0x80000", "addi	t2,t2,-1 # 7fffffff <_start-0x1>", "slt t0,	a4,t2")
  var test10 : ArrayBuffer[String] = ArrayBuffer("li	gp,10", "lui	a1,0x80000", "addi	a1,a1,-1 # 7fffffff <_start-0x1>", "lui	a2,0x8", "addi	a2,a2,-1 # 7fff <_start-0x7fff8001>", "sub	a4,a1,a2", "lui	t2,0x7fff8", "slt t0,	a4,t2")
  var test11 : ArrayBuffer[String] = ArrayBuffer("li	gp,11", "lui	a1,0x80000", "lui	a2,0x8", "addi	a2,a2,-1 # 7fff <_start-0x7fff8001>", "sub	a4,a1,a2", "lui	t2,0x7fff8", "addi	t2,t2,1 # 7fff8001 <_start-0x7fff>", "slt t0,	a4,t2")
  var test12 : ArrayBuffer[String] = ArrayBuffer("li	gp,12", "lui	a1,0x80000", "addi	a1,a1,-1 # 7fffffff <_start-0x1>", "lui	a2,0xffff8", "sub	a4,a1,a2", "lui	t2,0x80008", "addi	t2,t2,-1 # 80007fff <_end+0x5fff>", "slt t0,	a4,t2")
  var test13 : ArrayBuffer[String] = ArrayBuffer("li	gp,13", "li	a1,0", "li	a2,-1", "sub	a4,a1,a2", "li	t2,1", "slt t0,	a4,t2")
  var test14 : ArrayBuffer[String] = ArrayBuffer("li	gp,14", "li	a1,-1", "li	a2,1", "sub	a4,a1,a2", "li	t2,-2", "slt t0,	a4,t2")
  var test15 : ArrayBuffer[String] = ArrayBuffer("li	gp,15", "li	a1,-1", "li	a2,-1", "sub	a4,a1,a2", "li	t2,0", "slt t0,	a4,t2")
  var test16 : ArrayBuffer[String] = ArrayBuffer("li	gp,16", "li	a1,13", "li	a2,11", "sub	a1,a1,a2", "li	t2,2", "slt t0,	a1,t2")
  var test17 : ArrayBuffer[String] = ArrayBuffer("li	gp,17", "li	a1,14", "li	a2,11", "sub	a2,a1,a2", "li	t2,3", "slt t0,	a2,t2")


  val tests = ArrayBuffer(test2, test3, test4, test5, test6, test7, test8, test9, test10, test11, test12, test13, test14, test15, test16)
  val sequences = tests.map(e => compileProgram(e))

}
