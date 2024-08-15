package nebula.util

// Copyright © 2024, Julian Scheffers, see LICENSE for info

import spinal.core._



/** Find the first set bit in a bit vector. */
object BCat {
    def apply(arg: Data*): Bits = {
        val total = arg.map(_.getBitsWidth).sum
        val res   = Bits(total bits)
        var pos   = total
        for (thing <- arg) {
            res(pos-1 downto pos-thing.getBitsWidth) := thing.asBits
            pos -= thing.getBitsWidth
        }
        return res
    }
}
