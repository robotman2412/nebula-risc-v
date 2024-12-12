package nebula.execute

import spinal.core._
import spinal.lib.misc.pipeline.CtrlLink
import nebula.LsuL1._
import nebula.decode.Decoder.USE_STQ
import nebula.decode.YESNO.{Y => Y}
import nebula.decode.Decoder.USE_LDQ
import nebula.LsuL1.RamStoreCmd




case class AGU(node : CtrlLink) extends ExecutionUnit with Area {
  import nebula.dispatch.SrcPlugin._
  

  val logic = new node.Area {
    // while(!loaded) {
    //   haltIt()
    // }
    // while(!stored) {
    //   haltIt()
    // }
    
    

    val memLocation = RS1.asSInt + IMMED.asSInt // FOR LOAD
    val ramFetchCmd = RamFetchCmd()
    val ramStoreCmd = RamStoreCmd()
    val ramFetchRsp = RamFetchRsp()

    ramFetchCmd.address.assignDontCare()
    when(up(USE_LDQ) === Y) {
      ramFetchCmd.address := memLocation.asUInt
    }
    when(up(USE_STQ) === Y) {
      ramStoreCmd.address := (RS1.asSInt + IMMED.asSInt).asUInt
      ramStoreCmd.data    := RS2
    }
    // RESULT := loadedResult(frommeory)


  }
  val storeData = RS2 // (FOR STORE INSTRUCTIONS) // SEND TO DCACHE
}
