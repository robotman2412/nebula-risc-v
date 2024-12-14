package nebula.cpu.fetch

// Copyright © 2024, Julian Scheffers, see LICENSE for info

import nebula.cpu._
import nebula.util._
import spinal.core._
import spinal.lib._
import spinal.lib.misc.pipeline._



// /** Compacts the instructions from `InsnExtractor` into a contiguous stream. */
// case class InsnCompactor(cfg: NebulaCfg, node: CtrlLink) {
//     import cfg.payload._
    
//     val logic = new node.Area {
//         /** Buffer for instructions not accepted in last fetch packet. */
//         var buf = Vec.fill(cfg.fetchChunks)(Flow(Bits(32 bits)))
        
//         // Extract available instructions.
//         var frag = for (i <- 0 until cfg.frontendWidth) yield Fragment(cfg.fetchChunks)
//         for (i <- 0 until cfg.frontendWidth) {
//             RAW_INSNS(i).valid   := frag(i).io.found.valid
//             RAW_INSNS(i).payload := frag(i).io.found.payload
//         }
//         for (i <- 1 until cfg.frontendWidth) {
//             frag(i).io.frag_in <> frag(i-1).io.frag_out
//         }
//     }
    
//     case class Fragment(width: Int) extends Component {
//         val io = new Bundle {
//             /** Output override. */
//             val out_ovr     = slave  port Flow(FetchData(cfg))
//             /** Remaining instructions to sort through. */
//             val frag_in     = Vec.fill(width)(slave  Flow(FetchData(cfg)))
//             /** Output first found instruction. */
//             val found       = master port Flow(FetchData(cfg))
//             /** Remaining instructions to send to next Fragment. */
//             val frag_out    = Vec.fill(width)(master Flow(FetchData(cfg)))
//         }
        
//         /** All valid signals. */
//         val valid = Bits(width bits)
//         for (i <- 0 until width) {
//             valid(i) := io.frag_in(i).valid
//         }
//         /** First set valid signal. */
//         val first = FirstSetBit(valid)
        
//         // Extraction logic.
//         when (io.out_ovr.valid) {
//             io.found.payload := io.out_ovr.payload
//             io.found.valid   := True
//         } elsewhen (first === B(0, width bits)) {
//             io.found.payload.assignDontCare
//             io.found.valid   := False
//         } otherwise {
//             io.found         := io.frag_in.oneHotAccess(first)
//         }
        
//         // Passthrough logic.
//         for (i <- 0 until width) {
//             io.frag_out(i).payload := io.frag_in(i).payload
//             io.frag_out(i).valid   := io.frag_in(i).valid && (io.out_ovr.valid || !first(i))
//         }
//     }
// }
