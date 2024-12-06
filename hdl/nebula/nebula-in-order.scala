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
  val rs1Rdata = Bits(32 bits)
  val rs2Rdata = Bits(32 bits)
  val rdAddr = UInt(5 bits)
  val rdWdata = Bits(32 bits)


  val pcRdata = UInt(32 bits)
  val pcWdata = UInt(32 bits)
  
  val memAddr    = UInt(32 bits)           // Memory address accessed
  val memRdata   = Bits(32 bits)           // Data read from memory
  val memWdata   = Bits(32 bits)           // Data written to memory
  val memMask    = Bits(4 bits)            // Memory byte mask

}
class nebulaRVIO() extends Component  {
  
  
  val fetch = CtrlLink()
  val d0 = CtrlLink()
  val dis0 = CtrlLink()
  val rfread0 = CtrlLink()
  val E1 = CtrlLink()
  val wbStage = CtrlLink()
  
  val jumpTarget = UInt(64 bits)
  val PC = Payload(UInt(6 bits)) 
  val PCPLUS4 = Payload(UInt(64 bits))
  val doJump = Bool()

  val fetcher = new fetch.Area {
    val pcReg = Reg(PC) init (0) simPublic()
    up(PC) := pcReg
    // PCPLUS4 := PC + 4
    up.valid := True
    when(up.isFiring) {
      // pcReg := doJump ? (PC + 1) | jumpTarget
      pcReg := PC + 1
    }

    val mem = Mem.fill(64)(Bits(32 bits)) init(Seq.fill(64)(B"0".resized)) simPublic()
    haltWhen(PC === 15)
    
    val instrn = mem.readAsync(PC)

    down(INSTRUCTION) := mem.readAsync(PC)
  }


  // val eus = List(intalu)


  val hazards = Seq(d0,dis0, rfread0, E1, wbStage)

  // val PC = PC(pcNode)
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
  
  
  // val io = new Bundle {
  //   val rvfi = out(new RVFIBundle)
  // }
  
  
  // io.rvfi.valid := True
  // io.rvfi.order := CounterFreeRun(64 bits).value
  // io.rvfi.inst  := fetcher.instrn
  // io.rvfi.trap  := ???
  // io.rvfi.halt  := ???
  
  // io.rvfi.pcRdata := wbStage.up(PC)
  // io.rvfi.pcWdata := fetcher.pcReg
  
  // io.rvfi.rs1Addr := d0.down(Decoder.RS1).asUInt
  // io.rvfi.rs2Addr := d0.down(Decoder.RS2).asUInt
  // io.rvfi.rs1Rdata:= E1.up(RS1)
  // io.rvfi.rs2Rdata:= E1.up(RS2)
  // io.rvfi.rdAddr  := d0.down(Decoder.RD).asUInt
  // io.rvfi.rdWdata := wbStage.up(RESULT)
  
  // io.rvfi.memAddr := ???
  // io.rvfi.memRdata :=
  // io.rvfi.memWdata :=
  // io.rvfi.memMask :=
  


  val f2d = StageLink(fetch.down, d0.up)
  val d2d = StageLink(d0.down, dis0.up)
  val dis2rf = StageLink(dis0.down, rfread0.up)
  val rf2e1 = StageLink(rfread0.down, E1.up)
  val e12wb = StageLink(E1.down, wbStage.up)
  Builder(fetch, d0,dis0, rfread0,E1, wbStage, f2d,d2d, dis2rf, rf2e1, e12wb)

}
