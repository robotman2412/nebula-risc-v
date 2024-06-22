MicroOp creates Classes of Resources that interact with the regfile. 
N.B. I may add more than just regfile access control. TBD.
Each object is a type of regfile access (read/write , which regfile etc.)
Effectively initial decode control signals


```Scala
object IntRegFileAccess extends RegFileAccess with AreaObject {
  def TypeR(key : MaskedLiteral) = SingleDecoding(
    key = key, 
    resources = List(
      RfResource(IntRegFileAccess, RS1),
      RfResource(IntRegFileAccess, RS2),
      RfResource(IntRegFileAccess, RD)
    )
  )
}
  
```
for Integer Ops, defines Type of instructions (TypeR in this case) which takes in a key, and creates 
a list of resources associated with the uop

```Scala
val ADD                = TypeR(M"0000000----------000-----0110011")
```

definition of the instr here. associates the ADD instruction with TypeR

```scala
type DecodeListType = Seq[(Payload[_ <: BaseType], Any)]
```
```scala
case class AccessKeys(rfa : RfAccess, physWidth : Int, rfMapping : Seq[RegFileAccess]) extends Area {
  val rfIdWidth = log2Up(rfMapping.size)
  def is(rfs: RegFileAccess, that: UInt) = that === idOf(rfs)
  def idOf(rfs: RegFileAccess) = rfMapping.indexOf(rfs)

  val ENABLE = Payload(Bool()) // Enable read for regfile
  val PHYS = Payload(UInt(physWidth bits)) // physical register access.
  val RFID = Payload(UInt(rfIdWidth bits)) // which RegFile
}
``` 
### Decoding Spec explainer

```Scala
class DecodingSpec[T <: BaseType](key : HardType[T])

  val needs = mutable.LinkedHashMap[Masked, Masked]() //key, value

```
HashMap of all Key/Value pairs for decoding

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
maps selection Bits to Ops



