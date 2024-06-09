package nebula.cpu.fetch

// Copyright © 2024, Julian Scheffers, see LICENSE for info

import nebula.cpu._
import nebula.cpu.mem._
import spinal.core._
import spinal.lib._

/** Superscalar instruction fetching unit. */
case class InsnFetcher(cfg: NebulaCfg) extends Component {
    val io = new Bundle {
        /** Program memory interface. */
        val ibus    = master port NebulaMemBus(cfg)
        /** Fetched instructions. */
        val dout    = Vec.fill(cfg.frontendWidth)(master port Stream(FetchedInsn(cfg)))
    }
}
