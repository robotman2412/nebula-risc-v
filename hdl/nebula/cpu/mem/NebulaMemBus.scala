package nebula.cpu.mem

// Copyright © 2024, Julian Scheffers, see LICENSE for info

import nebula.cpu._
import spinal.core._
import spinal.lib._
import spinal.lib.bus.amba3.ahblite._



object NebulaMemBus {
    val IDLE  = B"00"
    val WRITE = B"01"
    val READ  = B"10"
    val EXEC  = B"11"
}

/**
 * Nebula's CPU-internal memory bus.
 * Latency from request to response is 1 cycle for all signals.
 * If `ready` is low, indicating memory is busy, the next request is held until `ready` goes high.
 * This way, there is no combinatorial dependency between the request and response signals.
 */
case class NebulaMemBus(
    cfg:        NebulaCfg,
    dataOnly:   Boolean = false,
    insnOnly:   Boolean = false
) extends Bundle with IMasterSlave {
    /** Transaction state. */
    val mode    = Bits(2 bits)
    /** Access size in log2(bytes) */
    val asize   = UInt(2 bits)
    /** Memory address. */
    val addr    = UInt(cfg.vaddrWidth bits)
    /** Memory write data. */
    val wdata   = !insnOnly generate Bits(cfg.XLEN bits)
    
    /** Memory response ready. */
    val ready   = Bool()
    /** Memory read / execute data. */
    val rdata   = Bits(cfg.XLEN bits)
    /** Access generated trap. */
    val trap    = Bool()
    /** Generated trap number. */
    val cause   = UInt(5 bits)
    
    def asMaster = {
        out(mode, asize, addr, wdata)
        in(ready, rdata, trap, cause)
    }
    
    /** Adapt to an AHB-lite-3 master. */
    def toAhbLite3: AhbLite3Master = {
        val ahb = master(AhbLite3Master(AhbLite3Config(addr.getWidth, rdata.getWidth)))
        
        // Request translation.
        if (insnOnly) {
            ahb.HTRANS := B"1010"
        } else {
            ahb.HTRANS := B"1011"
        }
        ahb.HMASTLOCK := False
        ahb.HSIZE     := asize.asBits
        ahb.HTRANS    := mode.mux(
            NebulaMemBus.IDLE  -> AhbLite3.IDLE,
            NebulaMemBus.WRITE -> AhbLite3.NONSEQ,
            NebulaMemBus.READ  -> AhbLite3.NONSEQ,
            NebulaMemBus.EXEC  -> AhbLite3.NONSEQ,
        )
        ahb.HWRITE := mode === NebulaMemBus.WRITE
        if (insnOnly) {
            ahb.HWDATA.assignDontCare()
        } else {
            ahb.HWDATA := wdata
        }
        ahb.HADDR := addr
        
        // Response translation.
        ready := ahb.HREADY
        rdata := ahb.HRDATA
        trap  := False
        cause.assignDontCare()
        
        return ahb
    }
}
