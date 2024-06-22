```Scala
type DecodeListType = Seq[(Payload[_ <: BaseType], Any)]
```
Seq of a Payload, associated with Resources

```Scala
abstract class MicroOp(val resources: Seq[Resource]) {
    def key: MaskedLiteral
}
```

```Scala
case class SingleDecoding(
        key: MaskedLiteral,
        override val resources: Seq[Resource]
) extends MicroOp(resources)
```

each MicroOp has a key and a list of resources associated with it

```Scala
class RfAccess extends Nameable
class RfRead extends RfAccess
class RfWrite extends RfAccess

object RS1 extends RfRead with AreaObject
object RS2 extends RfRead with AreaObject
```

```Scala
case class RfResource(rf: RegFileAccess, access: RfAccess) extends Resource
```
RegisterFile Resource. Has the regFile it should access (INT, FP, V) and what of the regfile (RS1, RD etc.)

```Scala
object IntRegFileAccess extends RegFileAccess with AreaObject {
    override def sizeArch: Int = 64
    override def width: Int = 64

    // R-type
    def TypeR(key: MaskedLiteral) = SingleDecoding(
        key = key,
        // resources = List(RS1, RS2, RD).map(this -> _)
        resources = List(
            RfResource(IntRegFileAccess, RS1),
            RfResource(IntRegFileAccess, RS2),
            RfResource(IntRegFileAccess, RD)
        )
    )
}
```
defines RegFileAccess for data type, with the type of OP it is (R-Type, I-Type etc.) and
the list of resources



```Scala
case class AccessKeys(rfa : RfAccess, physWidth : Int, rfMapping : Seq[RegFileAccess]) extends Area {
  // how many bits to access RFAccess def
  val rfIdWidth = log2Up(rfMapping.size)
  // Checks whether given UInt mapping maps to RegFile
  def is(rfs: RegFileAccess, that: UInt) = that === idOf(rfs)
  // gets ID of RegFile
  def idOf(rfs: RegFileAccess) = rfMapping.indexOf(rfs)
  
  val ENABLE = Payload(Bool()) // Enable read for regfile
  val PHYS = Payload(UInt(physWidth bits)) // physical register access.
  val RFID = Payload(UInt(rfIdWidth bits)) // which RegFile
}
```
Keys for accessing a RegFile. Constructor takes RfAccess Type (RfRead(RS1, RS2, RS3) or RfWrite(RD)), physWidth (no. of bits to access a specific register)



```Scala
def microOps : Seq[MicroOp] = ???
def resources = microOps.flatMap(_.resources).distinctLinked
// Linked Hash Set of all RFAccess stuff. So RS1, RS2, VS1, RD etc.
val rfAccesses = mutable.LinkedHashSet[RfAccess]()
resources.foreach{
  case r : RfResource => rfAccesses += r.access
  case _ =>
}
```
TODO:
FlatMap data representation. DistinctLinked Data Representation.
rfAccesses Data Representation
for each RfResource ....




```Scala
  val rfaKeys = mutable.LinkedHashMap[RfAccess, AccessKeys]()
  rfaKeys(RS1) = AccessKeys(RS1, 5, List(IntRegFileAccess, FloatRegFileAccess, VectorRegFileAccess))
  rfaKeys(RS2) = AccessKeys(RS2, 5, List(IntRegFileAccess, FloatRegFileAccess, VectorRegFileAccess))
  rfaKeys(RS3) = AccessKeys(RS3, 5, List(IntRegFileAccess, FloatRegFileAccess, VectorRegFileAccess))
  rfaKeys(RD)  = AccessKeys(RD , 5, List(IntRegFileAccess, FloatRegFileAccess, VectorRegFileAccess)
```
rfaKeys maps an rfAccess to AccessKeys

```Scala

rfaKeys(RS1).ENABLE
rfaKeys(RS1).PHYS
rfaKeys(RS1).RFID


```



```Scala
val decodingSpecs = mutable.LinkedHashMap[Payload[_ <: BaseType], DecodingSpec[_ <: BaseType]]()
```
decodingSpecs maps a Payload value (just a pipelined signal) to some DecodingSpec
```
(Payload -> DecodingSpec)
```

```Scala
class DecodingSpec[T <: BaseType](key : HardType[T])
  val needs = mutable.LinkedHashMap[Masked, Masked]() //key, value
```
where a decoding Spec has  val called Needs, which is just a HashMap that maps keys to values for decoding

```Scala
def addNeeds(key : Masked, value : Masked): this.type = {
  needs.get(key) match {
    case Some(x) => assert(needs(key) == value)
    case None => needs(key) = value
  }
  this
}
```
addNeeds adds a value to the decoding List
```Scala
def build(sel : Bits, coverAll : Iterable[Masked]) : T = {
  val defaultsKeys = mutable.LinkedHashSet[Masked]()
  defaultsKeys ++= coverAll
  defaultsKeys --= needs.keys
  val defaultNeeds = default match {
    case Some(x) => defaultsKeys.map(_ -> x)
    case None => Nil
  }
  val finalSpec = needs ++ defaultNeeds
  Symplify(sel, finalSpec, key.getBitsWidth).as(key)
}
```
build goes through the decoding List (val needs) and uses quine-mclusky to simplify decoding

```Scala
def getDecodingSpec(key: Payload[_ <:BaseType]) = decodingSpecs.getOrElseUpdate(key, new DecodingSpec(key))
def setDecodingDefault(key: Payload[_ <: BaseType], value: BaseType): Unit = {
  getDecodingSpec(key).setDefault(Masked(value))
}
```


```Scala
def DecodeList(e: (Payload[_ <: BaseType], Any)*) = List(e: _*)
```
creats a List for decoding. Specifically a List of Tuples, where Tuples are of the type (Payload[BaseType], Any)


```Scala
def microOps : Seq[MicroOp] = ???
def resources = microOps.flatMap(_.resources).distinctLinked
// Linked Hash Set of all RFAccess stuff. So RS1, RS2, VS1, RD etc.
val rfAccesses = mutable.LinkedHashSet[RfAccess]()
resources.foreach{
  case r : RfResource => rfAccesses += r.access
  case _ =>
}
```
I think resources is a LinkedHashMap of resources. so ()


List(RfResource(IntRegFile,RS1), RfResource(IntRegFile,RS2), RfResource(IntRegFile,RD), RfResource(IntRegFile,RS1), RfResource(IntRegFile,RS2), RfResource(IntRegFile,RD))

to LinkedHashMap
e.g.


resources = Set(RfResource(IntRegFile,RS1), RfResource(IntRegFile,RS2), RfResource(IntRegFile,RD))

rfAccesses is a list of all accesses made to RegFiles. represented something like 

Set(RS1, RS2, RD)



```Scala
case class AccessKeys(rfa : RfAccess, physWidth : Int, rfMapping : Seq[RegFileAccess]) extends Area {
  // how many bits to access RFAccess def
  val rfIdWidth = log2Up(rfMapping.size)
  // Checks whether given UInt mapping maps to RegFile
  def is(rfs: RegFileAccess, that: UInt) = that === idOf(rfs)
  // gets ID of RegFile
  def idOf(rfs: RegFileAccess) = rfMapping.indexOf(rfs)
  
  val ENABLE = Payload(Bool()) // Enable read for regfile
  val PHYS = Payload(UInt(physWidth bits)) // physical register access.
  val RFID = Payload(UInt(rfIdWidth bits)) // which RegFile
}
```

```Scala
val rfaKeys = mutable.LinkedHashMap[RfAccess, AccessKeys]()
for (rfa <- rfAccesses) {
  val physWidth = 5
  val rfMapping = resources.collect{case r : RfResource => r.rf}.toList
  val ak = AccessKeys(rfa, physWidth, rfMapping)
  ak.setPartialName(rfa)
  rfaKeys(rfa) = ak
}
```
rfaKeys = (RS1 -> AccessKeys())



```Scala
val singleDecodings = mutable.LinkedHashSet[SingleDecoding]()
microOps.foreach {
  case sd: SingleDecoding => singleDecodings += sd
}
```

```Scala
val NEED_FPU = Payload(Bool())
val NEED_RM = Payload(Bool())
addMicroOpDecodingDefault(NEED_FPU, False)
addMicroOpDecodingDefault(NEED_RM, False) 
```



```Scala
val encodings = new Area {
  val all = mutable.LinkedHashSet[Masked]()
  // Creates a decoding spec that specifies access to which regfile
  class RfAccessDecoding(val rfa : RfAccess){
    val rfaKey = rfaKeys(rfa)
    val read = new DecodingSpec(Bool()).setDefault(zero)
    val rfid = new DecodingSpec(UInt(rfaKey.rfIdWidth bits))
  }
  val rfAccessDec = rfAccesses.map(rfa => rfa -> new RfAccessDecoding(rfa)).toMapLinked()

  for (e <- singleDecodings) {
    val key = Masked(e.key)
    all += key
    
    e.resources.foreach {
      case r: RfResource => {
        val dec = rfAccessDec(r.access)
        dec.read.addNeeds(key, Masked.one)
        // wtf does this do?
        dec.rfid.addNeeds(key, Masked(dec.rfaKey.idOf(r.rf), (1 << dec.rfaKey.rfIdWidth)-1))
      }
      case PC_READ => 
      case LQ => 
      case FPU => addMicroOpDecoding(e, NEED_FPU, True)
      case RM => addMicroOpDecoding(e, NEED_RM, True)
      case SQ =>
    }
  } 
  // what in the fuck are these numbers?
  // if(Riscv.RVF || Riscv.RVD){
  //   for (x <- 1 to 3; y <- 1 to 3) getDecodingSpec(NEED_FPU).addNeeds(Masked(0x73 + (x << 20) + (y << 12), 0xFFF0307Fl), Masked.one)
  // }
}
```
all is a linkedHashSet of every OP key
RfAccessDecoding is a class that takes an RfAccess, gets an rfaKey (from rfaKeys( which is a linkedHashMap which maps each RfAccess, with AccessKeys(which allow the uop to access specific register))) a read Bool and an rfid UInt
```Scala
      val rfAccessDec: mutable.LinkedHashMap[RfAccess, RfAccessDecoding] = mutable.LinkedHashMap(RS1 -> new RfAccessDecoding(RS1), RS2 -> new RfAccessDecoding(RS2), RD -> new RfAccessDecoding(RD))
```
rfAccessDec maps each rfAccesses(LinkedHashSet of RfAccess) with an RfAccessDecoding into a LinkedHashMap
for each singleDecodings += key
for each resource in each singleDecodings it gets its RfAccessDecoding and sets the read(enable) value to Masked.one in its decodingSpec and sets its rfid 
for FPU it adds a MicroOpDecoding (e, NEED_FPU, True)
```Scala
  def addMicroOpDecoding(microOp: MicroOp, decoding: DecodeListType) = {
    val op = Masked(microOp.key)
    for ((key, value) <- decoding) {
      getDecodingSpec(key).addNeeds(op, Masked(value))
    }
  }
  def addMicroOpDecoding[T <: BaseType](microOp: MicroOp, key : Payload[T], value: T) : Unit = addMicroOpDecoding(microOp, DecodeList(key -> value))
``` 



  
```Scala
val predictionSpec = new Area {
  val branchKeys = List(Rv32i.BEQ).map(e => Masked(e.key))
  val jalKeys = List(Rv32i.JAL).map(e => Masked(e.key))
  val any = new DecodingSpec(Bool()).setDefault(Masked.zero)

  any.addNeeds(branchKeys ++ jalKeys, Masked.one)
}
```



```Scala
val someLaneLogic = new node.Area {
  for (rfa <- rfAccesses) {
    val keys = rfaKeys(rfa)
    val dec = encodings.rfAccessDec(rfa)
    keys.ENABLE := dec.read.build(Decode.INSTRUCTION, encodings.all)
    keys.RFID   := dec.rfid.build(Decode.INSTRUCTION, encodings.all)
    keys.PHYS   := Decode.INSTRUCTION(rfa match {
      case RS1 => 19 downto 15
      case RS2 => 24 downto 20
      case RS3 => 31 downto 27
      case RD => 11 downto 7
    }).asUInt
  }
}
```






































