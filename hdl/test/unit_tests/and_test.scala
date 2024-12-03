package test.unit_tests


object and_test {
  import scala.collection.mutable.ArrayBuffer

var test_2 : ArrayBuffer[String] = ArrayBuffer("li	gp,2", "lui	a1,0xff010", "addi	a1,a1,-256" , "lui	a2,0xf0f1",  "addi	a2,a2,-241", "and	a4,a1,a2", "lui	t2,0xf001", "addi	t2,t2,-256"      , "48771c63          	bne	a4,t2,80000644 <fail>")
var test_3 : ArrayBuffer[String] = ArrayBuffer("li	gp,3", "lui	a1,0xff01",  "addi	a1,a1,-16 " , "lui	a2,0xf0f0f", "addi	a2,a2,240 ", "and	a4,a1,a2", "lui	t2,0xf00",  "addi	t2,t2,240 "      , "46771a63          	bne	a4,t2,80000644 <fail>")
var test_4 : ArrayBuffer[String] = ArrayBuffer("li	gp,4", "lui	a1,0xff0",   "addi	a1,a1,255 " , "lui	a2,0xf0f1",  "addi	a2,a2,-241", "and	a4,a1,a2", "lui	t2,0xf0",   "addi	t2,t2,15 "       , "44771863          	bne	a4,t2,80000644 <fail>")
var test_5 : ArrayBuffer[String] = ArrayBuffer("li	gp,5", "lui	a1,0xf00ff", "addi	a1,a1,15  " , "lui	a2,0xf0f0f", "addi	a2,a2,240 ", "and	a4,a1,a2", "lui	t2,0xf000f","bne	a4,t2,80000644 ")
var test_6 : ArrayBuffer[String] = ArrayBuffer("li	gp,6", "lui	a1,0xff010", "addi	a1,a1,-256" , "lui	a2,0xf0f1",  "addi	a2,a2,-241", "and	a1,a1,a2", "lui	t2,0xf001", "addi	t2,t2,-256 "     , "40759663          	bne	a1,t2,80000644 <fail>")
var test_7 : ArrayBuffer[String] = ArrayBuffer("li	gp,7", "lui	a1,0xff01",  "addi	a1,a1,-16 " , "lui	a2,0xf0f0f", "addi	a2,a2,240 ", "and	a2,a1,a2", "lui	t2,0xf00",  "addi	t2,t2,240 "      , "3e761463          	bne	a2,t2,80000644 <fail>")


}
