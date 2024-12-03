package test

//get all rv64ui-p-test.dump
// rv**ui-p-****.dump
// load <tests>
// load <fail_vector>
// parse locations of <fail> and <pass>
// 
// if not fail, go to next test


object test_load extends App {
  import scala.io.Source._
  import scala.util.matching.Regex

  val source = scala.io.Source.fromFile("/home/mahir/fun/CPU/riscv-tests/isa/rv32ui-p-addi.dump")

 val testPattern: Regex = """<test_3>:""".r
 
  // def removeNew(filename : String) = {
  //   var source = scala.io.Source.fromFile(filename)
  //   // source.getLines().foreach(e => println(e)/* ) */
    
  //   val testy = source.getLines().filter(_ matches("<test_3>"))
  //   testy.foreach(e => println(e))
  
  // }
  // val testy = removeNew("/home/mahir/fun/CPU/riscv-tests/isa/rv32ui-p-addi.dump")
  // testy.foreach(e => println(e))
 



  def removeTillTest(filename : String) = {
    val source = scala.io.Source.fromFile(filename)

    var startParsing = false
    var parseFromLine = 0
    var parsedLines = source.getLines().toList

    for((line,int) <- source.getLines().zipWithIndex) {
      if(startParsing) {
        // println(line)
        // parsedLines :+ line
      } else {
        if (testPattern.findFirstIn(line).isDefined) {
          startParsing = true
          parseFromLine = int
          // parsedLines :+ line
        }
      }
    }
    
   try {
      val lines = source.getLines().toList
      // Find the index of the line containing <test_3>
      val parseFromLine = lines.indexWhere(line => testPattern.findFirstIn(line).isDefined)

      // Drop lines up to and including <test_3>
      if (parseFromLine >= 0) lines.drop(parseFromLine) else List.empty[String]
    } finally {
      source.close()
    } 

    print(startParsing)
    println(parseFromLine)

    // source.close()
    parsedLines.drop(123)
    

  }
  val test = removeTillTest("/home/mahir/fun/CPU/riscv-tests/isa/rv32ui-p-addi.dump")
  
  test.foreach(e => println(e))
  
  
  //todo
  // reset core
  // load tests
  // for each test, store each test in a seq
  // for each test compile
  // for each test assert don't branch
}