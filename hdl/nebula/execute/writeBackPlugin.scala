package nebula.execute


import spinal.core._
import spinal.lib._
import spinal.lib.misc.pipeline._
import nebula.decode.Decoder._


case class IntWriteBackPlugin(stage : CtrlLink, rfaAddress : UInt(5 bits), rfaEnable : Bool(), rfaData : Bits(32 bits)) extends Area {

  val rfaRD = rfaKeys(RD)

  rfaAddress := rfaRD.PHYS
  rfaEnable  := (rfaRD.ENABLE) && (rfaRD.RFID === U"0")



}
