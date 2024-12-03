package formal

import spinal.core._
import spinal.core.formal._
import nebula.nebulaRVIO

object nebulaFormal extends App {
  
  FormalConfig.withBMC(15).doVerify(new Component {


    val dut = FormalDut(new nebulaRVIO)




  })
  

  
  
  
  
}
