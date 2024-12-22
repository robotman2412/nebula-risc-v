package nebula


import spinal.core._
import spinal.lib._
import spinal.lib.misc.pipeline._



import spinal.core.sim._
import spinal.lib.sim._

import nebula.decode._
import nebula.dispatch._
import nebula.execute._
import spinal.lib.io.InOutWrapperPlayground.E
import nebula.decode.Decoder.INSTRUCTION
import nebula.dispatch.Dispatch.SENDTOALU
import nebula.dispatch.SrcPlugin.RS1
import nebula.dispatch.SrcPlugin.RS2
import nebula.execute.Execute.RESULT
import nebula.decode.Decoder.LEGAL
import nebula.LsuL1.PC.PCVal

// fetcher area for now for simulation. icache and dcache will be added last
//  rough core pipeline
// 0 : decode 
// 1 : dispatcher
// 2 : rf read
// 3 : E1
// 4 : Writeback

class RVFIBundle extends Bundle {
  val valid = Bool()
  val order = UInt(64 bits)
  val inst = Bits(32 bits)
  val trap = Bool()
  val halt = Bool()
  
  val rs1Addr = UInt(5 bits)
  val rs2Addr = UInt(5 bits)
  val rs1Rdata = Bits(64 bits)
  val rs2Rdata = Bits(64 bits)
  val rdAddr = UInt(5 bits)
  val rdWdata = Bits(64 bits)


  val pcRdata = UInt(64 bits)
  val pcWdata = UInt(64 bits)
  
  val memAddr    = UInt(64 bits)           // Memory address accessed
  val memRdata   = Bits(64 bits)           // Data read from memory
  val memWdata   = Bits(64 bits)           // Data written to memory
  val memMask    = Bits(4 bits)            // Memory byte mask

}
class nebulaRVIO() extends Component  {
  
  
  val pcNode = CtrlLink()
  val fetch = CtrlLink()
  val d0 = CtrlLink()
  val dis0 = CtrlLink()
  val rfread0 = CtrlLink()
  val E1 = CtrlLink()
  val wbStage = CtrlLink()
  


  val hazards = Seq(pcNode, fetch,d0,dis0, rfread0, E1, wbStage)

  val ProgramCounter = LsuL1.PC(pcNode)
  val Icache = LsuL1.ICache(fetch)
  val decoder = Decoder(d0)
  val dispatch = Dispatch(dispatchNode = dis0)
  val intregFile = IntRegFile(rfread0, readSync = true, dataWidth = 64)
  val hazardChecker= HazardChecker(hazards)
  val srcPlugin = SrcPlugin(rfread0)
  // val intalu = IntAlu(E1)
  val executePipeline = ExecutePipeline(E1)
  // PC.jumpCmd << executePipeline.jal.jumpLocation
  // PC.jumpCmd := jaller.jumpLocation
  val wb = IntWriteBackPlugin(wbStage, intregFile)
  
  val order = new pcNode.Area {
    val counter = CounterFreeRun(64 bits)
    val ORDER = Payload(UInt(64 bits))
    ORDER := counter
  }
  
  val io = new Bundle {
    val rvfi = out(new RVFIBundle)
    val instruction = in port Bits(32 bits)
    val iMem_rsp_instr = in port Bits(32 bits)
    val icacheramfetchrsp = (Icache.ramBus.ramFetchRsp)
  }
  
  io.rvfi.valid := wbStage.isValid
  io.rvfi.order := wbStage(order.ORDER)
  io.rvfi.inst  := wbStage(INSTRUCTION)
  io.rvfi.trap  := False
  io.rvfi.halt  := False
  
  io.rvfi.pcRdata := dis0.down(PCVal)
  io.rvfi.pcWdata := E1.down(PCVal)
  
  io.rvfi.rs1Addr := d0.down(Decoder.RS1).asUInt
  io.rvfi.rs2Addr := d0.down(Decoder.RS2).asUInt
  io.rvfi.rs1Rdata:= E1.up(RS1)
  io.rvfi.rs2Rdata:= E1.up(RS2)
  io.rvfi.rdAddr  := d0.down(Decoder.RD).asUInt
  io.rvfi.rdWdata := wbStage.up(RESULT)
  
  io.rvfi.memAddr := U"0".resized
  io.rvfi.memRdata :=  B"0".resized
  io.rvfi.memWdata :=  B"0".resized
  io.rvfi.memMask :=  B"0".resized

  // io.rvfi.memAddr  := memoryAccessStage.up(ADDR) // Memory address being accessed
  // io.rvfi.memRdata := memoryAccessStage.up(LOAD_DATA) // Data read from memory
  // io.rvfi.memWdata := memoryAccessStage.up(STORE_DATA) // Data written to memory
  // io.rvfi.memMask  := memoryAccessStage.up(MASK) // Byte-enable mask
 



  val f2d = StageLink(fetch.down, d0.up)
  val d2d = StageLink(d0.down, dis0.up)
  val dis2rf = StageLink(dis0.down, rfread0.up)
  val rf2e1 = StageLink(rfread0.down, E1.up)
  val e12wb = StageLink(E1.down, wbStage.up)
  Builder(fetch, d0,dis0, rfread0,E1, wbStage, f2d,d2d, dis2rf, rf2e1, e12wb)

}
