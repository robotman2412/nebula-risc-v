package test

import spinal.core._
import spinal.lib._
import nebula.LsuL1._
import spinal.lib.fsm._
import spinal.lib.misc.pipeline.CtrlLink


import spinal.core.sim._

class MainMemory(memSize: Int) extends Area {
  
  val wordWidth = 64
  
  val bus = new RamBus()

  val memory = Mem(Bits(wordWidth bits), memSize ) simPublic()
 
  val resizedAddress = bus.ramFetchCmd.payload.address(log2Up(memSize / (wordWidth / 8)) - 1 downto 0) simPublic()
  bus.ramFetchCmd.ready := False
  bus.ramFetchRsp.valid := False
  bus.ramFetchRsp.payload.address.assignDontCare()
  bus.ramFetchRsp.payload.data.assignDontCare()
  
  val controller = new StateMachine {
    val stateA : State = new State with EntryPoint {
      whenIsActive {
        bus.ramFetchCmd.ready := True
        when(bus.ramFetchCmd.valid) {
          goto(stateB)
        }
      }
    }
    val stateB : State = new State {
      whenIsActive {
        bus.ramFetchRsp.valid := True
        bus.ramFetchRsp.payload.data := memory.readSync(resizedAddress) simPublic()
        bus.ramFetchRsp.payload.address := bus.ramFetchCmd.payload.address

        when(bus.ramFetchRsp.ready) {
          goto(stateA)
        }
      }
    }
  }


}

import spinal.core._
import spinal.core.sim._
import nebula.LsuL1._


// Prefetching Logic for Cache
// Simulation Setup
