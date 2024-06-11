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
