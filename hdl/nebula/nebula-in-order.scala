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
import nebula.decode.Decoder._
import nebula.dispatch.Dispatch.SENDTOALU
import nebula.dispatch.SrcPlugin.RS1
import nebula.dispatch.SrcPlugin.RS2
import nebula.execute.Execute.RESULT
import nebula.LsuL1.PC.PCVal
import nebula.LsuL1.PC.PCPLUS4

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
  val insn = Bits(32 bits)
  val trap = Bool()
  val halt = Bool()
  val intr = UInt(64 bits)
  val mode = UInt(2 bits)
  val ixl  = UInt(1 bits)

  val rs1_addr = UInt(5 bits)
  val rs2_addr = UInt(5 bits)
  val rs1_rdata = Bits(64 bits)
  val rs2_rdata = Bits(64 bits)
  val rd_addr = UInt(5 bits)
  val rd_wdata = Bits(64 bits)


  val pc_rdata = UInt(64 bits)
  val pc_wdata = UInt(64 bits)
  
  val mem_addr    = UInt(64 bits)           // Memory address accessed
  val mem_rmask    = Bits(64 bits)           // Memory address accessed
  val mem_wmask    = Bits(64 bits)           // Memory address accessed
  val mem_rdata   = Bits(64 bits)           // Data read from memory
  val mem_wdata   = Bits(64 bits)           // Data written to memory

}
class nebulaRVIO() extends Component  {
  
  
  val pcNode = CtrlLink()
  val fetch = CtrlLink()
  val d0 = CtrlLink()
  val dis0 = CtrlLink()
  val rfread0 = CtrlLink()
  val E1 = CtrlLink()
  val wbStage = CtrlLink()
  


  val hazards = Seq(d0,dis0, rfread0, E1, wbStage)

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
  
  val rvfi = out(new RVFIBundle)

  val io = new Bundle {
    // val iMem_rsp_instr = in port Bits(32 bits)
    val icacheramfetchrsp = slave Stream LsuL1.RamFetchRsp()
    val icacheramfetchcmd = master Stream LsuL1.RamFetchCmd()
    // val dcacheramfetchcmd = out port
    // val dcacheramfetchrsp = in port
    // val dcacheramstorecmd = out port
    // val dcacheramstorersp = in port
  }
  
  Icache.ramBus.ramFetchRsp << io.icacheramfetchrsp
  
  io.icacheramfetchcmd << Icache.ramBus.ramFetchCmd
  
  rvfi.valid := wbStage.isValid
  rvfi.order := wbStage(order.ORDER)
  rvfi.insn  := wbStage(INSTRUCTION)
  rvfi.trap  := False
  rvfi.halt  := False
  rvfi.intr := U"0".resized
  rvfi.mode := U"0".resized
  rvfi.ixl  := 1

  rvfi.pc_rdata := wbStage.down(PCVal)
  rvfi.pc_wdata := wbStage.down(PCPLUS4)
  
  rvfi.rs1_addr := wbStage.down(Decoder.RS1).asUInt
  rvfi.rs2_addr := wbStage.down(Decoder.RS2).asUInt
  rvfi.rs1_rdata:= wbStage.down(RS1)
  rvfi.rs2_rdata:= wbStage.down(RS2)
  rvfi.rd_addr  := wbStage.down(Decoder.RD).asUInt
  rvfi.rd_wdata := wbStage.down(RESULT)
  
  rvfi.mem_addr := U"0".resized
  rvfi.mem_rdata :=  B"0".resized
  rvfi.mem_rmask :=  B"0".resized
  rvfi.mem_wdata :=  B"0".resized
  rvfi.mem_wmask :=  B"0".resized

  // io.rvfi.memAddr  := memoryAccessStage.up(ADDR) // Memory address being accessed
  // io.rvfi.memRdata := memoryAccessStage.up(LOAD_DATA) // Data read from memory
  // io.rvfi.memWdata := memoryAccessStage.up(STORE_DATA) // Data written to memory
  // io.rvfi.memMask  := memoryAccessStage.up(MASK) // Byte-enable mask
 



  val pc2f = StageLink(pcNode.down, fetch.up)
  val f2d = StageLink(fetch.down, d0.up)
  val d2d = StageLink(d0.down, dis0.up)
  val dis2rf = StageLink(dis0.down, rfread0.up)
  val rf2e1 = StageLink(rfread0.down, E1.up)
  val e12wb = StageLink(E1.down, wbStage.up)
  Builder(pcNode, fetch, d0,dis0, rfread0,E1, wbStage, pc2f, f2d,d2d, dis2rf, rf2e1, e12wb)

}
